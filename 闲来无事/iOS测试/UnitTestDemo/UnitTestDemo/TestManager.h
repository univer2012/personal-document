//
//  TestManager.h
//  UnitTestDemo
//
//  Created by huangaengoln on 16/1/27.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestManager : NSObject
+(TestManager *)sharedManager;
-(NSInteger)addNuber:(NSInteger)a withNumber:(NSInteger )b;

@end
