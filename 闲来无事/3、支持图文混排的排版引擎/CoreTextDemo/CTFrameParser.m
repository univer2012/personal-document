//
//  CTFrameParser.m
//  CoreTextDemo
//
//  Created by huangaengoln on 15/11/8.
//  Copyright (c) 2015年 huangaengoln. All rights reserved.
//

#import "CTFrameParser.h"
#import "CoreTextData.h"
#import "CoreTextImageData.h"

@implementation CTFrameParser

+(NSMutableDictionary *)attributesWithConfig:(CTFrameParserConfig *)config {
    CGFloat fontSize=config.fontSize;
    CTFontRef fontRef=CTFontCreateWithName((CFStringRef)@"ArialMT",fontSize,NULL);
    CGFloat lineSpacing=config.lineSpace;
    const CFIndex kNumberOfSettings=3;
    CTParagraphStyleSetting theSettings[kNumberOfSettings]= {
        {kCTParagraphStyleSpecifierLineSpacingAdjustment,sizeof(CGFloat),&lineSpacing},
        {kCTParagraphStyleSpecifierMaximumLineSpacing,sizeof(CGFloat),&lineSpacing},
        {kCTParagraphStyleSpecifierMinimumLineSpacing,sizeof(CGFloat),&lineSpacing}
    };
    CTParagraphStyleRef theParagraphRef=CTParagraphStyleCreate(theSettings, kNumberOfSettings);
    NSLog(@"config : %@",config);
    UIColor *textColor=[UIColor whiteColor];//config.textColor;
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    dict[(id)kCTForegroundColorAttributeName]=(id)textColor.CGColor;
    dict[(id)kCTFontAttributeName]=(__bridge id)fontRef;
    dict[(id)kCTParagraphStyleAttributeName]=(__bridge id)theParagraphRef;
    
    CFRelease(theParagraphRef);
    CFRelease(fontRef);
    return dict;
}
+(CoreTextData *)parseContent:(NSString *)content config:(CTFrameParserConfig *)config {
    
    NSDictionary *attributes=[self attributesWithConfig:config];
    NSAttributedString *contentString=[[NSAttributedString alloc]initWithString:content attributes:attributes];
    return [self parseAttributedContent:contentString config:config];
}
//方法六 --是方法五的一个辅助函数，供方法调用。
+(CTFrameRef)createFrameWithFramesetter:(CTFramesetterRef)framesetter config:(CTFrameParserConfig *)config height:(CGFloat)height {
    CGMutablePathRef path=CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, config.width, height));
    CTFrameRef frame=CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CFRelease(path);
    return frame;
}
//方法一 -- 用于提供对外的借款，调用方法二实现从一个JSON的模板文件汇总读取内容，然后调用方法五生成CoreTextData
+(CoreTextData *)parseTemplateFile:(NSString *)path config:(CTFrameParserConfig *)config {
    NSMutableArray *imageArray=[NSMutableArray array];
    NSAttributedString *content=[self loadTemplateFile:path config:config imageArray:imageArray];
    CoreTextData *data=[self parseAttributedContent:content config:config];
    data.imageArray=imageArray;
    return data;
}
//方法二 -- 读取JSON文件内容，并且调用方法三获得从NSDictionary 到 NSAttributedString的转换结果。
+(NSAttributedString *)loadTemplateFile:(NSString *)path config:(CTFrameParserConfig *)config imageArray:(NSMutableArray *)imageArray {
    NSData *data=[NSData dataWithContentsOfFile:path];
    NSMutableAttributedString *result=[[NSMutableAttributedString alloc]init];
    if (data) {
        NSArray *array=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if ([array isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dict in array) {
                NSString *type=dict[@"type"];
                if ([type isEqualToString:@"txt"]) {
                    NSAttributedString *as=[self parseAttributedContentFromNSDictionary:dict config:config];
                    [result appendAttributedString:as];
                } else if ([type isEqualToString:@"img"]) {
                    //创建 CoreTextImageData
                    CoreTextImageData *imageData=[[CoreTextImageData alloc]init];
                    imageData.name=dict[@"name"];
                    imageData.postiton=(int)[result length];
                    [imageArray addObject:imageData];
                    //创建空白占位符，并且设置它的 CTRunDelegate 信息
                    NSAttributedString *as=[self parseImageDataFromNSDictionary:dict config:config];
                    [result appendAttributedString:as];
                }
            }
        }
    }
    return result;
}
static CGFloat ascentCallback(void *ref) {
    return [(NSNumber *)[(__bridge NSDictionary *)ref objectForKey:@"height"] floatValue];
}
static CGFloat descentCallback(void  *ref) {
    return 0;
}
static CGFloat widthCallback(void *ref) {
    return [(NSNumber *)[(__bridge NSDictionary *)ref objectForKey:@"width"] floatValue];
}

+(NSAttributedString *)parseImageDataFromNSDictionary:(NSDictionary *)dict config:(CTFrameParserConfig *)config {
    CTRunDelegateCallbacks callbacks;
    memset(&callbacks, 0, sizeof(CTRunDelegateCallbacks));
    callbacks.version=kCTRunDelegateVersion1;
    callbacks.getAscent=ascentCallback;
    callbacks.getDescent=descentCallback;
    callbacks.getWidth=widthCallback;
    CTRunDelegateRef delegate=CTRunDelegateCreate(&callbacks, (__bridge void *)dict);
    //使用0xFFFC作为空白的占位符
    unichar objectReplacementChar=0xFFFC;
    NSString *content=[NSString stringWithCharacters:&objectReplacementChar length:1];
    NSDictionary *attributes=[self attributesWithConfig:config];
    NSMutableAttributedString *space=[[NSMutableAttributedString alloc]initWithString:content attributes:attributes];
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)space, CFRangeMake(0, 1), kCTRunDelegateAttributeName, delegate);
    CFRelease(delegate);
    return space;
    
}


//方法三 -- 将 NSDictionary 内容转换为 NSAttributedString
+(NSAttributedString *)parseAttributedContentFromNSDictionary:(NSDictionary *)dict config:(CTFrameParserConfig *)config {
    NSMutableDictionary *attributes=[self attributesWithConfig:config];
    //set color
    UIColor *color=[self colorFromTemplate:dict[@"color"]];
    if (color) {
        attributes[(id)kCTForegroundColorAttributeName]=(id)color.CGColor;
    } else {        //json 数据里面没有"color"键值数据时
        attributes[(id)kCTForegroundColorAttributeName]=(id)[UIColor darkGrayColor].CGColor;
    }
    //set font size
    CGFloat fontSize=[dict[@"size"] floatValue];
    if (fontSize>0) {
        CTFontRef fontRef=CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
        attributes[(id)kCTFontAttributeName]=(__bridge id)fontRef;
        CFRelease(fontRef);
    }
    NSString *content=dict[@"content"];
    return [[NSAttributedString alloc]initWithString:content attributes:attributes];
}
//方法四 -- 提供将NSString 转换为 UIColor 的功能。
+(UIColor *)colorFromTemplate:(NSString *)name {
    if ([name isEqualToString:@"blue"]) {
        return [UIColor blueColor];
    } else if ([name isEqualToString:@"red"]) {
        return [UIColor redColor];
    } else if ([name isEqualToString:@"black"]) {
        return [UIColor blackColor];
    } else if ([name isEqualToString:@"default"]) {
        return [UIColor blackColor];
    }
    else {
        return nil;
    }
}
//方法五 -- 接受一个 NSAttributedString 和一个config 参数，将 NSAttributedString 转换成 CoreTextData 返回
+(CoreTextData *)parseAttributedContent:(NSAttributedString *)content config:(CTFrameParserConfig *)config {
    //创建 CTFramesetterRef 实例
    CTFramesetterRef framesetter=CTFramesetterCreateWithAttributedString((CFAttributedStringRef)content);
    //获得要缓存的区域的高度
    CGSize restrictSize=CGSizeMake(config.width, CGFLOAT_MAX);
    CGSize coreTextSize=CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), nil, restrictSize, nil);
    CGFloat textHeight=coreTextSize.height;
    
    //生成 CTFrameRef 实例
    CTFrameRef frame=[self createFrameWithFramesetter:framesetter config:config height:textHeight];
    
    //将生成好的  实例和计算好的缓滞高度保存到CoreTextData实例中，
    //最后返回CoreTextData 实例
    CoreTextData *data=[[CoreTextData alloc]init];
    data.ctFrame=frame;
    data.height=textHeight;
    
    //释放内存
    CFRelease(frame);
    CFRelease(framesetter);
    return data;
}



@end
