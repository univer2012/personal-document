//
//  EOCLoginManager.h
//  Number_Four
//
//  Created by huangaengoln on 15/12/16.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const EOCLoginManagerDidLoginNotification;

@interface EOCLoginManager : NSObject
-(void)login;
@end
