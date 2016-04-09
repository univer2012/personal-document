//
//  Base2Controller.m
//  Masonry_test_16_01_25
//
//  Created by huangaengoln on 16/1/25.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "Base2Controller.h"

@interface Base2Controller ()

@end

@implementation Base2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView *playerView=({
        UIView *view=[UIView new];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.view);
            make.height.equalTo(view.mas_width).multipliedBy(9.0f/16.0f);
        }];
        view.backgroundColor=[UIColor blackColor];
        
        view;
    });
    
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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
