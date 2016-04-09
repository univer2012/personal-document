//
//  EOCSquare.m
//  Number_Sixtheenth_1
//
//  Created by huangaengoln on 15/12/24.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import "EOCSquare.h"




@implementation EOCSquare

-(id)initWithDimension:(float)dimension {
    return [super initWithWidth:dimension andHeight:dimension];
}

//继承时需要注意的一个重要问题：如果子类的全能初始化方法与超类方法的名称不同，那么总应覆写超类的全能初始化方法。
#if 0
-(id)initWithWidth:(float)width andHeight:(float)height {
    float dimension=MAX(width, height);
    return [self initWithDimension:dimension];
}
#elif 1
//不想覆写超类的全能初始化方法。 ===>>> 常用的方法是覆写超类的全能初始化方法并于其中抛出异常：
-(id)initWithWidth:(float)width andHeight:(float)height {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Must use initWithDimension: instead." userInfo:nil];
}
//如果像上面那样抛出了异常，那么，调用init方法也会抛出异常，因为init方法也得调用“initWithWidth:andHeight:”.此时可以覆写init方法，并在其中以合理的默认值来调用“initWithDimension:”方法：
-(id)init {
    return [self initWithDimension:5.0f];
}

#endif


@end
