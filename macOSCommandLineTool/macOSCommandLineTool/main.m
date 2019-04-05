//
//  main.m
//  macOSCommandLineTool
//
//  Created by huangaengoln on 2017/11/24.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FKApple.h"

#include "stdio.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int i = 123;
        float a= 12.34567;
        printf("% 6d % 10.4f\n",i, a);
        printf("%-6d % 10.4f\n",i, a);
        printf("% 6d%- 10.4f\n",i, a);
    }
}

