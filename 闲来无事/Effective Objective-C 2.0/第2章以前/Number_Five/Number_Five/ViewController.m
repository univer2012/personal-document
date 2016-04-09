//
//  ViewController.m
//  Number_Five
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
    EOCConnectionState _currentState;
    switch (_currentState) {
        case EOCConnectionStateDisconnected:
            // Handle disconnected state
            break;
        case EOCConnectionStateConnecting:
            // Handle disconnected state
            break;
        case EOCConnectionStateConnected:
            // Handle disconnected state
            break;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
