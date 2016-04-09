//
//  EOCEmployer.h
//  Number_Two
//
//  Created by huangaengoln on 15/12/16.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EOCPerson;

@interface EOCEmployer : NSObject

-(void)addEmployee:(EOCPerson *)person;
-(void)removeEmployee:(EOCPerson *)person;

@end
