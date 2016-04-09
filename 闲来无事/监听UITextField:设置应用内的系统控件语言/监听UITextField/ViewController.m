//
//  ViewController.m
//  监听UITextField
//
//  Created by huangaengoln on 15/10/28.
//  Copyright (c) 2015年 huangaengoln. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,weak)UILabel *label;
@end

@implementation ViewController{
    NSInteger secondsCountDown; //倒计时总时间
    NSTimer *countDownTimer;    //计时器
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
#if 0
    UITextField *textField=[[UITextField alloc]initWithFrame:CGRectMake(10, 50, 100, 30)];
    [self.view addSubview:textField];
    textField.backgroundColor=[UIColor yellowColor];
    [textField addTarget:self action:@selector(textFieldChanged) forControlEvents:UIControlEventEditingChanged];
#endif
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame=CGRectMake(30, 60, 80, 40);
    btn.backgroundColor=[UIColor yellowColor];
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    label.text=@"你好";
    _label=label;
    [btn addSubview:label];
    
    UITextField *textField=[UITextField new];
    textField.frame=CGRectMake(20, 100, 280, 40);
    textField.backgroundColor=[UIColor lightGrayColor];
    [self.view addSubview:textField];
}
-(void)buttonClick:(UIButton *)sender {
    secondsCountDown=5;    //5秒
    countDownTimer=[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
}
//倒计时
-(void)timeFireMethod {
    _label.text=[NSString stringWithFormat:@"倒计时%ld",(long)--secondsCountDown];
    if (secondsCountDown == 0) {
        [countDownTimer invalidate];
    }
}
-(void)textFieldChanged {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
