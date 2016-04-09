//
//  AppDelegate.h
//  CoreFoundation对象的内存管理
//
//  Created by huangaengoln on 15/11/7.
//  Copyright (c) 2015年 huangaengoln. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//AppDelegate.h文件
@property(nonatomic,assign)UIBackgroundTaskIdentifier backgroundUpdateTask;

@end

