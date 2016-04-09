//
//  EOCPerson.m
//  Number_Eight
//
//  Created by huangaengoln on 15/12/19.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import "EOCPerson.h"

@implementation EOCPerson
//NSObject类对这两个方法的默认实现是：当且仅当其“指针值”完全相等时，这两个对象才相等。

//如果“isEqual:”方法判定两个对象相等，那么其hash方法也必须返回同一个值。    但是两个对象的hash方法返回同一个值，那么“isEqual:”方法未必会认为两者相等。
#if 0
// 如果两个EOCPerson的所有字段均相等，那么这两个对象就相等。于是“isEqual:”方法可以写成：
-(BOOL)isEqual:(id)object {
    if (self == object) return YES;
    if ([self class] != [object class]) return NO;
    
    EOCPerson *otherPerson=(EOCPerson *)object;
    if (![_firstName isEqualToString:otherPerson.firstName]) {
        return NO;
    }
    if (![_lastName isEqualToString:otherPerson.lastName]) {
        return NO;
    }
    if (_age != otherPerson.age) {
        return NO;
    }
    return YES;
}
#endif

-(NSUInteger)hash {
    // -- 1
//    return 1337;
    
    // -- 2
//    NSString *stringToHash=[NSString stringWithFormat:@"%@:%@:%@",_firstName,_lastName,_age];
//    return [stringToHash hash];
    
    // -- 3
    NSUInteger firstNameHash=[_firstName hash];
    NSUInteger lastNameHash=[_lastName hash];
    NSUInteger ageHash=_age;
    return firstNameHash ^ lastNameHash ^ ageHash;
    
}
// === 二、特定类所具有的等同性判定方法
// 在编写判定方法时，也应一并写“isEqual:”方法。 ---> 如果受测的参数与接收消息的对象都属于同一个类，那么就调用自己编写的判定方法，否则就交由超类来判断：
-(BOOL)isEqualToPerson:(EOCPerson *)otherPerson {
    if (self == otherPerson) return YES;
    
    if (![_firstName isEqualToString:otherPerson.firstName]) {
        return NO;
    }
    if (![_lastName isEqualToString:otherPerson.lastName]) {
        return NO;
    }
    if (_age != otherPerson.age) {
        return NO;
    }
    return YES;
}
-(BOOL)isEqual:(id)object {
    if ([self class] == [object class]) {
        return [self isEqualToPerson:(EOCPerson *)object];
    } else {
        return [super isEqual:object];
    }
}

@end
