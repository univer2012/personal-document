//
//  EOCLoginManager.m
//  Number_Four
//
//  Created by huangaengoln on 15/12/16.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import "EOCLoginManager.h"
NSString *const EOCLoginManagerDidLoginNotification=@"EOCLoginManagerDidLoginNotification";

@implementation EOCLoginManager
-(void)login {
    //Perform login asynchronously, then call 'p_didLogin'.
}
-(void)p_didLogin {
    [[NSNotificationCenter defaultCenter]postNotificationName:EOCLoginManagerDidLoginNotification object:nil];
}

@end
