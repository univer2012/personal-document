//
//  PasswordInputWindow.h
//  CoreFoundation对象的内存管理
//
//  Created by huangaengoln on 15/11/7.
//  Copyright (c) 2015年 huangaengoln. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PasswordInputWindow : UIWindow

+(PasswordInputWindow *)sharedInstance;
-(void)show;

@end
