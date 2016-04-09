//
//  CoreTextImageData.h
//  CoreTextDemo
//
//  Created by huangaengoln on 15/11/8.
//  Copyright (c) 2015年 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreTextImageData : NSObject

@property(nonatomic,strong)NSString *name;
@property(nonatomic) int postiton;
// 此坐标是 CoreText 的坐标系，而不是UIKit的坐标系
@property(nonatomic)CGRect imagePostion;

@end
