//
//  ViewController.m
//  ObjectiveCDemo-16-04-07
//
//  Created by huangaengoln on 16/4/7.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *controllersArray;
@property(nonatomic,strong)NSMutableArray *titlesArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
#if 1
    //8、自定义后退按钮的文字和颜色(这代码写在push前的控制器里才有效)
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    //9、改变 “返回”图标和文字 的颜色(只有执行了 “返回”图标和文字才会变色，所以是放在执行push前)
    //所有 UIBarButtonSystemItem 的都会变设置的颜色
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];//[UIColor whiteColor];
#endif
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor redColor],
       NSFontAttributeName:[UIFont systemFontOfSize:19.0]}];
    self.title = [NSString stringWithFormat:@"第%lu页",(unsigned long)self.navigationController.viewControllers.count];
#if 0
    //自定义返回按钮
    UIImage *backButtonImage =[[UIImage imageNamed:@"system_setting"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    /*
     UIBarMetricsDefault,
     UIBarMetricsCompact,
     UIBarMetricsDefaultPrompt = 101, // Applicable only in bars with the prompt property, such as UINavigationBar and UISearchBar
     UIBarMetricsCompactPrompt,
     */
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //10、将返回按钮的文字position设置不在屏幕上显示
    [[UIBarButtonItem appearance]setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
#endif
    
    //    self.title=@"ObjectiveC-Demo";
    self.navigationController.interactivePopGestureRecognizer.delegate=(id)self;
    self.tableView=({
        UITableView *tableView=[UITableView new];
        [self.view addSubview:tableView];
        tableView.frame=CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        tableView.delegate=self;
        tableView.dataSource=self;
        tableView;
    });
    _controllersArray= [@[@"SGHDataPickerViewController",
                          @"SGHPickerViewViewController",
                          @"SGHNSArrayNSMutableArrayViewController",
                          @"SGHPopoverPresentationController",
                          @"SHGAboutNavigationViewController",
                          @"SGHRuntimeAttriMethodViewController",
                          @"SGHShowHTMLViewController",
                          @"SGHAttributedStringViewController",
                          @"SGHUniqueUUID_UDIDViewController",
                          @"SGHTableViewStyleGroupedViewController",
                          @"SGHPresentTransitionStyleViewController"] mutableCopy];
    self.titlesArray=[@[@"UIDatePickerDemo",
                        @"UIPickerView",
                        @"NSArray&NSMutableArray常用操作梳理",
                        @"UIPopoverPresentationController Demo",
                        @"有关NavigationController的设置",
                        @"runtime获取私有属性强制更改私有属性以及获取私有方法",
                        @"显示HTML格式文字",
                        @"NSAttributedString和NSMutableAttributedString",
                        @"获取唯一UUID:UDID的方案",
                        @"tableViewStyleGroupedDemo",
                        @"presentViewController转场样式"] mutableCopy];
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
