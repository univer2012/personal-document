//
//  BaseController.m
//  Masonry_test_16_01_25
//
//  Created by huangaengoln on 16/1/25.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "BaseController.h"

@interface BaseController ()

@end

@implementation BaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    // 等同于make.top.equalTo(self.mas_topLayoutGuide);
    self.edgesForExtendedLayout =UIRectEdgeNone;
    
    //当controller有且只有一个scrollView时，系统会自动加 下面的属性
    self.automaticallyAdjustsScrollViewInsets=NO;
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
