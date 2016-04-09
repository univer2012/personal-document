//
//  EOCRectangle.m
//  Number_Sixtheenth_1
//
//  Created by huangaengoln on 15/12/24.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import "EOCRectangle.h"

@implementation EOCRectangle
//Designated initializer
-(id)initWithWidth:(float)width andHeight:(float)height {
    if (self=[super init]) {
        _width=width;
        _height=height;
    }
    return self;
}
//Superclass's designated initializer
-(id)init {
    return [self initWithWidth:5.0f andHeight:10.0f];
}
//Initializer from NSCoding
-(id)initWithCoder:(NSCoder *)aDecoder {
    //Call through to super's designated initializer
    if (self=[super init]) {
        _width=[aDecoder decodeFloatForKey:@"width"];
        _height=[aDecoder decodeFloatForKey:@"height"];
    }
    return self;
}

@end
