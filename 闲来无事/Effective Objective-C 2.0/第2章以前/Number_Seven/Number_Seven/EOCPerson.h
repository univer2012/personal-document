//
//  EOCPerson.h
//  Number_Seven
//
//  Created by huangaengoln on 15/12/19.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Brain.h"

@interface EOCPerson : NSObject
@property(nonatomic,copy)NSString *firstName;
@property(nonatomic,copy)NSString *lastName;
@property(nonatomic,strong)Brain *brain;

-(NSString *)fullName;
-(void)setFullName:(NSString *)fullName;

@end
