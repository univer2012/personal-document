//
//  main.m
//  程序猿群141607754
//
//  Created by huangaengoln on 2017/1/6.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
//写测试代码用的
#import "VarArgs.h"
int main(int argc, char * argv[]) {
    @autoreleasepool {
        VarArgs *var = [[VarArgs alloc] init];
        [var test:@"疯狂iOS讲义", @"疯狂Android讲义", @"疯狂Ajax讲义", nil];
    }
}


//原来的
//int main(int argc, char * argv[]) {
//    @autoreleasepool {
//        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
//    }
//}

