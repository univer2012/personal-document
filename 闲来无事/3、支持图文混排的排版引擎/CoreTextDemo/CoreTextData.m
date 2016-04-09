//
//  CoreTextData.m
//  CoreTextDemo
//
//  Created by huangaengoln on 15/11/8.
//  Copyright (c) 2015年 huangaengoln. All rights reserved.
//

#import "CoreTextData.h"
#import "CoreTextImageData.h"

@implementation CoreTextData
-(void)setImageArray:(NSMutableArray *)imageArray {
    _imageArray=imageArray;
    [self fillImagePosition];
}
-(void)fillImagePosition {
    if (self.imageArray.count == 0) {
        return;
    }
    NSArray *lines=(NSArray *)CTFrameGetLines(self.ctFrame);
    int lineCount=(int)[lines count];
    CGPoint lineOrigins[lineCount];
    CTFrameGetLineOrigins(self.ctFrame, CFRangeMake(0, 0), lineOrigins);
    
    int imgIndex=0;
    CoreTextImageData *imageData=self.imageArray[0];
    for (int i=0; i<lineCount; i++) {
        if (imageData == nil) {
            break;
        }
        CTLineRef line=(__bridge CTLineRef)lines[i];
        NSArray *runObjArray = (NSArray *)CTLineGetGlyphRuns(line);
        for (id runObj in runObjArray) {
            CTRunRef run=(__bridge CTRunRef)runObj;
            NSDictionary *runAttributes=(NSDictionary *)CTRunGetAttributes(run);
            CTRunDelegateRef delegate=(__bridge CTRunDelegateRef)[runAttributes valueForKey:(id)kCTRunDelegateAttributeName];
            if (delegate == nil) {
                continue;
            }
            NSDictionary *metaDic=CTRunDelegateGetRefCon(delegate);
            if (![metaDic isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            CGRect runBounds;
            CGFloat ascent;
            CGFloat descent;
            runBounds.size.width=CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL);
            runBounds.size.height=ascent+descent;
            
            CGFloat xOffset=CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
            runBounds.origin.x=lineOrigins[i].x+xOffset;
            runBounds.origin.y=lineOrigins[i].y;
            runBounds.origin.y -= descent;//////////////之前少了一个减号。。。
            CGPathRef pathRef=CTFrameGetPath(self.ctFrame);
            CGRect colRect=CGPathGetBoundingBox(pathRef);
            
            CGRect delegateBounds=CGRectOffset(runBounds, colRect.origin.x, colRect.origin.y);
            
            imageData.imagePostion=delegateBounds;
            imgIndex++;
            if (imgIndex == self.imageArray.count) {
                imageData=nil;
                break;
            }else {
                imageData=self.imageArray[imgIndex];
            }
        }
    }
}

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
