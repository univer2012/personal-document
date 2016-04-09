//
//  EOCPerson.m
//  Number_Six
//
//  Created by huangaengoln on 15/12/17.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import "EOCPerson.h"
#if 1
@implementation EOCPerson
#if 0
@synthesize firstName=_myFirstName;
@synthesize lastName=_myLastName;

#endif

-(id)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName {
    if (self=[super init]) {
        _firstName=[firstName copy];
        _lastName=[lastName copy];
    }
    return self;
}


@end
#endif

#if 0
//NSManagerObject
@implementation EOCPerson

@dynamic firstName,lastName;

@end
#endif


