//
//  ViewController.m
//  Number_Ten
//
//  Created by huangaengoln on 15/12/19.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

#import "ViewController.h"

#import <objc/runtime.h>

@interface ViewController ()<UIAlertViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
#if 0
-(void)askUserAQuestion {
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Question" message:@"What do you want to do?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Continue", nil];
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        //[self doCancel];
    } else {
        //[self doContinue];
    }
}
#endif
//如果想在同一个类里处理多个警告信息视图，那么代码就会变得更为复杂，我们必须在delegate方法中检查传入的alertView参数，并据此选用相应的逻辑。
//要是能在车间井盖视图的时候直接把处理每个按钮的逻辑都写好，那就简单多了。
static void *EOCMyAlertViewKey=@"EOCMyAlertViewKey";
-(void)askUserAQuestion {
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Question" message:@"What do you want to do?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Continue", nil];
    
    void (^block)(NSInteger)=^(NSInteger buttonIndex) {
        if (buttonIndex == 0) {
            //[self doCancel];
        } else {
            //[self doContinue];
        }
    };
    
    objc_setAssociatedObject(alert, EOCMyAlertViewKey, block, OBJC_ASSOCIATION_COPY);
    
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    void (^block)(NSInteger) =objc_getAssociatedObject(alertView, EOCMyAlertViewKey);
    block(buttonIndex);
}
//采用该方案需注意：块可能要补货某些变量，这也许会造成“保留环”。
//只有在其他做法不可行时才应选用关联对象，因为这种做法通常会引入难于查找的bug。



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
