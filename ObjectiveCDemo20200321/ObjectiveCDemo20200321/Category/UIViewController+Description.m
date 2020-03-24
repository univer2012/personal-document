//
//  UIViewController+Description.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/3/24.
//  Copyright © 2020 远平. All rights reserved.
//

#import "UIViewController+Description.h"


@implementation UIViewController (Description)

- (void)showDescWith:(NSString *)text {
    ///文字说明
    UILabel *tipLab = [UILabel new];
    tipLab.backgroundColor = UIColor.systemBlueColor;
    tipLab.textColor = UIColor.whiteColor;
    tipLab.numberOfLines = 0;
    tipLab.text = text;
    [self.view addSubview:tipLab];
    [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(88);
    }];
}
@end
