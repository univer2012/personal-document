//
//  Base3Controller.m
//  Masonry_test_16_01_25
//
//  Created by huangaengoln on 16/1/25.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "Base3Controller.h"
#import <pop/POP.h>
#import <MMTweenAnimation/MMTweenAnimation.h>

@interface Base3Controller ()
@property(nonatomic,strong)UIView *blocks;

@end

@implementation Base3Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.blocks=({
        UIView *view=[UIView new];
        [self.view addSubview:view];
        view.backgroundColor=[UIColor redColor];
#if 0
        view.frame=CGRectMake(0, 0, 100, 100);
#elif 0
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];
#elif 1
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.center.equalTo(self.view);//.centerOffset(CGPointMake(0, -300));
            
            make.centerX.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_bottom).offset(-300);
            make.size.mas_equalTo(CGSizeMake(200, 200));
        }];
//        view.transform=CGAffineTransformScale(CGAffineTransformIdentity, 0.3, 0.3);
        
#endif
        view.layer.cornerRadius=100;
        
        view;
    });
    
    
    // ======== POP
    
    
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
#if 0   //POP
    
    POPAnimatableProperty *prop=[POPAnimatableProperty propertyWithName:@"test" initializer:^(POPMutableAnimatableProperty *prop) {
        prop.writeBlock = ^(id obj, const CGFloat values[]){
            UIView *ball=(UIView *)obj;
            [ball mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.view.mas_bottom).offset(values[0]);
//                make.center.equalTo(self.view).centerOffset(CGPointMake(0, values[0]));
            }];
        };
        
#if 0
        prop.readBlock = ^(id obj,CGFloat values[]) {
            UIView *ball=(UIView *)obj;
            for (MASLayoutConstraint *constraint in ball.constraints) {
                if (constraint.firstAttribute == NSLayoutAttributeCenterY) {
                    values[0] = constraint.constant;
                }
            }
        };
#endif
        
    }];
    
    
    POPSpringAnimation *animation=[POPSpringAnimation animation];
    animation.property=prop;
    animation.fromValue=@(-300);
    animation.toValue=@(0);
    animation.springBounciness=20;
    animation.springSpeed=10;
    
    [self.blocks pop_addAnimation:animation forKey:@"test"];
#endif
    
    MMTweenAnimation *animation=[MMTweenAnimation animation];
    animation.functionType=MMTweenFunctionBounce;
    animation.duration = 1.5f;
    animation.fromValue=@[ @(-300) ];
    animation.toValue=@[ @(0) ];
    
    animation.animationBlock = ^(double c,double d, NSArray *v, id target, MMTweenAnimation *animation) {
        double value = [v[0] doubleValue];
        [self.blocks mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.mas_bottom).offset(value);
        }];
    };
    
    [self.blocks pop_addAnimation:animation forKey:@"test"];
    
    
}


#if 0
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    

    [UIView animateWithDuration:0.3 animations:^{
#if 0
        self.blocks.frame=CGRectMake(0, 200, 100, 100);
#elif 0
        
        [self.blocks mas_updateConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view).centerOffset(CGPointMake(0, -100));
        }];
      [self.view layoutIfNeeded];
#elif 0
        [self.blocks mas_updateConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
        }];
        [self.view layoutIfNeeded];
        self.blocks.transform=CGAffineTransformIdentity;
#endif
        
    }];
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:0 animations:^{
        [self.blocks mas_updateConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
        }];
        [self.view layoutIfNeeded];
        self.blocks.transform=CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
    }];
}
#endif

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
