//
//  ViewController.m
//  LLDB调试技术
//
//  Created by huangaengoln on 15/11/2.
//  Copyright (c) 2015年 huangaengoln. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *result=[self parseJSON:@"[1,2,3]"];
    result=[self parseJSON:@"error"];
    [self add:1 b:2];
    [[[UIApplication sharedApplication]keyWindow]debugDescription];
    
    if (result.count ==0) {
        NSLog(@"No Data");
    } else {
        NSLog(@"%@",result);
    }
}
- (IBAction)buttonClicked:(id)sender {
    
}

-(int)add:(int)a b:(int)b {
    return a+b;
}

-(NSArray *)parseJSON:(NSString *)json {
    return [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES] options:NSJSONReadingAllowFragments error:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
