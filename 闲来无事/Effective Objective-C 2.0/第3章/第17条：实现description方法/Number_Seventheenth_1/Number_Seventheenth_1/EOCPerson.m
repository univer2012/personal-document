//
//  EOCPerson.m
//  Number_Seventheenth_1
//
//  Created by huangaengoln on 15/12/25.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import "EOCPerson.h"

@implementation EOCPerson

-(id)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName {
    if (self=[super init]) {
        _firstName=[firstName copy];
        _lastName=[lastName copy];
    }
    return self;
}

#if 0
-(NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, \"%@ %@\">",[self class],self,_firstName,_lastName];
}
#elif 1
//不想把类名与指针这种额外内容放在普通的描述信息里，但是却希望调试的时候能够很方便地看到它们，就可以使用这种输出方式来实现。Foundation框架的NSArray类就是这么做的。
-(NSString *)description {
    return [NSString stringWithFormat:@"%@ %@",_firstName,_lastName];
}
-(NSString *)debugDescription {
    return [NSString stringWithFormat:@"<%@: %p, \"%@ %@\">",[self class],self,_firstName,_lastName];
}

#endif

@end
