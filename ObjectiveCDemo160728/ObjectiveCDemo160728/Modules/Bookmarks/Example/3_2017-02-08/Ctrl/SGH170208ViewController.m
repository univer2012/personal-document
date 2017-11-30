//
//  SGH170208ViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/2/8.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "SGH170208ViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface SGH170208ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *controllersArray;
@property(nonatomic,strong)NSMutableArray *titlesArray;

@end

@implementation SGH170208ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView=({
        UITableView *tableView=[UITableView new];
        [self.view addSubview:tableView];
        tableView.frame=CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        tableView.delegate=self;
        tableView.dataSource=self;
        tableView;
    });
    _controllersArray= [@[@"SGH0208UncaughtExceptionViewController",
                          @"SGHReusableHeaderFooterTableViewController",
                          @"SGH0424DreamLBSViewController",
                          @"SGH0425RunloopImageViewController",
                          @"SGH0429CryptographyViewController",
                          @"SGH0506OCRuntime1ViewController",
                          @"SGH0509AboutRunLoopViewController",
                          @"SGH0510Runtime2ViewController",
                          @"SGH0511Runtime3ViewController",
                          @"SGH0512Runtime4ViewController",
                          @"SGH0512Runtime5ViewController",
                          @"SGH0515Runtime6ViewController",
                          @"SGH0515AttibuteStringInitViewController",
                          @"SGH0515ClassViewController",
                          @"SGH170518ResuableCellViewController",
                          @"SGHXMPPFrameworkViewController",
                          @"SGH0522CrashAnalisisViewController",
                          @"SGH0524PresentAViewController",
                          @"SGH0601SystemVersionViewController",
                          @"SGH0607FetchStringExpressionViewController",
                          @"SGH170815IdentCodeViewController"
                          ] mutableCopy];
    
    self.titlesArray=[@[@"1、iOS自动捕获程序崩溃日志再发送邮件提示开发者",
                        @"2、dequeueReusableHeaderFooterViewWithIdentifier",
                        @"3、架构师之面向协议编程(OC语言)介绍",
                        @"4、利用runloop来解决图像卡顿",
                        @"5、浅谈密码学",
                        @"6、Objective-C Runtime 运行时之一：类与对象",
                        @"7、使用runloop对象",
                        @"8、Objective-C Runtime 运行时之二：成员变量与属性",
                        @"9、Objective-C Runtime 运行时之三：方法与消息",
                        @"10、Objective-C Runtime 运行时之四：Method Swizzling",
                        @"11、Objective-C Runtime 运行时之五：协议与分类",
                        @"12、Objective-C Runtime 运行时之六：拾遗",
                        @"13、NSAttributedString initWithData 阻塞App问题",
                        @"14、Runtime方法的使用—Class篇",
                        @"15、iOS亲测UITableView重用机制，用事实说话",
                        @"16、iOS 的 XMPPFramework 简介",
                        @"17、奔溃统计和分析",
                        @"18、弹出的控制器，半透明显示上一个控制器的页面",
                        @"19、系统判断方法列举",
                        @"20、通过正则表达式获取2个特定字符串中间的字符串",
                        @"21、生成动态验证码及验证"
                        ] mutableCopy];
    
    /*用组件隐藏navigationBar，并可以滑动返回
     返回后的控制器的viewWillAppear:方法中，不用设置
     [self.navigationController setNavigationBarHidden:NO animated:YES];
     */
    self.fd_prefersNavigationBarHidden = YES;
    
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
    Class cls = NSClassFromString(_controllersArray[indexPath.row]);
    if (cls) {
        [self.navigationController pushViewController:[cls new] animated:YES];
    }
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
