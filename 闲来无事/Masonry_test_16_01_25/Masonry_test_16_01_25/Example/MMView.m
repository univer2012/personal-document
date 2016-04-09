//
//  MMView.m
//  Masonry_test_16_01_25
//
//  Created by huangaengoln on 16/1/25.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "MMView.h"

@implementation MMView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/**
* - (CGSize)intrinsicContentSize
Description
Returns the natural size for the receiving view, considering only properties of the view itself.
A size indicating the natural size for the receiving view based on its intrinsic properties.
Returns	A size indicating the natural size for the receiving view based on its intrinsic properties.
Availability	iOS (6.0 and later)
Declared In	UIView.h
*/
-(CGSize)intrinsicContentSize {

    return self.innerSize;
}

@end
