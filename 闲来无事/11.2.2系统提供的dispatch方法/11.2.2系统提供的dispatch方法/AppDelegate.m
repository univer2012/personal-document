//
//  AppDelegate.m
//  11.2.2系统提供的dispatch方法
//
//  Created by huangaengoln on 15/10/27.
//  Copyright (c) 2015年 huangaengoln. All rights reserved.
//

#import "AppDelegate.h"
//----------------11.2.4  后台运行
//使用block的另一个用处是可以让程序在后台较长久地运行。在以前，当应用被按Home键退出后，应用仅有最多5分钟的时间做一些保存或清理资源的工作。但是应用可以调用UIApplication的beginBackgroundTaskWithExpirationHandler方法，让应用最多有10分钟的时间在后台长久运行。这个时间可以用来做清理本地缓存、发送统计数据等工作。
//让程序在后台长久运行的实例代码如下：
@interface AppDelegate ()

@property(nonatomic,assign)UIBackgroundTaskIdentifier backgroundUpdateTask;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self beingBackgroundUpdateTask];
    //在这里加上你需要啊长久运行的代码
    [self endBackgroundUpdateTask];
}
-(void)beingBackgroundUpdateTask {
    self.backgroundUpdateTask=[[UIApplication sharedApplication]beginBackgroundTaskWithExpirationHandler:^{
        [self endBackgroundUpdateTask];
    }];
}
-(void)endBackgroundUpdateTask {
    [[UIApplication sharedApplication]endBackgroundTask:self.backgroundUpdateTask];
    self.backgroundUpdateTask=UIBackgroundTaskInvalid;
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
