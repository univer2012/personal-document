//
//  Mobile.h
//  _ObjectiveCBridgeable实现OC与Swift互转
//
//  Created by huangaengoln on 15/11/4.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//
//Mobile.h
#import <Foundation/Foundation.h>

@interface Mobile : NSObject
@property(nonatomic,strong)NSString *brand;
@property(nonatomic,strong)NSString *system;
-(instancetype)initWithBrand:(NSString *)brand system:(NSString *)system;

@end
