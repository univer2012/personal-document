//
//  EOCAnimatedView.m
//  Number_Four
//
//  Created by huangaengoln on 15/12/16.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import "EOCAnimatedView.h"

#define ANIMATION_DURATION 0.3

static const NSTimeInterval kAnimationDuration=0.3;
//
const NSTimeInterval EOCAnimatedViewAnimationDuration=0.3;

//In the implementation file
NSString *const EOCStringConstant=@"VALUE";

@implementation EOCAnimatedView

-(void)animate {
    [UIView animateWithDuration:kAnimationDuration animations:^{
        //Perform animations
    }];
}

@end
