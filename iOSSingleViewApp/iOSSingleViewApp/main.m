//
//  main.m
//  iOSSingleViewApp
//
//  Created by huangaengoln on 2017/11/19.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import <Foundation/Foundation.h>

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}


#if 0
//定义一个函数，该函数用于把NSArray集合转换为字符串
NSString *NSCollectionToString(id collection) {
    NSMutableString *result = [NSMutableString stringWithString:@"["];
    for (id obj in collection) {
        [result appendString:[obj description]];
        [result appendString:@", "];
    }
    NSUInteger len = [result length]; //获取字符串长度
    //去掉字符串最后的两个字符
    [result deleteCharactersInRange:NSMakeRange(len - 2, 2)];
    [result appendString:@"]"];
    return result;
}

NSString *getPathWithName(NSString *name) {
    // creates list of valid directories for saving a file
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    // get the first directory because we only care about one
    NSString *directory = [paths objectAtIndex:0];
    NSLog(@"directory: %@",directory);
    // concatenate the file name "contacts" to the end of the path
    NSString *filePath = [[NSString alloc] initWithString: [directory stringByAppendingPathComponent:name]];
    return filePath;
}

#import "NSDictionary+print.h"


#import "FKUser.h"
int main(int argc, char * argv[]) {
    @autoreleasepool {
        //直接使用多个value，key的形式创建NSDictionary对象
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSNumber numberWithInt:89],@"Objective-C",
                              [NSNumber numberWithInt:69],@"Ruby",
                              [NSNumber numberWithInt:75],@"Python",
                              [NSNumber numberWithInt:109],@"Perl",nil];
        //对dict对象进行归档
        [NSKeyedArchiver archiveRootObject:dict toFile:@"myDict.archive"];
    }
}

#endif


