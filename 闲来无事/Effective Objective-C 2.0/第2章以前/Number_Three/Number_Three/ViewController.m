//
//  ViewController.m
//  Number_Three
//
//  Created by huangaengoln on 15/12/16.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // ==== 1
    NSString *someString=@"Effective Objective-C 2.0";
    
    //字面值
    NSNumber *someNumber=[NSNumber numberWithInt:1];
    NSNumber *someNumer1 = @1;
    
    NSNumber *intNumber=@1;
    NSNumber *floatNumber=@2.5f;
    NSNumber *doubleNumber=@3.14159;
    NSNumber *boolNumber=@YES;
    NSNumber *charNumber=@'a';
    
    int x=5;
    float y=6.32f;
    NSNumber *experssionNumber=@(x*y);
    
    //字面量数组
    NSArray *animals=[NSArray arrayWithObjects:@"cat",@"dog",@"mouse",@"badger", nil];
    NSArray *animals1=@[@"cat",@"dog",@"mouse",@"badger"];
    
    NSString *dog=[animals objectAtIndex:1];
    NSString *dog1=animals[1];
    
    id object1= @1/* ... */;
    id object2= nil/* ... */;
    id object3= @3/* ... */;
    NSArray *arrayA=[NSArray arrayWithObjects:object1,object2,object3, nil];
    NSArray *arrayB=@[object1,object2,object3];
    
    //字面量字典
    NSDictionary *personData=[NSDictionary dictionaryWithObjectsAndKeys:@"Matt",@"firstName",
                              @"Galloway",@"lastName",
                              [NSNumber numberWithInt:28],@"age",nil];
    NSDictionary *personData1=@{@"firstName":@"Matt",
                                @"lastName":@"Galloway",
                                @"age":[NSNumber numberWithInt:28]};
    
    NSString *lastName=[personData objectForKey:@"lastName"];
    NSString *lastName1=personData[@"lastName"];
    
    //可变数组与字典
    NSMutableArray *mutableArray=[animals mutableCopy];
    [mutableArray replaceObjectAtIndex:1 withObject:@"dog"];
    NSMutableDictionary *mutableDictionary= [personData mutableCopy];
    [mutableDictionary setObject:@"Galloway" forKey:@"lastName"];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
