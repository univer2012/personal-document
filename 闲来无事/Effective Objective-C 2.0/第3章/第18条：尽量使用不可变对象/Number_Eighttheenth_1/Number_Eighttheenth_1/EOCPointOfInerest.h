//
//  EOCPointOfInerest.h
//  Number_Eighttheenth_1
//
//  Created by huangaengoln on 15/12/25.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EOCPointOfInerest : NSObject

//尽量把对外公布出来的属性设为只读，而且只在确有必要时才将属性对外公布。

//读者也许会问，既然这些属性都没有设置方法(setter)，那为何还要指定内存管理语义呢？如果不指定，采用默认的语义也可以。
//虽说如此，我们还是应该在文档里指明实现所用的内存管理语义，以后想把它变为可读写的属性时，就会简单一些。
@property(nonatomic,copy,readonly)NSString *identifier;
@property(nonatomic,copy,readonly)NSString *title;
@property(nonatomic,assign,readonly)float latitude;
@property(nonatomic,assign,readonly)float longitude;


-(id)initWithIdentifier:(NSString *)identifier title:(NSString *)title latitude:(float)latitude longitude:(float)longitude;


@end
