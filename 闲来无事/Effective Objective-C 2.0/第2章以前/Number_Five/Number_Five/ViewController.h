//
//  ViewController.h
//  Number_Five
//
//  Created by huangaengoln on 15/12/16.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import <UIKit/UIKit.h>

// === 1
#if 0
enum EOCConnectionState {
    EOCConnectionStateDisconnected,
    EOCConnectionStateConnecting,
    EOCConnectionStateConnected,
};
enum EOCConnectionState state=EOCConnectionStateDisconnected;

// === 2
#elif 0
enum EOCConnectionState {
    EOCConnectionStateDisConnected,
    EOCConnectionStateConnecting,
    EOCConnectionStateConnected,
};
typedef enum EOCConnectionState EOCConnectionState;

EOCConnectionState state=EOCConnectionStateDisConnected;
// === 3
#elif 0

//enum EOCConnectionStateConnectionnState:NSInteger;
enum EOCConnectionStateConnectionnState :NSInteger {
    EOCConnectionStateDisconnected =1,
    EOCConnectionStateConnecting,
    EOCConnectionStateConnected,
};
#elif 1
// === 4
#if 0
typedef NS_ENUM(NSUInteger,EOCConnectionState) {
    EOCConnectionStateDisconnected,
    EOCConnectionStateConnecting,
    EOCConnectionStateConnected,
};

typedef NS_OPTIONS(NSUInteger, EOCPermittedDirection) {
    EOCPermittedDirectionUp = 1 << 0,
    EOCPermittedDirectionDown = 1 << 1,
    EOCPermittedDirectionLeft = 1 << 2,
    EOCPermittedDirectionRight = 1 << 3,
};
#endif

// === > 如果支持新特性，那么用NS_ENUM宏所定义的枚举类型展开之后就是：
typedef enum EOCConnectionState : NSUInteger EOCConnectionState;
enum EOCConnectionState :NSUInteger {
    EOCConnectionStateDisconnected,
    EOCConnectionStateConnecting,
    EOCConnectionStateConnected,
};

#endif


@interface ViewController : UIViewController


@end

