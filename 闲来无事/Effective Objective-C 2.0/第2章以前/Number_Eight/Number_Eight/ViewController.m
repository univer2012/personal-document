//
//  ViewController.m
//  Number_Eight
//
//  Created by huangaengoln on 15/12/19.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *foo=@"Badger 123";
    NSString *bar=[NSString stringWithFormat:@"Badger %i",123];
    BOOL equalA=(foo == bar);   //equalA=NO
    BOOL equalB=[foo isEqual:bar];//equalB=YES
    BOOL equalC=[foo isEqualToString:bar];//equalC=YES
    
    // 除了刚才提到的NSString之外，NSArray与NSDictionary类也具有特殊的等同性判定方法，
    // 前者名为“isEqualToArray:”，后者名为“isEqualToDictionary:”
    NSArray *arrayA=@[@"1",@"2"];
    NSArray *arrayB=[NSArray arrayWithObjects:@"1",@"2", nil];
    BOOL equalArray=[arrayA isEqualToArray:arrayB];
    
    NSDictionary *dictA=@{@"firstName":@"Bob"};
    NSDictionary *dictB=[NSDictionary dictionaryWithObjectsAndKeys:@"Bob",@"firstName", nil];
    BOOL equalDict=[dictA isEqualToDictionary:dictB];
    
    // === 四、容器中可变类的等同性
    NSMutableSet *set=[NSMutableSet new];
    NSMutableArray *array1=[@[@1 ,@2] mutableCopy];
    [set addObject:array1];
    NSLog(@"set = %@",set);
    // Output: set = {( ( 1,2) )}

    NSMutableArray *array2=[@[@1 ,@2] mutableCopy];
    [set addObject:array2];
    NSLog(@"set = %@",set);
    // Output: set = {( ( 1,2) )}
    
     NSMutableArray *array3=[@[@1] mutableCopy];
    [set addObject:array3];
    NSLog(@"set = %@",set);
    // Output: set = {( (1),( 1,2) )}
    
    [array3 addObject:@2];
    NSLog(@"set = %@",set);
    // Output: set = {( (1,2),( 1,2) )}
    
    NSSet *setB=[set copy];
    NSLog(@"setB = %@",setB);
    // Output: setB = {( ( 1,2) )}
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
