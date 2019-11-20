//
//  SHRAC4ViewController.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/11/20.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "SHRAC4ViewController.h"

@interface SHRAC4ViewController ()

@end

@implementation SHRAC4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.创建signal信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        //subscriber并不是一个对象
        //3. 发送信号
        [subscriber sendNext:@"send one Message"];
        
        //发送error信号
        NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:1001 userInfo:@{@"errorMsg": @"this is a error message"}];
        [subscriber sendError:error];
        
        //4.销毁信号
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"signal已销毁");
        }];
    }];
    
    //2.1 订阅信号
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    //2.2 针对实际中可能出现的逻辑错误，RAC提供了订阅error信号
    [signal subscribeError:^(NSError * _Nullable error) {
        NSLog(@"%@",error);
    }];
}


@end
