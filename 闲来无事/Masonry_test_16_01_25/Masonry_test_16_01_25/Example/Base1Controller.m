//
//  Base1Controller.m
//  Masonry_test_16_01_25
//
//  Created by huangaengoln on 16/1/25.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "Base1Controller.h"
#import "MMView.h"
#import "MMLabel.h"

@interface Base1Controller ()
@property(nonatomic,strong)UILabel *labelCenter;

@end

@implementation Base1Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
#if 0
    UIView *v1=({
        UIView *view=[UIView new];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 50));
            make.left.equalTo(self.view);
//            make.top.equalTo(self.mas_topLayoutGuide);
        }];
        view.backgroundColor=[UIColor blueColor];
        
        view;
    });
    
    UIView *v2=({
        UIView *view=[UIView new];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 50));
            make.left.equalTo(v1.mas_right);
            make.top.equalTo(v1.mas_bottom);
            
        }];
        view.backgroundColor=[UIColor blueColor];
        view.layoutMargins=UIEdgeInsetsMake(20, 20, 20, -20);
        view;
    });
    
    UIView *v3=({
        UIView *view=[UIView new];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 50));
            make.centerY.equalTo(v2);
            make.left.equalTo(v2.mas_rightMargin);
            
//            make.left.right.equalTo(v2).multipliedBy(1);
            
        }];
        view.backgroundColor=[UIColor redColor]; 
        view;
    });
    
#if 0
    UIView *v4=({
        MMView *view=[MMView new];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
            make.width.equalTo(@50);
        }];
        
        view.innerSize=CGSizeMake(100, 100);
        view.backgroundColor=[UIColor greenColor];
        view;
    });
    
#endif
    
    UIView *v5=({
        MMLabel *label=[MMLabel new];
        [self.view addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
            make.width.equalTo(@150);
        }];
        label.text=@"dof ehfefkejal;eifpeo;afn;dlfn/l a c";
        label.numberOfLines=0;
        label.backgroundColor=[UIColor darkGrayColor];
        label;
    });
    
#endif
    
    UILabel *lbl1=({
        UILabel *label=[UILabel new];
        [self.view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.view);
            make.left.equalTo(self.view);
            
        }];
        label.text=@"左边的文字";
        label.textColor=[UIColor blackColor];
        label.backgroundColor=[UIColor grayColor];
        [label setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [label setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        
        label;
    });
    
    UILabel *lbl2=({
        UILabel *label=[UILabel new];
        [self.view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.view);
            make.left.equalTo(lbl1.mas_right);
            
        }];
        label.text=@"中间的文字";
        label.textAlignment=NSTextAlignmentCenter;
        label.textColor=[UIColor blackColor];
        label.backgroundColor=[UIColor redColor];
        
        label;
    });
    self.labelCenter=lbl2;
    
    UILabel *lbl3=({
        UILabel *label=[UILabel new];
        [self.view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.view);
            make.left.equalTo(lbl2.mas_right);
            make.right.equalTo(self.view.mas_right);
            
        }];
        label.text=@"右边的文字";
        label.textColor=[UIColor blackColor];
        label.backgroundColor=[UIColor grayColor];
        [label setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [label setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        
        label;
    });
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.labelCenter.text=[self.labelCenter.text stringByAppendingString:@"test"];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
