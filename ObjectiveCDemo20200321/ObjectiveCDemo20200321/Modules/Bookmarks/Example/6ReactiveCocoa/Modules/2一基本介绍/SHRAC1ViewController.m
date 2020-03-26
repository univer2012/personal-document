//
//  SHRAC1ViewController.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/11/16.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "SHRAC1ViewController.h"
#import <ReactiveObjC.h>


@interface SHRAC1ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *testButton;
@property (weak, nonatomic) IBOutlet UILabel *testLabel;
@property (weak, nonatomic) IBOutlet UITextField *testTextField;

@end

@implementation SHRAC1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self RACButton_targetAction];
//    [self RACLabel_action];
    //[self RACTextFieldDelegate];
//    [self RACNotification];
//    [self RACTimer];
//    [self RACSequence];
//    [self RACBase];
//    [self RAC_flattenMap];
//    [self RAC_filter];
//    [self RAC_ignoreValue_ignore];
//    [self RAC_distinctUntilChanged];
    
//    [self p_observe];
    
    [self p_define];
}


//MARK: RAC(ReactiveCocoa)介绍（十一）——RAC宏定义
- (void)p_define {
    @weakify(self);         //备注：
    [[self.testTextField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        //过滤判断条件
        @strongify(self)    //备注：
        if (self.testTextField.text.length >= 6) {
            self.testTextField.text = [self.testTextField.text substringToIndex:6];
            self.testLabel.text = @"已经到6位了";
            self.testLabel.textColor = UIColor.redColor;
        }
        return value.length <= 6;
        
    }] subscribeNext:^(NSString * _Nullable x) {
        //订阅逻辑区域
        NSLog(@"filter过滤后的订阅内容：%@",x);
    }];
}



//MARK: RAC(ReactiveCocoa)介绍（八）——KVO销毁
- (void)p_observe {
    [RACObserve(self.testLabel, text) subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}

//MARK: RAC(ReactiveCocoa)介绍（三）——信号过滤


//MARK: distinctUntilChanged
- (void)RAC_distinctUntilChanged {
    RACSubject *subject = [RACSubject subject];
    [[subject distinctUntilChanged] subscribeNext:^(id  _Nullable x) {
        NSLog(@"distinctUntilChanged:%@",x);
    }];
    [subject sendNext:@1111];
    [subject sendNext:@2222];
    [subject sendNext:@2222];
}

//MARK:ignoreValue_ignore
-(void)RAC_ignoreValue_ignore {
    [[self.testTextField.rac_textSignal ignoreValues] subscribeNext:^(id  _Nullable x) {
        ////将self.testTextField的所有textSignal全部过滤掉
        NSLog(@"ignoreValues:%@",x);        // --> 不会执行
    }];
    
    [[self.testTextField.rac_textSignal ignore:@"1"] subscribeNext:^(NSString * _Nullable x) {
        //将self.testTextField的textSignal中字符串为指定条件的信号过滤掉
        NSLog(@"ignore:%@",x);      //-->只忽略字符串「1」，不会忽略字符串「12」、「123」等
    }];
}


//MARK: filter
- (void)RAC_filter {
    @weakify(self)
    [[self.testTextField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        @strongify(self)
        //过滤判断条件
        if (self.testTextField.text.length >= 6) {
            self.testTextField.text = [self.testTextField.text substringToIndex:6];
            self.testLabel.text = @"已经到6位了";
            self.testLabel.textColor = [UIColor redColor];
        }
        return value.length <= 6;
    }] subscribeNext:^(NSString * _Nullable x) {
        //订阅逻辑区域
        NSLog(@"filter过滤后的订阅内容：%@",x);
    }];
}

//MARK: RAC(ReactiveCocoa)介绍（二）——map映射
//MARK:map
- (void)RAC_map {
    [[self.testTextField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return [NSString stringWithFormat:@"map自定义：%@",value];
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}

//MARK:flattenMap
- (void)RAC_flattenMap {
    
    
    [[self.testTextField.rac_textSignal flattenMap:^__kindof RACSignal * _Nullable(NSString * _Nullable value) {
        
        //自定义返回内容
        return [RACSignal return:[NSString stringWithFormat:@"自定义返回信号：%@",value]];
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}
//MARK:RAC(ReactiveCocoa)介绍（一）——基本介绍
//MARK:RAC基本使用方法与流程
- (void)RACBase {
    //RAC 基本使用方法与流程
    //1. 创建signal 信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        //subscriber 并不是一个对象
        //3. 发送信号
        [subscriber sendNext:@"sendOneMessage"];
        
        //发送error信号
        NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:1001 userInfo:@{@"errorMsg": @"this is a error message"}];
        [subscriber sendError:error];
        
        //4. 销毁信号
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"signal已销毁");
        }];
    }];
    
    //2.1 订阅信号
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    //2.2 订阅error信号
    [signal subscribeError:^(NSError * _Nullable error) {
        NSLog(@"%@",error);
    }];
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
    
    @weakify(self)
    [[self.testButton rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         @strongify(self)
         self.testLabel.text = @"label changed";
         NSLog(@"%@",x);
     }];
}
//MARK: Label
- (void)RACLabel_action {
    self.testLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [self.testLabel addGestureRecognizer:tap];
    [tap.rac_gestureSignal subscribeNext:^(id x) {
        //点击事件响应的逻辑
        NSLog(@"%@",x);
    }];
}

//MARK: KVO
- (void)KVO_method {
    [self.testLabel addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"text"] && object == self.testLabel) {
        NSLog(@"%@", change);
    }
}
- (void)RAC_KVO {
    [RACObserve(self.testLabel, text) subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}

//MARK:TextFieldDelegate
- (void)RACTextFieldDelegate {
    [[self rac_signalForSelector:@selector(textFieldDidBeginEditing:) fromProtocol:@protocol(UITextFieldDelegate)]
     subscribeNext:^(RACTuple * _Nullable x) {
         NSLog(@"%@",x);
     }];
    self.testTextField.delegate = self;
}
//MARK: Notification
-(void)RACNotification {
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardDidHideNotification object:nil]
     subscribeNext:^(NSNotification * _Nullable x) {
         NSLog(@"%@",x);
     }];
}

//MARK: Notification
- (void)RACTimer {
    //主线程中每两秒执行一次
    [[RACSignal interval:2.0 onScheduler:[RACScheduler mainThreadScheduler]]
     subscribeNext:^(NSDate * _Nullable x) {
         NSLog(@"one_date = %@",x);
     }];
    
    //创建一个新线程
    [[RACSignal interval:1 onScheduler:[RACScheduler schedulerWithPriority:(RACSchedulerPriorityHigh) name:@"com.RacctiveCocoa.RACScheduler.mainThreadScheduler"]]
     subscribeNext:^(NSDate * _Nullable x) {
         NSLog(@"two_date = %@",x);
     }];
}

//MARK: 数组与字典
- (void)RACSequence {
    //遍历数组
    NSArray *racAry = @[@"rac1", @"rac2", @"rac3"];
    [racAry.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    //遍历字典
    NSDictionary *dict = @{@"name":@"dragon", @"type":@"fire", @"age":@"1000"};
    [dict.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        RACTwoTuple *tuple = (RACTwoTuple *)x;
        NSLog(@"key === %@, value === %@", tuple[0], tuple[1]);
    }];
}


@end
