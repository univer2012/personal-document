//
//  YFLNotificationCenter.m
//  Custome_NotificationCenter
//
//  Created by 远平 on 2019/4/25.
//  Copyright © 2019 远平. All rights reserved.
//

#import "YFLNotificationCenter.h"

@interface YFLNotificationCenter ()
/** 观察者  */
@property (nonatomic, strong)NSMutableDictionary *obsetvers;
@end

@implementation YFLNotificationCenter

+(YFLNotificationCenter*)defaultCenter {
    static YFLNotificationCenter *singleton;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] initSingleton];
    });
    return singleton;
}

- (instancetype)initSingleton {
    if ([super init]) {
        _obsetvers = [[NSMutableDictionary alloc]init];
    }
    return self;
}


@end
