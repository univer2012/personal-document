//
//  ViewController.m
//  Number_Twelveth
//
//  Created by huangaengoln on 15/12/23.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import "ViewController.h"
#import "EOCAutoDictionary.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    EOCAutoDictionary *dict=[EOCAutoDictionary new];
    dict.date=[NSDate dateWithTimeIntervalSince1970:475372800];
    NSLog(@"dict.date = %@",dict.date);
    // dict.date = 1985-01-24 00:00:00 +0000
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
