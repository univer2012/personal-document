//
//  SGHSignalViewController.m
//  RAC_test
//
//  Created by huangaengoln on 16/1/31.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHSignalViewController.h"

@interface SGHSignalViewController ()

@end

@implementation SGHSignalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
#if 0
    
    //第1种 返回
    RACSignal *signal=[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       //request
#if 0
        //第1种
        [subscriber sendNext:@"reponse"];
        [subscriber sendNext:@"reponse2"];
        //第2种
        [subscriber sendCompleted];
#endif
        //第3种   request error
        [subscriber sendError:[NSError errorWithDomain:@"domain" code:214 userInfo:@{}]];
        
        // 第1种 返回
        return nil;
        
        
    }];
    //完整的 订阅信号
    [signal subscribeNext:^(id x) {
        // x 就是 sendNext: 后面的参数
        LxDBAnyVar(x);
        
    } error:^(NSError *error) {
        
        LxDBAnyVar(error);
        
    } completed:^{
        
        LxPrintAnything(completed);
        
    }];
    
#elif 0
    
    // 第2种 返回 取消订阅
    RACSignal *signal=[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        //request
        [subscriber sendNext:@"reponse2"];
        [subscriber sendCompleted];
        
        // 第1种 返回
        return [RACDisposable disposableWithBlock:^{
            //cancel request
        }];
        
        
    }];
    //完整的 订阅信号
    RACDisposable *disposable = [signal subscribeNext:^(id x) {
        // x 就是 sendNext: 后面的参数
        LxDBAnyVar(x);
        
    } error:^(NSError *error) {
        
        LxDBAnyVar(error);
        
    } completed:^{
        
        LxPrintAnything(completed);
        
    }];
    //Performs the disposal work. Can be called multiple times, though subsequent calls won't do anything.
    [disposable dispose];
    
#elif 1
    
    //另一种 写法
    RACSignal *signal=[[NSNotificationCenter defaultCenter]rac_addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil];
    RACDisposable *dispose = [signal subscribeNext:^(NSNotification * notification) {
        LxDBAnyVar(notification);
    }];
    [dispose dispose];
    
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
