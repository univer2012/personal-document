//
//  SGHObject.h
//  iOSSingleViewApp
//
//  Created by huangaengoln on 2017/12/11.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct SGHStruct {
    int a;
    int b;
} *my_struct;

@interface SGHObject : NSObject
@property (nonatomic, assign) my_struct arg3;
@property (nonatomic, copy)  NSString *arg1;
@property (nonatomic, copy) NSString *arg2;
@end
