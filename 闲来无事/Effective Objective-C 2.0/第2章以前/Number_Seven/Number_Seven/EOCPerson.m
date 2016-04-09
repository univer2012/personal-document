//
//  EOCPerson.m
//  Number_Seven
//
//  Created by huangaengoln on 15/12/19.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import "EOCPerson.h"


@implementation EOCPerson
// ==== 一、
// 笔者强烈建议大家在读取实例变量的时候采用直接访问的形式，而在设置实例变量的时候通过属性来做。

// 在下乳实例变量时通过其“设置方法”来做，而在读取实例变量时，则直接访问之。
// 总结：set方法 用 点语法，get方法 用 下横杠
// 例如以下的写法：
-(NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@",_firstName,_lastName];
}
-(void)setFullName:(NSString *)fullName {
    NSArray *components=[fullName componentsSeparatedByString:@" "];
    self.firstName=[components objectAtIndex:0];
    self.lastName=[components objectAtIndex:1];
}
// ==== 二、
// 初始化方法中应该总是直接访问实例变量
-(void)setLastName:(NSString *)lastName {
    if (![lastName isEqualToString:@"Smith"]) {
        [NSException raise:NSInvalidArgumentException format:@"Last name must be Smith"];
    }
    self.lastName=lastName;
}
// ==== 三、
//惰性初始化 必须通过“获取方法”来访问属性，否则，实例变量就永远不会初始化。
//由于此属性不常用，而且春节改属性的成本较高，所以，我们可能会在“获取方法”中对其执行惰性初始化。
-(Brain *)brain {
    if (!_brain) {
        _brain=[Brain new];
    }
    return _brain;
}

@end
