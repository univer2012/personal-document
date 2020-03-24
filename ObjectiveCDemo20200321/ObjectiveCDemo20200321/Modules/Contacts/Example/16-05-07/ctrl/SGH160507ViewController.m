//
//  SGH160507ViewController.m
//  ObjectiveCDemo-16-04-07
//
//  Created by huangaengoln on 16/5/7.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGH160507ViewController.h"

@interface SGH160507ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *controllersArray;
@property(nonatomic,strong)NSMutableArray *titlesArray;

@end

@implementation SGH160507ViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView=({
        UITableView *tableView=[UITableView new];
        [self.view addSubview:tableView];
        tableView.frame=CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        tableView.delegate=self;
        tableView.dataSource=self;
        tableView;
    });
    _controllersArray= [@[
        @"SGHDataPickerViewController",
        @"SGH160531ViewController",
        @"SGHPickerViewViewController",
        @"SGHNSArrayNSMutableArrayViewController",
        @"SGHPopoverPresentationController",
        @"SHGAboutNavigationViewController",
        @"SGHRuntimeAttriMethodViewController",
        @"SGHShowHTMLViewController",
        @"SGHAttributedStringViewController",
        @"SGHUniqueUUID_UDIDViewController",
        @"SGHTableViewStyleGroupedViewController",
        @"SGHPresentTransitionStyleViewController",
        @"SGHStringShowViewController",
        @"SGHDateCalendarViewController",
        @"SGHNSURLSessionViewController",
        @"SGHNetworkChangeViewController",
        @"SGHUIFontViewController",
        @"SGHSesstionDownloadViewController",
        @"SGHWebViewConstrainsViewController",
        @"SGHOCJSInteractiveViewController",
        @"SGHMethodSwizzlingViewController",
        @"SGHSKStoreProductViewController",
        @"SGHPlistDictionaryViewController",
        @"SGHUDIDKeychainViewController",
        @"SGHDeallocBlockViewController",
    ] mutableCopy];
    
    self.titlesArray=[@[
        @"UIDatePickerDemo",
        @"2理解 Scroll Views",
        @"UIPickerView",
        @"NSArray&NSMutableArray常用操作梳理",
        @"UIPopoverPresentationController Demo",
        @"有关NavigationController的设置",
        @"runtime获取私有属性强制更改私有属性以及获取私有方法",
        @"显示HTML格式文字",
        @"NSAttributedString和NSMutableAttributedString",
        @"获取唯一UUID:UDID的方案",
        @"tableViewStyleGroupedDemo",
        @"presentViewController转场样式",
        @"字符串的显示",
        @"有关NSDate和NSCalendar的用法",
        @"iOS网络基础——NSURLSession使用详解举例",
        @"用苹果官网提供的Reachability监听网路变化",
        @"所有苹果字体显示的样式",
        @"断点续传下载:普通下载:后台下载:取消下载",
        @"webView的约束显示",
        @"iOS JavaScriptCore实现OC与JS的交互",
        @"iOS runtime实战应用：Method Swizzling",
        @"IOS6.0 应用内直接下载程序 不需跳转AppStore",
        @"获取iOSplist文件的所有信息",
        @"UDID替代方案--KeyChain",
        @"监听NSObject是否dealloc成功",
        
    ] mutableCopy];
    
    
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _controllersArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier=@"CellIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.textLabel.text=_titlesArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class cls=NSClassFromString(_controllersArray[indexPath.row]);
    if (cls) {
        [self.navigationController pushViewController:[cls new] animated:YES];
    }
}


@end








