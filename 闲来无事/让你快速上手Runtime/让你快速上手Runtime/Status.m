//
//  Status.m
//  让你快速上手Runtime
//
//  Created by huangaengoln on 15/10/29.
//  Copyright (c) 2015年 huangaengoln. All rights reserved.
//

#import "Status.h"

@implementation Status

+(instancetype)statusWithDict:(NSDictionary *)dict {
    Status *status=[[self alloc]init];
    [status setValuesForKeysWithDictionary:dict];
    return status;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
