//
//  ViewController.m
//  Number_Six
//
//  Created by huangaengoln on 15/12/17.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import "ViewController.h"
#import "EOCPerson.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    EOCPerson *aPerson=[EOCPerson new];
    aPerson.firstName=@"Bob";// Same as
    [aPerson setFirstName:@"Bob"];
    
    NSString *lastName=aPerson.lastName;//Same as
    NSString *lastName1=[aPerson lastName];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
