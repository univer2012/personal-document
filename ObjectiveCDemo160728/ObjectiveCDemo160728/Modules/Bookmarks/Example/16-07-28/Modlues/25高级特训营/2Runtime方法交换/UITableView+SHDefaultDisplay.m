//
//  UITableView+SHDefaultDisplay.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/2/27.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "UITableView+SHDefaultDisplay.h"

#import <objc/runtime.h>
#import <objc/message.h>

const char *LGDefaultView;

@implementation UITableView (SHDefaultDisplay)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originMethod = class_getInstanceMethod(self,@selecror(reloadData));
        Method
    });
    
}
- (void)lg_reloadData {
    
}

@end
