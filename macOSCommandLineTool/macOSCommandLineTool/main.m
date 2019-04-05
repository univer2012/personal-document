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
        float x = 12345.54321;
        double y = 445566778899.987654321;
        printf("%f\n",x);
        printf("%f\n",y);
    }
}

