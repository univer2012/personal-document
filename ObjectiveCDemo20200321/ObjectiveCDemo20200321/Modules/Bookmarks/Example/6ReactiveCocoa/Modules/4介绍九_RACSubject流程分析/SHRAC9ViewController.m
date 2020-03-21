//
//  SHRAC9ViewController.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/11/22.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "SHRAC9ViewController.h"

@interface SHRAC9ViewController ()

@end

@implementation SHRAC9ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self p_subject];
}

- (void)p_subject {
    //1.创建信号
    RACSubject *subject = [RACSubject subject];
    //2.订阅信号
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    //3.发送信号
    [subject sendNext:@"this is a RACSubject"];
}


@end
