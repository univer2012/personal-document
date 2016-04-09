//
//  ViewController.m
//  从xcassets获取图片
//
//  Created by huangaengoln on 15/11/9.
//  Copyright (c) 2015年 huangaengoln. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    imageView.image=[UIImage imageNamed:@"LaunchImage"];
    [self.view addSubview:imageView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
