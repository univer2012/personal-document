//
//  ViewController.m
//  让你快速上手Runtime
//
//  Created by huangaengoln on 15/10/29.
//  Copyright (c) 2015年 huangaengoln. All rights reserved.
//

#import "ViewController.h"
#import <objc/message.h>
#import "Status.h"

@interface ViewController ()
@property(nonatomic)NSMutableArray *statuses;

@end

@interface Person : NSObject
void eat(id self ,SEL sel);
-(void)eat;
+(void)eat;
@end

@interface NSObject (Property)
@property(nonatomic)NSString *name;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    //解析Plist文件
    NSString *filePath=[[NSBundle mainBundle]pathForResource:@"status.plist" ofType:nil];
    NSDictionary *statusDict=[NSDictionary dictionaryWithContentsOfFile:filePath];
    
    //获取字典数组
    NSArray *dictArr=statusDict[@"statuses"];
    
    //自动生成模型的属性字符串
//    [NSObject resolveDict:dictArr[0][@"user"]];
    
    _statuses=[NSMutableArray array];
    //遍历字典数组
    for (NSDictionary *dict in dictArr) {
        Status *status=[Status modelWithDict:dict];
        [_statuses addObject:status];
    }
    //测试数据
    NSLog(@"%@ %@",_statuses,[_statuses[0] user]);
    
}

#if 0
- (void)viewDidLoad {
    [super viewDidLoad];
#if 0
    //创建person对象
    Person *p=[[Person alloc]init];
    //条用对象方法
    [p eat];
    
    //本质：让对象发送消息
    objc_msgSend(); //objc_msgSend(p,@selector(eat));
    
    //调用类方法的方式：两种
    //第一种通过类名调用
    [Person eat];
    //第二种通过类对象调用
    [[Person class]eat];
    
    //用类名调用类方法，底层会自动把雷鸣转换成类对象调用
    //本质：让类对象发送消息
    objc_msgSend(); //objc_msgSend([Person class], @selector(eat));
#elif 0
    // 需求：给imageNamed方法提供功能，每次加载图片就判断下图片是否加载成功。
    // 步骤一：先搞个分类，定义一个能加载图片并且能打印的方法+ (instancetype)imageWithName:(NSString *)name;
    // 步骤二：交换imageNamed和imageWithName的实现，就能调用imageWithName，间接调用imageWithName的实现。
    UIImage *image=[UIImage imageNamed:@"123"];
#elif 0
    
    Person *p=[[Person alloc]init];
    // 默认person，没有实现eat方法，可以通过performSelector调用，但是会报错。
    // 动态添加方法就不会报错
    [p performSelector:@selector(eat)];
#endif
    
    //给系统NSObject类动态添加属性name
    NSObject *objc=[[NSObject alloc]init];
    objc.name=@"小码哥";
    NSLog(@"%@",objc.name);
    
}
#endif
@end

#if 0
@implementation NSObject(Property)

-(NSString *)name {
    //根据关联的key，获取关联的值.
    return objc_getAssociatedObject(self, key);
}
-(void)setName:(NSString *)name {
    //第一个参数：给哪个对象添加关联
    //第二个参数：关联的key，通过这个key获取
    //第三个参数：关联的value
    //第四个参数：关联的策略
    objc_setAssociatedObject(self, key, name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
#endif

@implementation UIImage(Image)

//加载分类到内存的时候调用
+(void)load {
    //交换方法
    //获取imageWithName方法地址
    Method imageWithName=class_getClassMethod(self, @selector(imageWithName:));
    //获取imageName方法地址
    Method imageName=class_getClassMethod(self, @selector(imageNamed:));
    //交换方法地址，相当于交换实现方式
    method_exchangeImplementations(imageWithName, imageName);
}
//// 不能在分类中重写系统方法imageNamed，因为会把系统的功能给覆盖掉，而且分类中不能调用super.
//既能加载图片又能打印
+(instancetype)imageWithName:(NSString *)name {
    //这里调用imageWithName，相当于调用imageName
    UIImage*image=[self imageWithName:name];
    if (image == nil) {
        NSLog(@"加载空的图片");
    }
    return image;
}

@end



@implementation Person

//void(*)()
//默认方法都有两个饮食参数
void eat(id self ,SEL sel) {
    NSLog(@"%@ %@",self,NSStringFromSelector(sel));
}
// 当一个对象调用未实现的方法，会调用这个方法处理,并且会把对应的方法列表传过来.
// 刚好可以用来判断，未实现的方法是不是我们想要动态添加的方法
+(BOOL)resolveClassMethod:(SEL)sel {
    if (sel == @selector(eat)) {
        //动态添加eat方法
        //第一个参数：给哪个类添加方法
        //第二个参数：添加方法的方法编号
        //第三个参数：添加方法的函数实现(函数地址)
        //第四个参数：函数的类型，(返回值+参数类型)
        /*
         v      void
         @      对象->self
         :      表示SEL->_cmd
         */
        class_addMethod(self, @selector(eat), eat, "V@:");
    }
    return [super resolveClassMethod:sel];
}

@end
