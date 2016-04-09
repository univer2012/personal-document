//
//  EOCPerson.h
//  Number_TwentySecond_1
//
//  Created by huangaengoln on 15/12/25.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

//假如EOCPerson中含有一个数组，与其他EOCPerson对象建立或解除朋友关系的那些地方都需要操作这个数组。那么在这种情况下，你得把这个包含朋友对象的数组也一并拷贝过来。

#import <Foundation/Foundation.h>

@interface EOCPerson : NSObject<NSCopying>
@property(nonatomic,copy,readonly)NSString *firstName;
@property(nonatomic,copy,readonly)NSString *lastName;

-(id)initWithFirstName:(NSString *)firstName andLastName:(NSString *)lastName;
-(void)addFriend:(EOCPerson *)person;
-(void)removeFriend:(EOCPerson *)person;

@end
