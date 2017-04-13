//
//  SGH0728CALayerViewController.m
//  ObjectiveCDemo-16-04-07
//
//  Created by huangaengoln on 16/7/28.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height
#import "SGH0728CALayerViewController.h"

@interface SGH0728CALayerViewController ()

@end

@implementation SGH0728CALayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view from its nib.
    [self initImageView];
}

-(void)initImageView {
    UIImage *image = [UIImage imageNamed:@"ic_0728_calayer1"];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.frame = CGRectMake((kScreenWidth - 200) / 2, (kScreenHeight - 200) / 2, 200, 200);
    imageView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:imageView];
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
