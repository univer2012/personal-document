//
//  EOCPerson.h
//  Number_Seventheenth_1
//
//  Created by huangaengoln on 15/12/25.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EOCPerson : NSObject

@property(nonatomic,copy,readonly)NSString *firstName;
@property(nonatomic,copy,readonly)NSString *lastName;
-(id)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName;

@end
