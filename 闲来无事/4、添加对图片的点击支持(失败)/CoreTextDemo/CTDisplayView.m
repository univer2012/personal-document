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
#import "CoreTextLinkData.h"
#import "CoreTextUtils.h"

typedef enum CTDisplayViewState:NSInteger {
    CTDisplayViewStateNormal,
    CTDisplayViewStateTouching,
    CTDisplayViewStaeSelecting
}CTDisplayViewState;

@interface CTDisplayView ()<UIGestureRecognizerDelegate>
@property(nonatomic)CTDisplayViewState state;

@end

@implementation CTDisplayView
#if 0

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupEvents];
    }
    return self;
}


-(void)setupEvents {
    UIGestureRecognizer *tapRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userTapGestureDetected:)];
    tapRecognizer.delegate=self;
    [self addGestureRecognizer:tapRecognizer];
    self.userInteractionEnabled=YES;
}
-(void)userTapGestureDetected:(UIGestureRecognizer *)recognizer {
    CGPoint point=[recognizer locationInView: self];
    for (CoreTextImageData *imageData in self.data.imageArray) {
        //翻转坐标系，因为imageData中的坐标使CoreText的坐标系
        CGRect imageRect=imageData.imagePostion;
        CGPoint imagePosition=imageRect.origin;
        imagePosition.y=self.bounds.size.height-imageRect.origin.y-imageRect.size.height;
        CGRect rect=CGRectMake(imagePosition.x, imagePosition.y, imageRect.size.width, imageRect.size.height);
        //检测点击位置Point是否在rect之内
        if (CGRectContainsPoint(rect, point)) {
            //在这里处理点击后的逻辑
            NSLog(@"bingo");
            break;
        }
    }
    CoreTextLinkData *linkData=[CoreTextUtils touchLinkInView:self atPoint:point data:_data];
    if (linkData) {
        NSLog(@"hint link!");
        return;
    }
}
#endif

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
