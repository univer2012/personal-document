//
//  SGHStartWithViewController.m
//  RAC_test
//
//  Created by huangaengoln on 16/1/31.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHStartWithViewController.h"

@interface SGHStartWithViewController ()

@end

@implementation SGHStartWithViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
#if 0
    RACSignal *signal=[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"rac"];
        [subscriber sendCompleted];
        return nil;
    }] startWith:@"wrwer"];
    
    LxPrintAnything(qwr);
    
    [signal subscribeNext:^(id x) {
        LxDBAnyVar(x);
    }];
    
#elif 1
    
    //上面的写法 相当于下面的 写法
    RACSignal *signal=[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [subscriber sendNext:@"wrwer"];
        
        //request
        
        [subscriber sendNext:@"rac"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    LxPrintAnything(qwr);
    
    [signal subscribeNext:^(id x) {
        LxDBAnyVar(x);
    }];
#endif
    
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
