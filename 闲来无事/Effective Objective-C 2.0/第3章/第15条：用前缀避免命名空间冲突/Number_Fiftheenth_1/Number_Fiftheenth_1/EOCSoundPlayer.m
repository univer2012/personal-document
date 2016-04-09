//
//  EOCSoundPlayer.m
//  Number_Fiftheenth_1
//
//  Created by huangaengoln on 15/12/24.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import "EOCSoundPlayer.h"
#import <AudioToolbox/AudioToolbox.h>

//void completion(SystemSoundID ssID,void *clientData) {
//我们总是应该给这种C函数的名字加上前缀。
// ===>>>
void EOCSoundPlayerCompletion(SystemSoundID ssID,void *clientData) {
    EOCSoundPlayer *player=(__bridge EOCSoundPlayer *)clientData;
    if ([player.delegate respondsToSelector:@selector(soundPalyerDidFinish:)]) {
        [player.delegate soundPalyerDidFinish:player];
    }
}

@implementation EOCSoundPlayer {
    SystemSoundID _systemSoundID;
}

-(id)initWithURL:(NSURL *)url {
    if (self=[super init]) {
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &_systemSoundID);
    }
    return self;
}

-(void)dealloc {
    AudioServicesDisposeSystemSoundID(_systemSoundID);
}

-(void)playSound {
    AudioServicesAddSystemSoundCompletion(_systemSoundID, NULL, NULL, EOCSoundPlayerCompletion, (__bridge void *)self);
    AudioServicesPlaySystemSound(_systemSoundID);
}


@end
