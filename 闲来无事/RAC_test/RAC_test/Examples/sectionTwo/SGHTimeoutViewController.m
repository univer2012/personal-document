//
//  SGHTimeoutViewController.m
//  RAC_test
//
//  Created by huangaengoln on 16/1/31.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHTimeoutViewController.h"

@interface SGHTimeoutViewController ()

@end

@implementation SGHTimeoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 超时后 ，sendNext:方法 就不处理了。
    
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[RACScheduler mainThreadScheduler]afterDelay:3 schedule:^{
            [subscriber sendNext:@"rac"];
            [subscriber sendCompleted];
        }];
        return nil;
        
    }] timeout:2 onScheduler:[RACScheduler mainThreadScheduler]]
    subscribeNext:^(id x) {
        
        LxDBAnyVar(x);
    } error:^(NSError *error) {
        
        LxDBAnyVar(error);
    } completed:^{
        LxPrintAnything(completed);
        
    }];
    
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
