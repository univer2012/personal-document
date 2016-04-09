//
//  ViewController.m
//  CoreFoundation对象的内存管理
//
//  Created by huangaengoln on 15/11/7.
//  Copyright (c) 2015年 huangaengoln. All rights reserved.
//

#import "ViewController.h"
#import <CoreText/CoreText.h>

@interface ViewController ()<UIAlertViewDelegate>

@end

@implementation ViewController {
    UIWindow *_uiwindow;
    NSString *_errorMessage;
}
- (IBAction)createWindowButtonPressed:(id)sender {
    _uiwindow=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    _uiwindow.windowLevel=UIWindowLevelNormal;
    _uiwindow.backgroundColor=[UIColor redColor];
    _uiwindow.hidden=NO;
    
    UIGestureRecognizer *gesture=[[UITapGestureRecognizer alloc]init];
    [gesture addTarget:self action:@selector(hideWindow:)];
    [_uiwindow addGestureRecognizer:gesture];
}
-(void)hideWindow:(UIGestureRecognizer *)gesture {
    _uiwindow.hidden=YES;
    _uiwindow=nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
#if 0
    //创建一个 CFStringRef 对象
    CFStringRef str=CFStringCreateWithCString(kCFAllocatorDefault, "hello world", kCFStringEncodingUTF8);
    //创建一个 对象
    CGFontRef fontRef=CGFontCreateWithFontName((CFStringRef)@"ArialMT");
    
    //引用计数加1
    CFRetain(fontRef);
    //引用计数减1
    CFRelease(fontRef);
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor=[UIColor redColor];
    [self.view addSubview:view];
#endif
    if (![self isFontDownloaded:@"DFWaWaSC-W5"]) {
        
    }
    
}
- (IBAction)testButtonPresed:(id)sender {
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"" message:@"测试" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    UIWindow *window=[alertView window];
    NSLog(@"window_level = %f",window.windowLevel);
}

-(BOOL)isFontDownloaded:(NSString *)fontName {
    UIFont *aFont=[UIFont fontWithName:fontName size:12.0];
    if (aFont && ([aFont.fontName compare:fontName] == NSOrderedSame || [aFont.familyName compare:fontName] == NSOrderedSame)) {
        return YES;
    } else {
        //用字体的PostScript名字创建一个Dictionary
        NSMutableDictionary *attrs=[NSMutableDictionary dictionaryWithObjectsAndKeys:fontName,kCTFontNameAttribute, nil];
        //创建一个字体描述对象 CTFontDescriptorRef
        CTFontDescriptorRef desc=CTFontDescriptorCreateWithAttributes((__bridge CFDictionaryRef)attrs);
        //将字体描述对象放到一个 NSMutableArray 中
        NSMutableArray *descs=[NSMutableArray arrayWithCapacity:0];
        [descs addObject:(__bridge id)desc];
        CFRelease(desc);
        
        __block BOOL errorDuringDownload =NO;
        CTFontDescriptorMatchFontDescriptorsWithProgressHandler((__bridge CFArrayRef)descs, NULL, ^bool(CTFontDescriptorMatchingState state, CFDictionaryRef progressParameter) {
            double progressValue= [[(__bridge NSDictionary *)progressParameter objectForKey:(id) kCTFontDescriptorMatchingPercentage] doubleValue];
            
            if (state == kCTFontDescriptorMatchingDidBegin) {
                NSLog(@"字体已经匹配");
            } else if (state == kCTFontDescriptorMatchingDidFinish) {
                if (!errorDuringDownload) {
                    NSLog(@"字体%@ 下载完成",fontName);
                }
            } else if (state == kCTFontDescriptorMatchingWillBeginDownloading) {
                NSLog(@"字体开始下载");
            } else if (state == kCTFontDescriptorMatchingDidFinishDownloading) {
                NSLog(@"字体下载完成");
                dispatch_async(dispatch_get_main_queue(), ^{
                    //可以在这里修改UI控件的字体
                });
            } else if (state == kCTFontDescriptorMatchingDidFailWithError) {
                NSError *error=[(__bridge NSDictionary *)progressParameter objectForKey:(id)kCTFontDescriptorMatchingError];
                if (error != nil) {
                    _errorMessage=[error description];
                } else {
                    _errorMessage=@"ERROR MESSAGE IS NOT AVAILABLE!";
                }
                //设置标志
                errorDuringDownload=YES;
                NSLog(@"下载错误: %@",_errorMessage);
            }
            return (BOOL)YES;
        });
        
        return NO;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
