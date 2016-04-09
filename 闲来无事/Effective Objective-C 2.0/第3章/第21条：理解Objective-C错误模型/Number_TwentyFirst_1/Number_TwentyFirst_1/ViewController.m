//
//  ViewController.m
//  Number_TwentyFirst_1
//
//  Created by huangaengoln on 15/12/25.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    id someResource=@1/* ... */;
    if (1/* ...*/) {
        @throw [NSException exceptionWithName:@"ExceptionName" reason:@"There was an error" userInfo:nil];
    }
//    [someResource doSomething];
//    [someResource release];
    
    
    typeof(self) object=self;
    NSError *error=nil;
    BOOL ret=[object doSomething:&error];
    if (error) {
        //There was an error
    }
    
    
}
-(BOOL)doSomething:(NSError **)error {
    //Do something that may cause an error
    
    if ( 1/*there was an error */ ) {
        
        if (error) {
            //Pass the 'error' through the out-parameter
            NSString *domain=nil;
            NSInteger code =1;
            NSDictionary *userInfo=@{};
            *error=[NSError errorWithDomain:domain code:code userInfo:userInfo];

        }
        return NO;  //< Indicate failure
    } else {
        return YES; //<Indicate success
    }
}

//与其他语言不同，Objective-C中没办法将某个类标识为“抽象类”。要达成类似效果，最好的办法是在那些子类必须覆写的超类方法里抛出异常。这样的话，只要有人直接创建抽象基类的实例并使用它，即会抛出异常：
-(void)mustOverrideMethod {
    NSString *reason=[NSString stringWithFormat:@"%@ must be overridden",NSStringFromSelector(_cmd)];
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:reason userInfo:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
