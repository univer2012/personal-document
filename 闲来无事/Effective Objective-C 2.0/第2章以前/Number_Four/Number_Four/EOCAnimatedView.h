//
//  EOCAnimatedView.h
//  Number_Four
//
//  Created by huangaengoln on 15/12/16.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//
//注意常量的名字。为避免冲突，最好是用预支相关的类名做前缀。
#import <UIKit/UIKit.h>
//In the header file
extern NSString *const EOCStringConstant;
//
extern const NSTimeInterval EOCAnimatedViewAnimationDuration;

@interface EOCAnimatedView : UIView
-(void)animate;

@end
