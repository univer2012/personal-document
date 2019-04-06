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

void turn(int arra[][4], int arrb[][3]);


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        int a[3][4] = {{1,2,3,4},{5,6,7,8}, {9,10,11,12}};
        int i,j,b[4][3];
        
        printf("转置前的矩阵：\n");
        for (i = 0; i < 3; i++) {
            for (j = 0; j < 4; j++) {
                printf("%5d", a[i][j]);
            }
            printf("\n");
        }
        
        turn(a, b);
        
        printf("转置后的矩阵：\n");
        for (i = 0; i < 4; i++) {
            for (j = 0; j < 3; j++) {
                printf("%5d",b[i][j]);
            }
            printf("\n");
        }
        printf("\n");
        
    }
}
/** 转置函数  */
void turn(int arra[][4], int arrb[][3])
{
    int r,c;
    for (r = 0; r < 3; r++) {
        for (c = 0; c < 4; c++) {
            arrb[c][r] = arra[r][c];
        }
    }
}




