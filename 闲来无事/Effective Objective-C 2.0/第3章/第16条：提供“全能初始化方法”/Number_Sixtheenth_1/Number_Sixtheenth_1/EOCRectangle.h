//
//  EOCRectangle.h
//  Number_Sixtheenth_1
//
//  Created by huangaengoln on 15/12/24.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EOCRectangle : NSObject

@property(nonatomic,assign,readonly)float width;
@property(nonatomic,assign,readonly)float height;
-(id)initWithWidth:(float)width andHeight:(float)height;

@end
