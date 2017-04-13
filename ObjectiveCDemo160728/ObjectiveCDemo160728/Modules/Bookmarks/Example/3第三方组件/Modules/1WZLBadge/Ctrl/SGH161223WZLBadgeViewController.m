//
//  SGH161223WZLBadgeViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2016/12/23.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//
/*
 插件来自：https://github.com/weng1250/WZLBadge
 */
#import "SGH161223WZLBadgeViewController.h"
#import "UIView+WZLBadge.h"
#import "UIView+Frame.h"

@interface SGH161223WZLBadgeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataItems;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SGH161223WZLBadgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat y = NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0 ? 20 : 0;
    CGRect frame = CGRectMake(0, y, self.view.width, self.view.height);
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.userInteractionEnabled = YES;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.tableView];
    
    self.dataItems = [[NSMutableArray alloc] initWithCapacity:0];
    [self initItems];
    
}
#pragma mark -- private methods
- (void)configCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    UIView *view = (UIView *)self.dataItems[section][row];
    view.y = 10;
    view.middleX = cell.width / 2;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [cell.contentView addSubview:view];
    } else {
        [cell addSubview:view];
    }
    //configure cell title
    NSArray *subtitles = @[@"red dot style:", @"new style:", @"number style:"];
    cell.detailTextLabel.text = subtitles[row];
}

#pragma mark -- delegate of tableview
- (void)initItems
{
    NSMutableArray *staticBadges = [NSMutableArray array];
    NSMutableArray *dynamicBadges = [NSMutableArray array];
    
    WBadgeStyle styles[] = {WBadgeStyleRedDot, WBadgeStyleNew, WBadgeStyleNumber};
    for (NSInteger i = 0; i < 3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 40, 40);
        [btn setImage:[UIImage imageNamed:@"WZLBadgeLogo"] forState:UIControlStateNormal];
        btn.layer.cornerRadius = btn.width / 2;
        [btn showBadgeWithStyle:styles[i] value:9999 animationType:WBadgeAnimTypeNone];
        [staticBadges addObject:btn];
    }
    
    WBadgeAnimType animations[] = {WBadgeAnimTypeScale, WBadgeAnimTypeBreathe, WBadgeAnimTypeShake};
    for (NSInteger i = 0; i < 3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 40, 40);
        [btn setImage:[UIImage imageNamed:@"WZLBadgeLogo"] forState:UIControlStateNormal];
        btn.layer.cornerRadius = btn.width / 2;
        [btn showBadgeWithStyle:styles[i] value:9999 animationType:animations[i]];
        [dynamicBadges addObject:btn];
    }
    [self.dataItems addObject:staticBadges];
    [self.dataItems addObject:dynamicBadges];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataItems count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dataItems objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
                             //dequeueReusableHeaderFooterViewWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellID];
    }
    [self configCell:cell indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIView *view = (UIView *)self.dataItems[indexPath.section][indexPath.row];
    [view clearBadge];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray *headTitles = @[@"badge with not any animation", @"badge with animations"];
    return headTitles[section];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section == [self.dataItems count] - 1) {
        return @"Select cell to clear badge.";
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
