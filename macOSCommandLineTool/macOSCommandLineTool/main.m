//
//  main.m
//  macOSCommandLineTool
//
//  Created by huangaengoln on 2017/11/24.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FKApple.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //直接使用多个value，key的形式创建NSDictionary对象

        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[FKApple alloc] initWithColor:@"红色" weight:3.4 size:20], @"one",
                              [[FKApple alloc] initWithColor:@"绿色" weight:2.8 size:14], @"two",nil];
        //归档对象，将归档对象的数据写入NSData中
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
        //从NSData对象中恢复对象，这样既可完全深复制
        NSDictionary *dictCopy = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        FKApple *app = [dictCopy objectForKey:@"one"];
        [app setColor:@"紫色"];

        FKApple *oneApp = [dict objectForKey:@"one"];
        NSLog(@"%@",oneApp.color);
    }
}
