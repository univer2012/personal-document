//
//  EOCPerson.m
//  Number_Eighttheenth_1
//
//  Created by huangaengoln on 15/12/25.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import "EOCPerson.h"

@interface EOCPerson ()
@property(nonatomic,copy,readwrite)NSString *firstName;
@property(nonatomic,copy,readwrite)NSString *lastName;

@end

@implementation EOCPerson {
    NSMutableSet *_internalFriends;
}

-(NSSet *)friends {
    return [_internalFriends copy];
}
-(void)addFriend:(EOCPerson *)person {
    [_internalFriends addObject:person];
}

-(void)removeFriend:(EOCPerson *)person {
    [_internalFriends removeObject:person];
}

-(id)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName {
    if (self=[super init]) {
        _firstName=firstName;
        _lastName=lastName;
        _internalFriends=[NSMutableSet new];
    }
    return self;
}

@end
