//
//  TKAutoCompleteTextField.m
//  TKAutoCompleteTextFieldHandle
//
//  Created by huangaengoln on 15/12/2.
//  Copyright (c) 2015年 huangaengoln. All rights reserved.
//

#import "TKAutoCompleteTextField.h"

static NSInteger kDefaultNumberOfVisibleRowInSuggestionView =3;
static CGFloat kDefaultHeightForRowInSuggestionView=30.f;
static CGFloat kBufferHeightForSuggestionView=15.0f;

static NSString *kCellIdentifier=@"cell";
static NSString *kObserverKeyMatchSuggestions=@"matchSuggestions";
static NSString *kObserverKeyBorderStyle=@"borderStyle";
static NSString *kObserverKeyEnableAutoComplete=@"enableAutoComplete";
static NSString *kObserverKeyEnableStrictFirstMatch=@"enableStrictFirstMatch";
static NSString *kObserverKeyEnablePreInputSearch=@"enablePreInputSearch";

static CGFloat kDefaultLeftMarginTextPlaceholder=5.f;
static CGFloat kDefaultToopMarginTextPlaceholder=0.f;

@interface TKAutoCompleteTextField ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong,readwrite)UITableView *suggesitonView;
@property(nonatomic,strong)NSOperationQueue *queue;
@property(nonatomic,assign,getter=isInputFromSuggesion)BOOL inputFromSuggestin;

@end

@implementation TKAutoCompleteTextField
#pragma mark - Initialize
-(instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialize];
    }
    return self;
}
-(void)initialize {
    self.suggestions=[NSArray new];
    self.matchSuggestions=[NSMutableArray array];
    self.queue=[NSOperationQueue new];
    self.inputFromSuggestin=NO;
    self.enableAutoComplete=YES;
    self.enableStrictFirstMatch=NO;
    self.enablePreInputSearch=NO;
    self.marginLeftTextPlaceholder=kDefaultLeftMarginTextPlaceholder;
    self.marginTopTextPlaceholder=kDefaultToopMarginTextPlaceholder;
    [self configureSuggestionView];
}
-(void)dealloc {
    [self stopObserving];
    [self removeSuggesionView];
    self.matchSuggestions=nil;
}

#pragma mark - Observation
// 开始观察
-(void)startObserving {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:self];
    [self addObserver:self forKeyPath:kObserverKeyMatchSuggestions options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:kObserverKeyBorderStyle options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:kObserverKeyEnableAutoComplete options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:kObserverKeyEnableStrictFirstMatch options:NSKeyValueObservingOptionNew context:nil];
}

-(void)stopObserving {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    @try {
        [self removeObserver:self forKeyPath:kObserverKeyMatchSuggestions];
        [self removeObserver:self forKeyPath:kObserverKeyBorderStyle];
        [self removeObserver:self forKeyPath:kObserverKeyEnableAutoComplete];
        [self removeObserver:self forKeyPath:kObserverKeyEnableStrictFirstMatch];
    }
    @catch (NSException *exception) {
        //wasn't observing anyway
    }
    @finally {
        
    }
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath compare:kObserverKeyMatchSuggestions]==NSOrderedSame) {
        [self didChangeMatchSuggestions];
    } else if ([keyPath compare:kObserverKeyBorderStyle]==NSOrderedSame) {
//        [self ]
    } else if ([keyPath compare:kObserverKeyEnableAutoComplete]==NSOrderedSame) {
        [self didChagngeEnableAutoComplete];
    } else if ([keyPath compare:kObserverKeyEnableStrictFirstMatch]==NSOrderedSame) {
        [self didChangeEnableStrictFirstMatch];
    } else if ([keyPath compare:kObserverKeyEnablePreInputSearch]==NSOrderedSame) {
        [self didChangeEnablePreInputSearch];
    }
}
#pragma mark -Event
-(BOOL)becomeFirstResponder {
    [self startObserving];
    if ([self enablePreInputSearch]) {
        [self searchSuggestionWithInput:self.text];
    }
    return [super becomeFirstResponder];
}
-(BOOL)resignFirstResponder {
    [self stopObserving];
    [self removeSuggesionView];
    return [super resignFirstResponder];
}

#pragma mark - 监听的 执行方法
-(void)textFieldDidChangeNotification:(NSNotification *)noti {
    if ([self isInputFromSuggesion]) {
        self.inputFromSuggestin=NO;
        return;
    }
    [self cancelSearchOperation];
    [self searchSuggestionWithInput:self.text];
}

-(void)didChangeMatchSuggestions {
    if (!self.enableAutoComplete) {
        return;
    }
    __weak typeof(self) weakSelf=self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf suggestionView:weakSelf.suggesitonView updateFrameWithSuggestions:weakSelf.matchSuggestions];
        weakSelf.suggesitonView.hidden=NO;
        [weakSelf.suggesitonView reloadData];
    });
}
-(void)didChangeTextFieldBorderStyle {
    [self configureSuggestionViewForBorderStyle:self.borderStyle];
    __weak typeof(self) weakSelf=self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.suggesitonView reloadData];
    });
}
// 能自动完成
-(void)didChagngeEnableAutoComplete {
    if (self.enableAutoComplete) {
        if ([self isFirstResponder]) {
            [self startObserving];
        }
    } else {
        [self cancelSearchOperation];
        [self stopObserving];
        [self removeSuggesionView];
    }
}
// 能严格第一匹配
-(void)didChangeEnableStrictFirstMatch {
    if ([self isFirstResponder]) {
        [self cancelSearchOperation];
        [self searchSuggestionWithInput:self.text];
    }
}
// 能预先输入查询
-(void)didChangeEnablePreInputSearch {
    if ([self isFirstResponder]) {
        [self cancelSearchOperation];
        [self searchSuggestionWithInput:self.text];
    }
}

#pragma mark - fetch suggestion
// 取消查询操作
-(void)cancelSearchOperation {
    [self.queue cancelAllOperations];
    [self.matchSuggestions removeAllObjects];
}
// 查询建议
-(void)searchSuggestionWithInput:(NSString *)input {
    NSBlockOperation *operation=[[NSBlockOperation alloc]init];
    __weak NSBlockOperation *weakOperation=operation;
    __weak typeof(self) weakSelf=self;
    NSArray *suggestions=self.suggestions;
    NSMutableArray *resultSuggestions=[NSMutableArray array];
    [operation addExecutionBlock:^{
        if (weakOperation.isCancelled) return ;
        if (input.length>0) {
            @autoreleasepool {
                [suggestions enumerateObjectsUsingBlock:^(NSString *suggestion, NSUInteger idx, BOOL *stop) {
                    NSRange range=[[suggestion lowercaseString] rangeOfString:[input lowercaseString]];
                    if (range.location!=NSNotFound) {
                        if (weakSelf.enableStrictFirstMatch && range.location>0) {
                            return ;
                        } else {
                            [resultSuggestions addObject:suggestion];
                        }
                    }
                }];
            }
        } else if ([self enablePreInputSearch]) {
            [resultSuggestions addObjectsFromArray:suggestions];
        }
    }];
    [operation setCompletionBlock:^{
        if (weakOperation.isCancelled) return ;
        weakSelf.matchSuggestions=resultSuggestions;
    }];
}

#pragma mark - suggestionView
// 配置 建议视图
-(void)configureSuggestionView {
    CGRect frame=self.frame;
    UITableView *suggestionView=[[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
    suggestionView.rowHeight=frame.size.height?:kDefaultHeightForRowInSuggestionView;
    suggestionView.delegate=self;
    suggestionView.dataSource=self;
    suggestionView.scrollEnabled=YES;
    suggestionView.hidden=YES;
    self.suggestionView=suggestionView;
}
// 建议视图 更新 frame
-(void)suggestionView:(UITableView *)suggestionView updateFrameWithSuggestions:(NSArray *)suggestions {
    CGRect frame=suggestionView.frame;
    frame.size.height=[self heightForSuggestionView:suggestionView suggestionsCount:suggestions.count];
    suggestionView.frame=frame;
}
// 建议视图的 高
-(CGFloat)heightForSuggestionView:(UITableView *)suggestionView suggestionsCount:(NSInteger)count {
    if (self.enablePreInputSearch) {
        return count* suggestionView.rowHeight;
    }
    return (count+1) * suggestionView.rowHeight;
}
// 展示建议视图
-(void)showSuggestionView {
    [self configureSuggestionViewForBorderStyle:self.borderStyle];
    if (_overView) {
        CGPoint pt=[_overView convertPoint:self.frame.origin fromView:self.superview];
        _suggesitonView.frame=CGRectMake(pt.x, pt.y+self.frame.size.height, _suggesitonView.frame.size.width, _suggesitonView.frame.size.height);
        [_overView addSubview:_suggesitonView];
    } else {
        [self.superview bringSubviewToFront:self];
        [self.superview insertSubview:self.suggestionView belowSubview:self];
    }
    self.suggestionView.userInteractionEnabled=YES;
}
// 移除 建议视图
-(void)removeSuggesionView {
    [self.suggestionView removeFromSuperview];
}
-(void)configureSuggestionViewForBorderStyle:(UITextBorderStyle)borderStyle {
    switch (borderStyle) {
        case UITextBorderStyleRoundedRect:
            [self setBorderStyleRoundRect];
            break;
        case UITextBorderStyleBezel:
            [self setBorderStyleBezel];
            break;
        case UITextBorderStyleLine:
            [self setBorderStyleLine];
            break;
        case UITextBorderStyleNone:
            [self setBorderStyleNone];
            break;
    }
}
//
-(void)setBorderStyleRoundRect {
    CGFloat offsetHeight=self.frame.size.height;
    [self.suggestionView.layer setCornerRadius:6.0];
    [self.suggestionView setScrollIndicatorInsets:UIEdgeInsetsMake(offsetHeight, 0, 0, 0)];
    [self.suggestionView setContentInset:UIEdgeInsetsMake(offsetHeight, 0, 0, 0)];
    [self.suggestionView.layer setBorderWidth:0.5];
    [self.suggestionView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
}
-(void)setBorderStyleBezel {
    CGFloat offsetHeight=self.frame.size.height;
    [self.suggestionView.layer setCornerRadius:0.0];
    [self.suggestionView setScrollIndicatorInsets:UIEdgeInsetsMake(offsetHeight, 0, 0, 0)];
    [self.suggestionView setContentInset:UIEdgeInsetsMake(offsetHeight, 0, 0, 0)];
    [self.suggestionView.layer setBorderWidth:0.5];
    [self.suggestionView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
}
-(void)setBorderStyleLine {
    CGFloat offsetHeight=self.frame.size.height;
    [self.suggestionView.layer setCornerRadius:0.0];
    [self.suggestionView setScrollIndicatorInsets:UIEdgeInsetsMake(offsetHeight, 0, 0, 0)];
    [self.suggestionView setContentInset:UIEdgeInsetsMake(offsetHeight, 0, 0, 0)];
    [self.suggestionView.layer setBorderWidth:0.5];
    [self.suggestionView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
}
-(void)setBorderStyleNone {
    CGFloat offsetHeight=self.frame.size.height;
    [self.suggestionView.layer setCornerRadius:0.0];
    [self.suggestionView setScrollIndicatorInsets:UIEdgeInsetsZero];
    CGRect frame=self.suggestionView.frame;
    frame.origin.y=self.frame.origin.y + offsetHeight;
    self.suggestionView.frame=frame;
    [self.suggestionView.layer setBorderWidth:0.5];
    [self.suggestionView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
}

-(CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, self.marginLeftTextPlaceholder, self.marginTopTextPlaceholder);
}
-(CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, self.marginLeftTextPlaceholder, self.marginTopTextPlaceholder);
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count=self.matchSuggestions.count;
    if (count) {
        [self showSuggestionView];
    }
    return count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[self.suggestionView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
    }
    if (self.matchSuggestions.count > indexPath.row) {
        cell.textLabel.text=self.matchSuggestions[indexPath.row];
        cell.textLabel.font=self.font;
    }
    return cell;
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *suggestion=self.matchSuggestions[indexPath.row];
    if ([self.autoCompleteDelegate respondsToSelector:@selector(autoCompleteTextField:didSelectSuggestion:)]) {
        [self.autoCompleteDelegate autoCompleteTextField:self didSelectSuggestion:suggestion];
    }
    self.text=suggestion;
    self.inputFromSuggestin=YES;
    [self.suggestionView deselectRowAtIndexPath:indexPath animated:NO];
    self.matchSuggestions=[NSMutableArray array];
    
    if ([self.autoCompleteDelegate respondsToSelector:@selector(autoCompleteTextField:didFillAutoCompleteWithSuggestion:)]) {
        [self.autoCompleteDelegate autoCompleteTextField:self didFillAutoCompleteWithSuggestion:suggestion];
    }
}


//-(BOOL)enablePreInputSearch {
//    
//}




@end
