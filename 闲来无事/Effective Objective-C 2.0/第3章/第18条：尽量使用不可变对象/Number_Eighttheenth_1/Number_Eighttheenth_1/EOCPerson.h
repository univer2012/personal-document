//
//  EOCPerson.h
//  Number_Eighttheenth_1
//
//  Created by huangaengoln on 15/12/25.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>
//例如，我们用某个类来表示个人信息，该类里还存放了一些引用，指向此人的诸位朋友。你可能想把这个人的全部朋友都放在一个“列表”里，并将其做成属性。假如开发者可以添加或删除此人的朋友，那么这个属性就需要用可变的set来实现。
//在这种情况下，通常应该提供一个readonly属性供外界使用，该属性将返回不可变的set，而此set则是内部那个可变set的一份拷贝。比方说，下面这段代码就能够实现出这样一个类：
@interface EOCPerson : NSObject

@property(nonatomic,copy,readonly)NSString *firstName;
@property(nonatomic,copy,readonly)NSString *lastName;
@property(nonatomic,strong,readonly)NSSet *friends;

-(id)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName;
-(void)addFriend:(EOCPerson *)person;
-(void)removeFriend:(EOCPerson *)person;

@end
