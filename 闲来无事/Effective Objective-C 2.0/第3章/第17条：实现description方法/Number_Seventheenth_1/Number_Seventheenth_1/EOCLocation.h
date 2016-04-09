//
//  EOCLocation.h
//  Number_Seventheenth_1
//
//  Created by huangaengoln on 15/12/25.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EOCLocation : NSObject
@property(nonatomic,copy,readonly)NSString *title;
@property(nonatomic,assign,readonly)float latitude;
@property(nonatomic,assign,readonly)float longitude;
-(id)initWithTitle:(NSString *)title latitude:(float)latitude longitude:(float)longitude;

@end
