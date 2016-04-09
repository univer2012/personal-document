//
//  CoreTextData.m
//  CoreTextDemo
//
//  Created by huangaengoln on 15/11/8.
//  Copyright (c) 2015年 huangaengoln. All rights reserved.
//

#import "CoreTextData.h"

@implementation CoreTextData
-(void)setCtFrame:(CTFrameRef)ctFrame {
    if (_ctFrame!=ctFrame) {
        if (_ctFrame!=nil) {
            CFRelease(_ctFrame);
        }
        CFRetain(ctFrame);
        _ctFrame=ctFrame;
    }
}
-(void)dealloc {
    if (_ctFrame!=nil) {
        CFRelease(_ctFrame);
        _ctFrame=nil;
    }
}

@end
