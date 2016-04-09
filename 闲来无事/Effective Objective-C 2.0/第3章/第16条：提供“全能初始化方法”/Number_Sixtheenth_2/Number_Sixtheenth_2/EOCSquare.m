//
//  EOCSquare.m
//  Number_Sixtheenth_2
//
//  Created by huangaengoln on 15/12/25.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import "EOCSquare.h"

@implementation EOCSquare
//Designated initializer
-(id)initWithDimension:(float)dimension {
    return [super initWithWidth:dimension andHeight:dimension];
}
//Superclass designated initializer
-(id)initWithWidth:(float)width andHeight:(float)height {
    float dimension=MAX(width, height);
    return [self initWithDimension:dimension];
}
//NSCoding designated initializer
-(id)initWithCoder:(NSCoder *)aDecoder {
    if (self=[super initWithCoder:aDecoder]) {
        //EOCSquare's spceific initializer
    }
    return self;
}

@end
