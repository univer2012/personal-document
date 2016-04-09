//
//  EOCSoundPlayer.h
//  Number_Fiftheenth_1
//
//  Created by huangaengoln on 15/12/24.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EOCSoundPlayer;
@protocol EOCSoundPlayerDelegate <NSObject>

-(void)soundPalyerDidFinish:(EOCSoundPlayer *)player;

@end

@interface EOCSoundPlayer : NSObject
@property(nonatomic,weak)id<EOCSoundPlayerDelegate>delegate;
-(id)initWithURL:(NSURL *)url;
-(void)playSound;

@end
