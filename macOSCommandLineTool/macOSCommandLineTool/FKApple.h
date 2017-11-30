//
//  FKApple.h
//  macOSCommandLineTool
//
//  Created by huangaengoln on 2017/11/25.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>
//
@interface FKApple : NSObject<NSCoding>
@property(nonatomic,copy)NSString *color;
@property(nonatomic,assign)double weight;
@property(nonatomic,assign)int size;
-(id)initWithColor:(NSString *)color weight:(double)weight size:(int)size;
@end
