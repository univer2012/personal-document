//
//  SHRAC1ViewController.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/11/16.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "SHRAC1ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface SHRAC1ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *testButton;

@end

@implementation SHRAC1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
//MARK:Button
- (void)normalButton_targetAction {
    [self.testButton addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)tapAction:(UIButton *)sender {
    NSLog(@"按钮点击了");
    NSLog(@"%@",sender);
}

- (void)RACButton_targetAction {
    [[self.testButton rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         NSLog(@"RAC按钮点击了");
         NSLog(@"%@",x);
     }];
    
//    self.
}


@end
