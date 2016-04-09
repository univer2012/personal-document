//
//  Base5Controller.m
//  Masonry_test_16_01_25
//
//  Created by huangaengoln on 16/1/26.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "Base5Controller.h"
#import <MMPlaceHolder/MMPlaceHolder.h>

@interface Base5Controller ()

@property(nonatomic,strong)UIStackView *stackView;

@end

@implementation Base5Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIStackView *stackView= ({
       UIStackView *view=[UIStackView new];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.centerY.equalTo(self.view);
            make.height.equalTo(@200);
        }];
        view.axis=UILayoutConstraintAxisHorizontal;
        view.alignment=UIStackViewAlignmentCenter;
        view.distribution= UIStackViewDistributionFill; //UIStackViewDistributionFillProportionally; //UIStackViewDistributionFill;
//        view.spacing=3;
        
        view;
    });
    self.stackView=stackView;
    
    UIView *backView=({
        UIView *view=[UIView new];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(stackView);
        }];
        
        view.backgroundColor=[UIColor lightGrayColor];
        
        
        view;
    });
    [self.view sendSubviewToBack:backView];
    
    UIView *sp1=({
        UIView *view=[UIView new];
        [stackView addArrangedSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
        }];
//        view.backgroundColor=[UIColor blackColor];
        view;
    });
    
    UIView *v1=({
        UIView *view=[UIView new];
        [stackView addArrangedSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 50)).priorityLow();
        }];
        view.backgroundColor=[UIColor redColor];
        
        view;
    });
    
    UIView *v2=({
        UIView *view=[UIView new];
        [stackView addArrangedSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(10, 30)).priorityLow();
        }];
        view.backgroundColor=[UIColor blueColor];
        
        view;
    });
    
    UIView *v3=({
        UIView *view=[UIView new];
        [stackView addArrangedSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 70)).priorityLow();
        }];
        view.backgroundColor=[UIColor redColor];
        
        view;
    });
    
    UIView *sp2=({
        UIView *view=[UIView new];
        [stackView addArrangedSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
        }];
//        view.backgroundColor=[UIColor blackColor];
        view;
    });
    
    [sp1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(sp2);
    }];
    
    // =============================
#if 0
    UILabel *label1=({
        UILabel *label=[UILabel new];
        [stackView addArrangedSubview:label];
        label.text=@"testtest";
        label.textColor=[UIColor blackColor];
        label.backgroundColor=[UIColor redColor];
        
        label;
    });
    
    UILabel *label2=({
        UILabel *label=[UILabel new];
        [stackView addArrangedSubview:label];
        label.text=@"ttttttttttttt";
        label.textColor=[UIColor blackColor];
        label.backgroundColor=[UIColor blueColor];
        
        label;
    });
    //f方法1
//    [label1 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    //方法2
    UIView *spacer=({
        UIView *view=[UIView new];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
        }];
        
        [stackView addArrangedSubview:view];
        view.backgroundColor=[UIColor greenColor];
        view;
    });
    
#endif
    
    // ======================================
#if 0
    
    NSArray *array=@[[UIView new],[UIView new],[UIView new],[UIView new]];
#if 0
    for (UIView *view in array) {
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 80)).priorityLow();
        }];
        [stackView addArrangedSubview:view];
        view.backgroundColor=[UIColor redColor];
        view.layer.borderColor=[UIColor blackColor].CGColor;
        view.layer.borderWidth=2.0f;
    }
#endif
    for (int i=0; i<array.count; ++i) {
        UIView *view=array[i];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.size.mas_equalTo(CGSizeMake(80+i*10, 80-i*10)).priorityLow();
            make.size.mas_equalTo(CGSizeMake(10+i*10, 80-i*10)).priorityLow();
        }];
        [stackView addArrangedSubview:view];
        view.backgroundColor=[UIColor redColor];
        view.layer.borderColor=[UIColor blackColor].CGColor;
        view.layer.borderWidth=2.0f;
        
        [view showPlaceHolder];
    }
    
    UIView *v1=array[0];
    [v1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(array[1]).priority(UILayoutPriorityRequired);
    }];
#endif
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    for (NSLayoutConstraint *constraint in self.stackView.constraints) {
        NSLog(@"%@",constraint);
    }
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
