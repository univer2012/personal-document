//
//  EOCPerson.m
//  Number_TwentySecond_1
//
//  Created by huangaengoln on 15/12/25.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import "EOCPerson.h"

@implementation EOCPerson {
    NSMutableSet *_friends;
}

//通常情况下，应该向本例这样，采用全能初始化方法来初始化待拷贝的对象。
-(id)copyWithZone:(NSZone *)zone {
    EOCPerson *copy=[[[self class] allocWithZone:zone] initWithFirstName:_firstName andLastName:_lastName];
    copy->_friends=[_friends mutableCopy];
    //这里使用了 -> 语法，因为friends并非属性，只是个在内部的实例变量。
    
    return copy;
}

-(id)initWithFirstName:(NSString *)firstName andLastName:(NSString *)lastName {
    if (self=[super init]) {
        _firstName=[firstName copy];
        _lastName=[lastName copy];
        _friends=[NSMutableSet new];
    }
    return self;
}

-(void)addFriend:(EOCPerson *)person {
    [_friends addObject:person];
}

-(void)removeFriend:(EOCPerson *)person {
    [_friends removeObject:person];
}

//在EOCPerson那个例子中，存放朋友对象的set是用“copyWithZone:”方法来拷贝的，根据刚才讲的内容可知，这种浅拷贝方式不会逐个复制set中的元素。若需要深拷贝的话，则可像下面这样，编写一个专供深拷贝所用的方法：
-(id)deepCopy {
    EOCPerson *copy=[[[self class] alloc]initWithFirstName:_firstName andLastName:_lastName];
    copy->_friends=[[NSMutableSet alloc]initWithSet:_friends copyItems:YES];
    return copy;
}
//因为没有专门定义深拷贝的协议，所以其具体执行方式由每个类确定，你只需决定给自己所写的类是否要提供深拷贝方法即可。


@end
