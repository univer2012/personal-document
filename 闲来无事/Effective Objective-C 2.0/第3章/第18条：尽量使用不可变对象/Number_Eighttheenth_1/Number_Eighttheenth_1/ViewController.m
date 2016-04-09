//
//  ViewController.m
//  Number_Eighttheenth_1
//
//  Created by huangaengoln on 15/12/25.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import "ViewController.h"
#import "EOCPointOfInerest.h"

#import "EOCPerson.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //现在，只能于EOCPointOfInerest实现代码内部设置这些属性值了。其实更准确地说，在对象外部，仍然能通过“键值编码”(Key-Value Coding,KVC)技术设置这些属性值，比如说，可以像下面这样，使用"setValue:forKey:"方法来修改：
    EOCPointOfInerest *pointOfInterest=[EOCPointOfInerest new];
    [pointOfInterest setValue:@"abc" forKey:@"identifier"];
    //这样做可以改动identifier属性，因为KVC会在类里查找“setIdentifier:”方法，并借此修改此属性。即便没有于公共接口中公布此方法，它也依然包含在类里。不过，这样做等于违规绕过了本类所提供的API，要是开发者使用这种“杂技代码(hack)”的话，那么得自己来应对可能出现的问题。
    
    
    
    //不要在返回的对象上查询类型以确定其是否可变。比如：
    EOCPerson *person=[EOCPerson new];
    NSSet *friends=person.friends;
    if ([friends isKindOfClass:[NSMutableSet class]]) {
        NSMutableSet *mutableFriends=(NSMutableSet *)friends;
        //mutate ther set
    }
    //应该竭力避免这种做法。
    //在你与EOCPerson类之间的约定(contract)里，并没有提到实现friends所用的那个NSSet一定是可变的，因此不应像这样使用类型信息查询功能来编码。
    //这依然说明： 开发者或许不宜从底层直接修改对象中的数据。 所以，不要假设这个NSSet就一定能直接修改。
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
