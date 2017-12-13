//
//  SGH171130RetainCycleTestViewController.m
//  ObjectiveCDemo-16-04-07
//
//  Created by huangaengoln on 2017/11/30.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "SGH171130RetainCycleTestViewController.h"

#import "FBRetainCycleDetector.h"

#import "SGHObjectA.h"
#import "SGHObjectB.h"

@interface ClassA : NSObject
@property(nonatomic, copy)void(^myBlock)(void);
@end
@implementation ClassA

@end

@interface SGH171130RetainCycleTestViewController ()

@property (nonatomic,weak)NSTimer *AdTimer;
@property(nonatomic)ClassA *objA;
@end

@implementation SGH171130RetainCycleTestViewController
{
    void (^_handlerBlock)();
    NSInteger _launchAdTimeNumber;
//    NSTimer *_AdTimer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

#if 0
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(p_launshAdMainThread) userInfo:nil repeats:YES];
    self.AdTimer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    _launchAdTimeNumber = 6;

#endif

    ClassA *objA = [[ClassA alloc] init];
    __block typeof(self) blockSelf = self;
    objA.myBlock = ^{
        [blockSelf doSomething];
    };
    self.objA = objA;
    
    FBRetainCycleDetector *detector = [FBRetainCycleDetector new];
    [detector addCandidate:self];
    NSSet *retainCycles = [detector findRetainCycles];
    NSLog(@"%@",retainCycles);


}
-(void)doSomething {
}
-(void)p_launshAdMainThread {
    if (_launchAdTimeNumber <= 0) {
        [self.AdTimer invalidate];
        return;
    } else {
        NSLog(@"_launchAdTimeNumber: %ld", _launchAdTimeNumber);
    }
    _launchAdTimeNumber--;
}
-(void)dealloc {
//    [self.AdTimer invalidate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
