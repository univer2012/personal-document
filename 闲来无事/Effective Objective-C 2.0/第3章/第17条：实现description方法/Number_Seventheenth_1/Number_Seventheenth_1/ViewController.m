//
//  ViewController.m
//  Number_Seventheenth_1
//
//  Created by huangaengoln on 15/12/25.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import "ViewController.h"
#import "EOCPerson.h"
#import "EOCLocation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *object=@[@"A string",@(123)];
    NSLog(@"object = %@",object);
    /*
     Output:
     object = (
     "A string",
     123
     )
     */
    
    
    EOCPerson *person=[[EOCPerson alloc]initWithFirstName:@"Bob" lastName:@"Smith"];
    NSLog(@"person = %@",person);
    /*
     Output:
      person = <EOCPerson: 0x7f9681c36270, "Bob Smith">
     */
    EOCLocation *location=[[EOCLocation alloc]initWithTitle:@"London" latitude:51.506 longitude:0];
    NSLog(@"location = %@",location);
    /*
     Output:
     location = <EOCLocation: 0x7fdc00c9a7b0, {
     latitude = "51.506";
     longitude = 0;
     title = London;
     }>
     */
    
    EOCPerson *person1=[[EOCPerson alloc]initWithFirstName:@"Bob" lastName:@"Smith"];
    NSLog(@"person1 = %@",person1);
    //Breakpoint here
    //===>>> :<EOCPerson: 0x7fea20d25120, "Bob Smith">
    
    
    NSArray *array=@[@"Effective-C 2.0",@(123),@(YES)];
    NSLog(@"array = %@",array);
    //Breakpoint here
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
