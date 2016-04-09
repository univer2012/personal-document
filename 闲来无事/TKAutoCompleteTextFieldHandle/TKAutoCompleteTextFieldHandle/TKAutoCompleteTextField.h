//
//  TKAutoCompleteTextField.h
//  TKAutoCompleteTextFieldHandle
//
//  Created by huangaengoln on 15/12/2.
//  Copyright (c) 2015年 huangaengoln. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TKAutoCompleteTextField;

@protocol TKAutoCompleteTextFieldDataSource <NSObject>

@optional
-(CGFloat)autoCompleteTextField:(TKAutoCompleteTextField *)textField heightForsuggestionView:(UITableView *)suggestionView;

-(NSInteger)autoCompleteTextField:(TKAutoCompleteTextField *)textField numberOfVisibleRowInSuggestionView:(UITableView *)suggestionView;

@end

@protocol TKAutoCompleteTextFieldDelegate <NSObject>

-(void)autoCompleteTextField:(TKAutoCompleteTextField *)textField didSelectSuggestion:(NSString *)suggestion;
-(void)autoCompleteTextField:(TKAutoCompleteTextField *)textField didFillAutoCompleteWithSuggestion:(NSString *)suggestion;

@end

@interface TKAutoCompleteTextField : UITextField
// ui
@property(nonatomic,strong,readwrite)UITableView *suggestionView;
@property(nonatomic,weak)UIView *overView;
@property(nonatomic,assign)CGFloat marginLeftTextPlaceholder;
@property(nonatomic,assign)CGFloat marginTopTextPlaceholder;
//options
@property(nonatomic,assign)BOOL enableAutoComplete;
@property(nonatomic,assign)BOOL enableStrictFirstMatch;
@property(nonatomic,assign)BOOL enablePreInputSearch;
// delegate
@property(nonatomic,weak)id<TKAutoCompleteTextFieldDataSource>autoCompleteDataSource;
@property(nonatomic,weak)id<TKAutoCompleteTextFieldDelegate>autoCompleteDelegate;
@property(nonatomic,strong)NSArray *suggestions;
@property(nonatomic,strong)NSMutableArray *matchSuggestions;

@end
