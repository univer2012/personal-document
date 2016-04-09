//
//  EOCLocation.m
//  Number_Seventheenth_1
//
//  Created by huangaengoln on 15/12/25.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import "EOCLocation.h"

@implementation EOCLocation

-(id)initWithTitle:(NSString *)title latitude:(float)latitude longitude:(float)longitude {
    if (self=[super init]) {
        _title=[title copy];
        _latitude=latitude;
        _longitude=longitude;
    }
    return self;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, %@>",[self class],self,
  @{@"title":_title,
    @"latitude":@(_latitude),
    @"longitude":@(_longitude)}];
}

@end
