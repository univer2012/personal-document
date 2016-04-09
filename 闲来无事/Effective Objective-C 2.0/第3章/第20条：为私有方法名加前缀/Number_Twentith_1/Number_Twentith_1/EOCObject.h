//
//  EOCObject.h
//  Number_Twentith_1
//
//  Created by huangaengoln on 15/12/25.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 1,因为类的公共API不便随意改动。如果改了，那么使用这个类的所有开发者都必须更新其代码才行。
 2,而对于内部方法来说，若要修改其名称或前面，则只需同时修改本类的相关代码即可，不会影响到面向外界的那些API。
 */

//具体使用何种前缀可根据个人喜好来定，其中最包含下划线与字母p。

//笔者喜欢用p作为前缀，p表示“private”(私有的)，而下划线则可以把这个字母和真正的方法名区隔开。
//下划线后面的部分按照常用的驼峰法来命名即可，其首字母要小写。

@interface EOCObject : NSObject
-(void)publicMethod;

@end
