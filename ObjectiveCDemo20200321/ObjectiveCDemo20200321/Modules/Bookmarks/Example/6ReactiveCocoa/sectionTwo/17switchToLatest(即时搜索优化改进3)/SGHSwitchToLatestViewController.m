//
//  SGHSwitchToLatestViewController.m
//  RAC_test
//
//  Created by huangaengoln on 16/1/31.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHSwitchToLatestViewController.h"

@interface SGHSwitchToLatestViewController ()

@end

@implementation SGHSwitchToLatestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITextField * textField = [[UITextField alloc]init];
    textField.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:textField];
    
    @weakify(self); //  __weak __typeof__(self) self_weak_ = self;
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        @strongify(self);   //  __strong __typeof__(self) self = self_weak_;
        make.size.mas_equalTo(CGSizeMake(180, 40));
        make.center.equalTo(self.view);
    }];
//    NSLog(@"%@",[textField iskindof]);
    ///第2个例子
    RACSubject *signalOfSignals = [RACSubject subject];
    RACSubject *signalA = [RACSubject subject];
    RACSubject *signalB = [RACSubject subject];
    // 获取信号中信号最近发出信号，订阅最近发出的信号。
    // 注意switchToLatest：只能用于信号中的信号
    [signalOfSignals.switchToLatest subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
    }];
    [signalOfSignals sendNext:signalA];
    [signalOfSignals sendNext:signalB];
    [signalA sendNext:@"signalA"];
    [signalB sendNext:@"signalB"];
    
    
    
#if 0
    //改进3
    //取消订阅 --->  switchToLatest
    // signal of signals
    [[[[[[textField.rac_textSignal throttle:0.3] distinctUntilChanged] ignore:@""]
       map:^id(id value) {
           
           return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
               
               // request
               [subscriber sendNext:value];
               [subscriber sendCompleted];
               
               return [RACDisposable disposableWithBlock:^{
                   
                   //取消请求
//                   AFHTTPRequestOperation *operation = nil;
//                   [operation cancel];
                   
               }];
               
           }];
       }] switchToLatest]
     subscribeNext:^(id x) {
         LxDBAnyVar(x);
     }];

    
    //signal of signals 的另一个例子
#pragma mark - map 和 flattenMap
    
#elif 0
    [[textField.rac_textSignal map:^id(id value) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [subscriber sendNext:@"rac"];
            [subscriber sendCompleted];
            return nil;
            
        }];
    }] subscribeNext:^(id x) {
        
        LxDBAnyVar(x);
    }];
    
#elif 0
    
    // flattenMap  --->  扁平化映射
    [[textField.rac_textSignal flattenMap:^id(id value) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [subscriber sendNext:@"rac"];
            [subscriber sendCompleted];
            return nil;
            
        }];
    }] subscribeNext:^(id x) {
        
        LxDBAnyVar(x);
    }];
    
#elif  0
#pragma mark - map的一个例子
    [[textField.rac_textSignal map:^id(NSString *text) {
        
        LxDBAnyVar(text);
        
        return @(text.length);
    }] subscribeNext:^(id x) {
        
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
