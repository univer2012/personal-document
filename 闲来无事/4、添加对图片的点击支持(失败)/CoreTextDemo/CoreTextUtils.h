//
//  CoreTextUtils.h
//  CoreTextDemo
//
//  Created by huangaengoln on 15/11/8.
//  Copyright (c) 2015年 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreTextLinkData.h"
#import "CoreTextData.h"

@interface CoreTextUtils : NSObject
+(CoreTextLinkData *)touchLinkInView:(UIView *)view atPoint:(CGPoint)point data:(CoreTextData *)data;

@end
