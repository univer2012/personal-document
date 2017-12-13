//
//  SGHObject.m
//  iOSSingleViewApp
//
//  Created by huangaengoln on 2017/12/11.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "SGHObject.h"
@implementation SGHObject
// 在堆上分配的内存，我们要手动释放掉
- (void)dealloc {
    free(self.arg3);
}
@end
