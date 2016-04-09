//
//  AppDelegate.m
//  CoreFoundation对象的内存管理
//
//  Created by huangaengoln on 15/11/7.
//  Copyright (c) 2015年 huangaengoln. All rights reserved.
//

#import "AppDelegate.h"
//#import "ViewController.h"
#import "PasswordInputWindow.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    ViewController *viewCtrl=[[ViewController alloc]init];
//    self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.window.backgroundColor=[UIColor whiteColor];
//    self.window.rootViewController=viewCtrl;
//    [self.window makeKeyAndVisible];
    NSLog(@"UIWindowLevelNormal=%f UIWindowLevelStatusBar=%f UIWindowLevelAlert=%f",UIWindowLevelNormal,UIWindowLevelStatusBar,UIWindowLevelAlert);
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

//AppDelegate.m 文件
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//    [self beginBackgroundUpdateTask];
//    // ... ... 在这里加上你需要长久运行的代码
//    [self endBackgroundUpdateTask];
}
-(void)beginBackgroundUpdateTask {
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
    [[PasswordInputWindow sharedInstance]show];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
