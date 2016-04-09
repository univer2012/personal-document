//
//  EOCRectangle.m
//  Number_Sixtheenth_1
//
//  Created by huangaengoln on 15/12/24.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import "EOCRectangle.h"

@implementation EOCRectangle

-(id)initWithWidth:(float)width andHeight:(float)height {
    if (self=[super init]) {
        _width=width;
        _height=height;
    }
    return self;
}
#if 0
//Using default values
- (id)init {
    return [self initWithWidth:5.0f andHeight:10.0f];
}
#elif 1
//Throwing an exception
-(id)init {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Must use initWithWidth:andHeight: instead." userInfo:nil];
}


#endif

@end
