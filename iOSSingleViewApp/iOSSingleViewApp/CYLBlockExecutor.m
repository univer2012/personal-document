//
//  CYLBlockExecutor.m
//  iOSSingleViewApp
//
//  Created by huangaengoln on 2017/12/11.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "CYLBlockExecutor.h"
@interface CYLBlockExecutor() {
    voidBlock _block;
}
@end

@implementation CYLBlockExecutor
-(id)initWithBlock:(voidBlock)aBlock {
    self = [super init];
    if (self) {
        _block = [aBlock copy];
    }
    return self;
}
-(void)dealloc {
    _block ? _block() : nil;
}
@end
