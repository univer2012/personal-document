//
//  AppDelegate.h
//  ObjectiveCDemo-16-04-07
//
//  Created by huangaengoln on 16/4/7.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

+ (instancetype)sharedDelegate;

@property (strong, nonatomic) UIWindow *window;

/* 用于保存后台下载任务完成后的回调代码块 */
@property (copy) void (^backgroundURLSessionCompletionHandler)();

@end

