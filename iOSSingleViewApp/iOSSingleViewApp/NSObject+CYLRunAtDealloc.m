//
//  NSObject+CYLRunAtDealloc.m
//  iOSSingleViewApp
//
//  Created by huangaengoln on 2017/12/11.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "NSObject+CYLRunAtDealloc.h"
#import <objc/runtime.h>
const void *runAtDeallocBlockKey = &runAtDeallocBlockKey;
@implementation NSObject (CYLRunAtDealloc)
-(void)cyl_runAtDealloc:(voidBlock)block {
    if (block) {
        CYLBlockExecutor *executor = [[CYLBlockExecutor alloc] initWithBlock:block];
        objc_setAssociatedObject(self, runAtDeallocBlockKey, executor, OBJC_ASSOCIATION_RETAIN);
    }
}
@end
