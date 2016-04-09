//
//  CTFrameParser.h
//  CoreTextDemo
//
//  Created by huangaengoln on 15/11/8.
//  Copyright (c) 2015年 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTFrameParserConfig.h"
@class CoreTextData;

@interface CTFrameParser : NSObject
+(CoreTextData *)parseContent:(NSString *)content config:(CTFrameParserConfig *)config;

@end
