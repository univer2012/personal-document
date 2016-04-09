//
//  EOCPerson.h
//  Number_Two
//
//  Created by huangaengoln on 15/12/16.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "EOCEmployer.h"
@class EOCEmployer;

@interface EOCPerson : NSObject

@property(nonatomic,copy)NSString *firstName;
@property(nonatomic,copy)NSString *lastName;
@property(nonatomic,strong)EOCEmployer *employer;

@end
