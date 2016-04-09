//
//  CTFrameParserConfig.m
//  CoreTextDemo
//
//  Created by huangaengoln on 15/11/8.
//  Copyright (c) 2015年 huangaengoln. All rights reserved.
//

#import "CTFrameParserConfig.h"

@implementation CTFrameParserConfig
- (instancetype)init
{
    self = [super init];
    if (self) {
        _width=200.0f;
        _fontSize=16.0f;
        _lineSpace=8.0f;
        _textColor=RGB(108, 108, 108);
    }
    return self;
}

@end
