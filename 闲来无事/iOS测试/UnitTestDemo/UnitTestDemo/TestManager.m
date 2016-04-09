//
//  TestManager.m
//  UnitTestDemo
//
//  Created by huangaengoln on 16/1/27.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "TestManager.h"

@implementation TestManager

+(TestManager *)sharedManager {
    static dispatch_once_t onceToken;
    static TestManager *testManager;
    dispatch_once(&onceToken, ^{
        testManager=[[TestManager alloc]init];
    });
    return testManager;
}
-(NSInteger)addNuber:(NSInteger)a withNumber:(NSInteger )b {
    return a+b;
}

@end
