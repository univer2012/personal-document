//
//  CTDisplayView.h
//  CoreTextDemo
//
//  Created by huangaengoln on 15/11/8.
//  Copyright (c) 2015年 huangaengoln. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreTextData.h"
#import "UIView+frameAdjust.h"
#import "CTFrameParserConfig.h"
#import "CTFrameParser.h"

@interface CTDisplayView : UIView
@property(strong,nonatomic)CoreTextData *data;

@end
