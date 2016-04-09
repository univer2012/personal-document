//
//  CoreTextLinkData.h
//  CoreTextDemo
//
//  Created by huangaengoln on 15/11/8.
//  Copyright (c) 2015年 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreTextLinkData : NSObject

@property(strong,nonatomic)NSString *title;
@property(strong,nonatomic)NSString *url;
@property(assign,nonatomic)NSRange range;

@end
