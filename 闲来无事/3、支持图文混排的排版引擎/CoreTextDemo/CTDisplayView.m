//
//  CTDisplayView.m
//  CoreTextDemo
//
//  Created by huangaengoln on 15/11/8.
//  Copyright (c) 2015年 huangaengoln. All rights reserved.
//

#import "CTDisplayView.h"
#import <CoreText/CoreText.h>
#import "CoreTextImageData.h"

typedef enum CTDisplayViewState:NSInteger {
    CTDisplayViewStateNormal,
    CTDisplayViewStateTouching,
    CTDisplayViewStaeSelecting
}CTDisplayViewState;

@interface CTDisplayView ()
@property(nonatomic)CTDisplayViewState state;

@end

@implementation CTDisplayView



-(void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (self.data == nil) {
        return;
    }
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    if (self.state == CTDisplayViewStateTouching || self.state == CTDisplayViewStaeSelecting) {
//        [self ]
    }
    CTFrameDraw(self.data.ctFrame, context);
    for (CoreTextImageData *imageData in self.data.imageArray) {
        UIImage *image=[UIImage imageNamed:imageData.name];
        if (image) {
            CGContextDrawImage(context, imageData.imagePostion, image.CGImage);
        }
    }
    
//    if (self.data) {
//        CTFrameDraw(self.data.ctFrame, context);
//    }
}

@end
