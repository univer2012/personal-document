//
//  SHRAC12ViewController.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/11/23.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "SHRAC12ViewController.h"
#import "SHRAC12ViewModel.h"

@interface SHRAC12ViewController ()

@property(nonatomic, strong)SHRAC12ViewModel *viewModel;
@property(nonatomic, strong)UITextField *priceTextFld;

@end

@implementation SHRAC12ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.viewModel = [[SHRAC12ViewModel alloc] init];
    
    self.priceTextFld = [[UITextField alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 40)];
    self.priceTextFld.backgroundColor = UIColor.grayColor;
    [self.view addSubview:self.priceTextFld];
    
    @weakify(self)
    //监听价格输入
    [[RACObserve(self.priceTextFld, text) merge:self.priceTextFld.rac_textSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        
        @weakify(self)
        [[self.viewModel.priceSpreadCommand execute:nil] subscribeNext:^(id  _Nullable x) {
            @strongify(self)
            NSLog(@"监听priceTextFld的输入：%@",x);
        }];
    }];
    
    //更新价差
    [self.viewModel.priceSpreadCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        NSLog(@"executionSignals 好的");
    }];
    
//    [[self.viewModel.priceSpreadCommand execute:nil] subscribeNext:^(id  _Nullable x) {
//        @strongify(self)
//
//        NSLog(@"before_dljfojsojfl ");
//        //[self.headerView.priceView refreshUIWithRefreshPrice:NO];
//    }];
    
    
    //[self p_command];
}

- (void)p_command {
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
    
//    //command信号中signal信号发送出来的订阅信号
//    [command.executionSignals subscribeNext:^(id  _Nullable x) {
//        NSLog(@"executionSignals == %@",x);
//    }];
    
    //必须执行命令，否则所有信号都不会订阅到
    [command execute:@"command执行"];
    
    
    
//    [[command.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
//        NSLog(@"executing_skip1 == %@",x);
//    }];
    
    
    //监听最后一次发送的信号
    [[command.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        NSLog(@"executionSignals_switchToLatest == %@",x);
    }];
}


@end
