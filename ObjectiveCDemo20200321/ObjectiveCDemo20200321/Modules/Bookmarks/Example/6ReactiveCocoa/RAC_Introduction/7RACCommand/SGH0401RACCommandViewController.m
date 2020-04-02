//
//  SGH0401RACCommandViewController.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/4/1.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGH0401RACCommandViewController.h"
#import "UIViewController+Description.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

/*
 * 来自：[iOS RAC - RACCommand](https://www.jianshu.com/p/baa5fe76191c)
 */
@interface SGH0401RACCommandViewController ()

@end

@implementation SGH0401RACCommandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn1 = [self buildBtnWith:@"创建RACCommand，return nil"];
    btn1.tag = 1;
    [btn1 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.view).offset(100);
    }];
    
    UIButton *btn2 = [self buildBtnWith:@"创建RACCommand，return other"];
    btn2.tag = 11;
    [btn2 addTarget:self action:@selector(executingDemo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(btn1.mas_bottom).offset(10);
    }];
    
    
    [self executingDemo];
}
- (void)btnAction:(UIButton *)btn {
    switch (btn.tag) {
        case 1:{
RACCommand * command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
    
    return nil;
}];

[command execute:@"开始飞起来"];
        }
            break;
        case 2:{
RACCommand * command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
    NSLog(@"%@",input);
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        return nil;
    }];
}];
[command execute:@"开始飞起来"];
        }
            break;
        case 3:{
RACCommand * command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
    
    NSLog(@"%@",input);
    
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [subscriber sendNext:@"大佬大佬放过我"];
        
        return nil;
    }];
}];
[command execute:@"开始飞起来"];
        }
            break;
        case 4:{
RACCommand * command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
    
    NSLog(@"%@",input);
    
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [subscriber sendNext:@"大佬大佬放过我"];
        
        return nil;
    }];
}];
[command execute:@"开始飞起来"];

RACSignal * signal = [command execute:@"开始飞起来"];

[signal subscribeNext:^(id  _Nullable x) {
    NSLog(@"接收数据 - %@",x);
}];
            


        }
            break;
        case 5:{
RACCommand * command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
    
    NSLog(@"%@",input);
    
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [subscriber sendNext:@"大佬大佬放过我"];
        
        return nil;
    }];
}];

[command.executionSignals subscribeNext:^(id  _Nullable x) {
    [x subscribeNext:^(id  _Nullable x) {
        NSLog(@"这里会是什么呢？ - %@",x);
    }];
    NSLog(@"接收数据 - %@",x);
}];

[command execute:@"开始飞起来"];
        }
            break;
        case 6:{
RACCommand * command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
    
    NSLog(@"%@",input);
    
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [subscriber sendNext:@"大佬大佬放过我"];
        
        return nil;
    }];
}];

[command.executionSignals.switchToLatest subscribeNext:^(id _Nullable x) {
    NSLog(@"接收数据 - %@",x);
}];

[command execute:@"开始飞起来"];
        }
            break;
        case 7:{
            RACSubject *signalofsignal = [RACSubject subject];
            RACSubject *signal1 = [RACSubject subject];
            RACSubject *signal2 = [RACSubject subject];
            RACSubject *signal3 = [RACSubject subject];
            RACSubject *signal4 = [RACSubject subject];
            
            [signalofsignal subscribeNext:^(id  _Nullable x) {
                [x subscribeNext:^(id  _Nullable x) {
                    NSLog(@"%@",x);
                }];
            }];
            
            [signalofsignal sendNext:signal1];
            [signal1 sendNext:@"1"];
        }
            break;
        case 8:{
            RACSubject *signalofsignal = [RACSubject subject];
            RACSubject *signal1 = [RACSubject subject];
            RACSubject *signal2 = [RACSubject subject];
            RACSubject *signal3 = [RACSubject subject];
            RACSubject *signal4 = [RACSubject subject];

            [signalofsignal.switchToLatest subscribeNext:^(id _Nullable x) {
                NSLog(@"%@",x);
            }];

            [signalofsignal sendNext:signal1];
            [signal1 sendNext:@"1"];
        }
            break;
        case 9:{
            RACSubject *signalofsignal = [RACSubject subject];
            RACSubject *signal1 = [RACSubject subject];
            RACSubject *signal2 = [RACSubject subject];
            RACSubject *signal3 = [RACSubject subject];
            RACSubject *signal4 = [RACSubject subject];

            [signalofsignal.switchToLatest subscribeNext:^(id _Nullable x) {
                NSLog(@"%@",x);
            }];

            [signalofsignal sendNext:signal1];
            [signalofsignal sendNext:signal2];
            [signalofsignal sendNext:signal3];
            [signalofsignal sendNext:signal4];

            [signal1 sendNext:@"1"];
            [signal2 sendNext:@"2"];
            [signal3 sendNext:@"3"];
            [signal4 sendNext:@"4"];
        }
            break;
        case 10:{
RACCommand * command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
    
    NSLog(@"input - %@",input);
    
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [subscriber sendNext:@"6666666666"];
        
        return nil;
    }];
}];

[command.executionSignals.switchToLatest subscribeNext:^(id _Nullable x) {
    NSLog(@"%@",x);
}];

[command.executing subscribeNext:^(NSNumber * _Nullable x) {
    if ([x boolValue]) {
        NSLog(@"还在执行");
    } else {
        NSLog(@"执行结束了");
    }
}];

[command execute:@"9999999999"];
        }
            break;
            
            
        case 11:{ //添加sendCompleted
RACCommand * command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
    
    NSLog(@"input - %@",input);
    
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [subscriber sendNext:@"6666666666"];
        [subscriber sendCompleted];
        
        return nil;
    }];
}];

[command.executionSignals.switchToLatest subscribeNext:^(id _Nullable x) {
    NSLog(@"%@",x);
}];

[command.executing subscribeNext:^(NSNumber * _Nullable x) {
    if ([x boolValue]) {
        NSLog(@"还在执行");
    } else {
        NSLog(@"执行结束了");
    }
}];

[command execute:@"9999999999"];
        }
            break;
            
        case 12:{
RACCommand * command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
    
    NSLog(@"input - %@",input);
    
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [subscriber sendNext:@"6666666666"];
        [subscriber sendCompleted];
        
        return nil;
    }];
}];

[command.executionSignals.switchToLatest subscribeNext:^(id _Nullable x) {
    NSLog(@"%@",x);
}];

[[command.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
    if ([x boolValue]) {
        NSLog(@"还在执行");
    } else {
        NSLog(@"执行结束了");
    }
}];

[command execute:@"9999999999"];
            }
            break;
        default:
            break;
    }
}

- (void)executingDemo {
    UIButton *createButton = [self buildBtnWith:@"executing"];
    [self.view addSubview:createButton];
    [createButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.bottom.equalTo(self.view).offset(-40);
    }];
    
    
    RACSignal* textSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@(1)];
        [subscriber sendNext:@(2)];
        [subscriber sendError:[NSError new]];
        return nil;
    }];
    
    RACCommand* textCommad = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return textSignal;
    }];
    
    createButton.rac_command = textCommad;
    
    [textCommad.executing subscribeNext:^(id x) {
        NSLog(@"executing%@",x);
    }];
    
    [textCommad.executionSignals subscribeNext:^(id x) {
        NSLog(@"executionSignals%@",x);
    }];
    
    [[textCommad.executionSignals switchToLatest]subscribeNext:^(id x) {
        NSLog(@"executionSignals switchLatest%@",x);
    }];
    
    [textCommad.errors subscribeNext:^(id x) {
        NSLog(@"errors");
    }];
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
