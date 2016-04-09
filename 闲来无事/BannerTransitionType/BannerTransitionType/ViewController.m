//
//  ViewController.m
//  BannerTransitionType
//
//  Created by huangaengoln on 16/1/27.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "ViewController.h"
#import "SGHBanner3DTransitionView.h"

@interface ViewController ()<SGHBanner3DTransitionViewImageDelegate> {
    UIImageView *_imageView;
    int _currentIndex;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SGHBanner3DTransitionView *banner3DTransitionView=[[SGHBanner3DTransitionView alloc]initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, 180)];
    banner3DTransitionView.delegate=self;
    [banner3DTransitionView show3DBannerView];
    [self.view addSubview:banner3DTransitionView];
    
}

//点击了第几张图片
-(void)ClickImage:(int)index {
     NSLog(@"点击了第%d张",index);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
