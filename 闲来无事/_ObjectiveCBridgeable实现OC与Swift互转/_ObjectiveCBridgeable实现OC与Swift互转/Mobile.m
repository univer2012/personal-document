//
//  Mobile.m
//  _ObjectiveCBridgeable实现OC与Swift互转
//
//  Created by huangaengoln on 15/11/4.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import "Mobile.h"
//Mobile.m
@implementation Mobile

-(instancetype)initWithBrand:(NSString *)brand system:(NSString *)system {
    self=[super init];
    if (self) {
        _brand=brand;
        _system=system;
    }
    return self;
}

@end
