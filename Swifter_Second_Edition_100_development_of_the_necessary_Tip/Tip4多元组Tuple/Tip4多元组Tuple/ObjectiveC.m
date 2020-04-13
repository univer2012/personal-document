//
//  ObjectiveC.m
//  Tip4多元组Tuple
//
//  Created by huangaengoln on 16/4/3.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "ObjectiveC.h"
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@implementation ObjectiveC

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self p_demo];
        
    }
    return self;
}

-(void)p_demo {
    CGRect rect = CGRectMake(0, 0, 100, 100);
    CGRect small;
    CGRect large;
    CGRectDivide(rect, &small, &large, 20, CGRectMinXEdge);
    NSLog(@"small :%@ , large : %@",NSStringFromCGRect(small), NSStringFromCGRect(large));
}

@end
