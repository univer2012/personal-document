//
//  EOCObject.m
//  Number_Twentith_1
//
//  Created by huangaengoln on 15/12/25.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import "EOCObject.h"

@implementation EOCObject
-(void)publicMethod {
    /*...*/
}
-(void)p_privateMethod {
    /* ... */
}

//苹果公司喜欢用一个下划线左私有方法的前缀。你或许也想照着苹果公司的办法只拿一个下划线作前缀，这样做可能会无意间覆写了父类的同名方法。
//鉴于此，苹果公司在文档中说，开发者不应该单用一个下划线做前缀。

@end
