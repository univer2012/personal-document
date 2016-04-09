//
//  MMLabel.m
//  Masonry_test_16_01_25
//
//  Created by huangaengoln on 16/1/25.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "MMLabel.h"

@implementation MMLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(CGSize)intrinsicContentSize {
    CGSize size=[super intrinsicContentSize];
    NSLog(@"%@",NSStringFromCGSize(size));
    return size;
}

@end
