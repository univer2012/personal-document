//
//  CoreTextData.h
//  CoreTextDemo
//
//  Created by huangaengoln on 15/11/8.
//  Copyright (c) 2015年 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreTextData : NSObject

@property(nonatomic,assign)CTFrameRef ctFrame;
@property(nonatomic,assign)CGFloat height;
//新增加的成员
@property(nonatomic,strong)NSMutableArray *imageArray;

@end
