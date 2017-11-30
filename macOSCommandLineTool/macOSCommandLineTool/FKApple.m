//
//  FKApple.m
//  macOSCommandLineTool
//
//  Created by huangaengoln on 2017/11/25.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "FKApple.h"

@implementation FKApple
@synthesize color = _color;
@synthesize weight = _weight;
@synthesize size = _size;
-(id)initWithColor:(NSString *)color weight:(double)weight size:(int)size {
    if (self = [super init]) {
        self.color = color;
        self.weight = weight;
        self.size = size;
    }
    return self;
}
//重写父类的方法
-(NSString *)description {
    //返回一个字符串
    return [NSString stringWithFormat:@"<FKApple[_color=%@, _weight=%g, _size=%d]>",self.color, self.weight, self.size];
}
-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_color forKey:@"color"];
    [aCoder encodeDouble:_weight forKey:@"weight"];
    [aCoder encodeInt:_size forKey:@"size"];
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    //使用NSCoder依次恢复color、weight、size这3个key
    //所对应的value，并将恢复的value赋给当前对象的3个实例变量
    _color = [aDecoder decodeObjectForKey:@"color"];
    _weight = [aDecoder decodeDoubleForKey:@"weight"];
    _size = [aDecoder decodeIntForKey:@"size"];
    return self;
}
@end
