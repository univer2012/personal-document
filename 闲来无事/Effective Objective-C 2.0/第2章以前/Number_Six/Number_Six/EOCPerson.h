//
//  EOCPerson.h
//  Number_Six
//
//  Created by huangaengoln on 15/12/17.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>
#if 0
@interface EOCPerson : NSObject {
@public
//    NSDate *_dateOfBirth;
    NSString *_firstName;
    NSString *_lastName;
@private
    NSString *_someInternalData;
}
@end
#endif


#if 0
@interface EOCPerson : NSObject

@property NSString *firstName;
@property NSString *lastName;

@end
#elif 0
//s上述代码与下面这种写法等效；
@interface EOCPerson : NSObject
-(NSString *)firstName;
-(void)setFirstName:(NSString *)firstName;
-(NSString *)lastName;
-(void)setLastName:(NSString *)lastName;

@end
#endif

#if 0
// NSManagerObject
@interface EOCPerson : NSManagerObject
@property NSString *firstName;
@property NSString *lastName;

@end
#endif


@interface EOCPerson : NSObject

@property(copy,readonly,nonatomic)NSString *firstName;
@property(copy,readonly,nonatomic)NSString *lastName;

-(id)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName;

@end