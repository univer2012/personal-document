//
//  ViewController.m
//  调用信达App
//
//  Created by huangaengoln on 15/12/31.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self createButtonWithFrame:CGRectMake(10, 80, self.view.frame.size.width-20, 40) tag:1 title:@"点击调用信达BD"];
    [self createButtonWithFrame:CGRectMake(10, 130,  self.view.frame.size.width-20, 40) tag:2 title:@"点击调用信达GD"];
}

-(void)createButtonWithFrame:(CGRect)frame tag:(NSInteger)tag title:(NSString *)title {
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blueColor]];
    button.tag=tag;
    [button addTarget:self action:@selector(clickToApp:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}


-(void)clickToApp:(UIButton *)button {
    
#if 0
    NSURL *url  = [NSURL URLWithString:@"AppTwo"];
    
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        NSLog(@"canOpenURL");
        [[UIApplication sharedApplication] openURL:url];
    } else
    {
        NSLog(@"can not OpenURL");
    }
#endif
    NSURL *nsurl1=[NSURL new];
    NSURL *nsUrl=[NSURL new];
    if (button.tag == 1) {
        nsUrl=[NSURL URLWithString:@"comXindaThinkiveXinda://?Identifier=com.thinkiveBD"];
    } else if (button.tag == 2) {
        nsUrl=[NSURL URLWithString:@"comXindaThinkiveXindaGD://?Identifier=com.thinkiveGD"];
    }
//    NSLog(@"nsUrl : %@,nsurl1 : %@",nsUrl,nsurl1);
//    BOOL canOpenURL=[[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"comXindaThinkiveXinda://?Identifier=com.thinkiveBD"]];

//    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"comXindaThinkiveXinda://?Identifier=com.thinkiveBD"]]) {
//    }
    if (nsUrl) {
        [[UIApplication
          sharedApplication] openURL:nsUrl];
    }
    
    //   comXindaThinkiveXinda://?Identifier=com.thinkiveBD
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
