//
//  SHRAC12ViewController.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/11/23.
//  Copyright © 2019 huangaengoln. All rights reserved.
//
/*
 * 来自：[RAC(ReactiveCocoa)介绍（十二）——RACCommand](https://www.jianshu.com/p/75681ea2256e)
 */
#import "SHRAC12ViewController.h"
#import "SHRAC12ViewModel.h"
#import "UIViewController+Description.h"

@interface SHRAC12ViewController ()

@property(nonatomic, strong)SHRAC12ViewModel *viewModel;
@property(nonatomic, strong)UITextField *priceTextFld;

@end

@implementation SHRAC12ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn1 = [self buildBtnWith:@"原代码"];
    [self.view addSubview:btn1];
    [btn1 addTarget:self action:@selector(originalCode) forControlEvents:UIControlEventTouchUpInside];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(90);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(100);
    }];
    
    UIButton *btn2 = [self buildBtnWith:@"改进1"];
    [self.view addSubview:btn2];
    [btn2 addTarget:self action:@selector(improved1Code) forControlEvents:UIControlEventTouchUpInside];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn1.mas_bottom).offset(10);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(100);
    }];
    
    UIButton *btn3 = [self buildBtnWith:@"改进2"];
    [self.view addSubview:btn3];
    [btn3 addTarget:self action:@selector(improved2Code) forControlEvents:UIControlEventTouchUpInside];
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn2.mas_bottom).offset(10);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(100);
    }];
    
    UIButton *btn4 = [self buildBtnWith:@"另一个有关priceTextFld的监听的demo"];
    [self.view addSubview:btn4];
    [btn4 addTarget:self action:@selector(aboutTextFieldDemo) forControlEvents:UIControlEventTouchUpInside];
    [btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn3.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
    }];
    
}
//MARK:另一个有关priceTextFld的监听的demo
- (void)aboutTextFieldDemo {
    
    self.viewModel = [[SHRAC12ViewModel alloc] init];
    
    self.priceTextFld = [[UITextField alloc]initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 40)];
    self.priceTextFld.backgroundColor = UIColor.grayColor;
    [self.view addSubview:self.priceTextFld];
    
    @weakify(self)
    //监听价格输入
    [[RACObserve(self.priceTextFld, text) merge:self.priceTextFld.rac_textSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        NSLog(@"priceTextFld_text:%@",x);
        @weakify(self)
        [[self.viewModel.priceSpreadCommand execute:nil] subscribeNext:^(id  _Nullable x) {
            @strongify(self)
            NSLog(@"priceSpreadCommand订阅：%@",x);
        }];
    }];
    
    //更新价差
    [self.viewModel.priceSpreadCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        //@strongify(self)
        NSLog(@"executionSignals_switchToLatest:%@",x);
    }];
    
    ///priceSpreadCommand execute:nil] subscribeNext: 这种写法不会受到任何信息
    [[self.viewModel.priceSpreadCommand execute:nil] subscribeNext:^(id  _Nullable x) {
        //@strongify(self)
        NSLog(@"priceSpreadCommand订阅2：%@",x);
        //NSLog(@"before_dljfojsojfl ");
        //[self.headerView.priceView refreshUIWithRefreshPrice:NO];
    }];
}

//MARK:改进2
- (void)improved2Code {
    //创建command信号
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        //返回RACSignal信号类型对象
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [subscriber sendNext:@"this is signal of command"];
            NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:1234 userInfo:@{@"key": @"error"}];
            [subscriber sendError:error];
            
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"销毁了");
            }];
        }];
    }];
    
    //command信号是否正在执行
    [[command.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        NSLog(@"executing_skip1 == %@",x);
    }];
    
    //错误信号
    [command.errors subscribeNext:^(NSError * _Nullable x) {
        NSLog(@"errors == %@",x);
    }];
    
    //监听最后一次发送的信号
    [[command.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        NSLog(@"executionSignals_switchToLatest == %@",x);
    }];
    
    //必须执行命令，否则所有信号都不会订阅到
    [command execute:@"command执行"];
}
//MARK:改进1
- (void)improved1Code {
    //创建command信号
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        //返回RACSignal信号类型对象
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [subscriber sendNext:@"this is signal of command"];
            NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:1234 userInfo:@{@"key": @"error"}];
            [subscriber sendError:error];
            
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"销毁了");
            }];
        }];
    }];
    
    //command信号是否正在执行
    [[command.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        NSLog(@"executing_skip1 == %@",x);
    }];
    
    //错误信号
    [command.errors subscribeNext:^(NSError * _Nullable x) {
        NSLog(@"errors == %@",x);
    }];
    
    
   //command信号中signal信号发送出来的订阅信号
    [command.executionSignals subscribeNext:^(id  _Nullable x) {
        NSLog(@"executionSignals == %@",x);
    }];
    
    //必须执行命令，否则所有信号都不会订阅到
    [command execute:@"command执行"];
}
//MARK:原代码
- (void)originalCode {
    //创建command信号
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        //返回RACSignal信号类型对象
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [subscriber sendNext:@"this is signal of command"];
            NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:1234 userInfo:@{@"key": @"error"}];
            [subscriber sendError:error];
            
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"销毁了");
            }];
        }];
    }];
    
    //command信号是否正在执行
    [command.executing subscribeNext:^(NSNumber * _Nullable x) {
        NSLog(@"executing == %@",x);
    }];
    
    //错误信号
    [command.errors subscribeNext:^(NSError * _Nullable x) {
        NSLog(@"errors == %@",x);
    }];
    
    //command信号中signal信号发送出来的订阅信号
    [command.executionSignals subscribeNext:^(id  _Nullable x) {
        NSLog(@"executionSignals == %@",x);
    }];
    
    //必须执行命令，否则所有信号都不会订阅到
    [command execute:@"command执行"];
}


@end
