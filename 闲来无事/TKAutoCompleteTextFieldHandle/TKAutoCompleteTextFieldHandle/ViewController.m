//
//  ViewController.m
//  TKAutoCompleteTextFieldHandle
//
//  Created by huangaengoln on 15/12/2.
//  Copyright (c) 2015年 huangaengoln. All rights reserved.
//

#import "ViewController.h"
#import "TKAutoCompleteTextField.h"

@interface ViewController ()<TKAutoCompleteTextFieldDataSource,TKAutoCompleteTextFieldDelegate>

@property(nonatomic,weak)TKAutoCompleteTextField *sampleOne;
@property(nonatomic,weak)TKAutoCompleteTextField *sampleTwo;
@property(nonatomic,weak)TKAutoCompleteTextField *sampleThree;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpViews];
    
    self.sampleOne.suggestions=[self resource];
    self.sampleOne.enableStrictFirstMatch=NO;
    
    self.sampleTwo.suggestions=[self resource];
    self.sampleTwo.enableStrictFirstMatch=YES;
    self.sampleTwo.autoCompleteDelegate=self;
    self.sampleTwo.autoCompleteDataSource=self;
    self.sampleTwo.marginLeftTextPlaceholder=2;
    
    self.sampleThree.suggestions=[self prefecture];
    self.sampleThree.enableStrictFirstMatch=NO;
    self.sampleThree.enablePreInputSearch=YES;
}
-(void)setUpViews {
    // 1
    TKAutoCompleteTextField *sampleOne=[[TKAutoCompleteTextField alloc]initWithFrame:CGRectMake(20, 60, CGRectGetWidth(self.view.frame)-2*20, 35)];
    /* UITextBorderStyleNone,
     UITextBorderStyleLine,
     UITextBorderStyleBezel,
     UITextBorderStyleRoundedRect  */
    self.sampleOne=sampleOne;
    sampleOne.borderStyle=UITextBorderStyleRoundedRect;
    [self.view addSubview:sampleOne];
    UILabel *sampleOneLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(sampleOne.frame), CGRectGetWidth(sampleOne.frame), 30)];
    sampleOneLabel.text=@"Sample 1";
    [self.view addSubview:sampleOneLabel];
    
    // 2
    TKAutoCompleteTextField *sampleTwo=[[TKAutoCompleteTextField alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(sampleOneLabel.frame), CGRectGetWidth(sampleOneLabel.frame), 35)];
    sampleTwo.placeholder=@"Large font";
    sampleTwo.font=[UIFont systemFontOfSize:20];
    sampleTwo.borderStyle=UITextBorderStyleLine;
    self.sampleTwo=sampleTwo;
    [self.view addSubview:sampleTwo];
    UILabel *sampleTwoLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(sampleTwo.frame), CGRectGetWidth(sampleTwo.frame), 30)];
    sampleTwoLabel.text=@"Sample 2 (large)";
    [self.view addSubview:sampleTwoLabel];
    
    // 3
    TKAutoCompleteTextField *sampleThree=[[TKAutoCompleteTextField alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(sampleTwoLabel.frame), CGRectGetWidth(sampleTwoLabel.frame), 35)];
    sampleThree.borderStyle=UITextBorderStyleNone;
    sampleThree.placeholder=@"type Japanese";
    self.sampleThree=sampleThree;
    [self.view addSubview:sampleThree];
    UILabel *sampleThreeLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(sampleThree.frame), CGRectGetWidth(sampleThree.frame), 30)];
    sampleThreeLabel.text=@"Sample 3 (border none)";
    [self.view addSubview:sampleThreeLabel];
    
}

-(NSArray *)resource {
    static dispatch_once_t onceToken;
    static NSArray *__instance=nil;
    dispatch_once(&onceToken, ^{
        __instance=[self loadArray];
    });
    return __instance;
}
-(NSArray *)loadArray {
    return [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"NYY" ofType:@"plist"]];
}
-(NSArray *)prefecture {
    static NSArray *__instance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance=[self loadPrefecture];
    });
    return __instance;
}
-(NSArray *)loadPrefecture {
    return [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Japanese" ofType:@"plist"]];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.sampleOne resignFirstResponder];
    [self.sampleTwo resignFirstResponder];
    [self.sampleThree resignFirstResponder];
}

-(void)autoCompleteTextField:(TKAutoCompleteTextField *)textField didSelectSuggestion:(NSString *)suggestion {
    NSLog(@"didSelectSuggestion: %@",suggestion);
}
-(void)autoCompleteTextField:(TKAutoCompleteTextField *)textField didFillAutoCompleteWithSuggestion:(NSString *)suggestion {
    NSLog(@"didFillAutoCompleteWithSuggestion: %@",suggestion);
}

-(CGFloat)autoCompleteTextField:(TKAutoCompleteTextField *)textField heightForsuggestionView:(UITableView *)suggestionView {
    return textField.frame.size.height * (textField.matchSuggestions.count + 1);
}
-(NSInteger)autoCompleteTextField:(TKAutoCompleteTextField *)textField numberOfVisibleRowInSuggestionView:(UITableView *)suggestionView {
    return textField.matchSuggestions.count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
