//
//  AppDelegate.m
//  iOSSingleViewApp
//
//  Created by huangaengoln on 2017/11/19.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@property(nonatomic, assign)int count;
@end

@implementation AppDelegate
@synthesize count;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //启动一个定时器
    //[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(info:) userInfo:nil repeats:YES];
    return YES;
}
//-(void)info:(NSTimer *)timer {
//    NSLog(@"正在执行第%ld次任务",(long)self.count++);
//    //如果count的值大于10，取消定时器
//    if (self.count > 10) {
//        NSLog(@"取消执行定时器");
//        [timer invalidate];
//    }
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
