//
//  ViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 16/7/28.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGH1128BookmarksViewController.h"

#import "SGH160728ViewController.h"
#import "SGH161223ComponentsDemoViewController.h"
#import "SGH170208ViewController.h"
#import "SGH190129YYKitViewController.h"
#import "SHReactiveCocoaViewController.h"
//#import "UINavigationController+FDFullscreenPopGesture.h"

@interface SGH1128BookmarksViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *controllersArray;
@property(nonatomic,strong)NSMutableArray *titlesArray;

@end

@implementation SGH1128BookmarksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
        self.title=@"杂乱Demo";
//    self.fd_prefersNavigationBarHidden
    
    self.tableView=({
        UITableView *tableView=[UITableView new];
        [self.view addSubview:tableView];
        tableView.frame=CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        tableView.delegate=self;
        tableView.dataSource=self;
        tableView;
    });
    _controllersArray = [@[SGH160728ViewController.new,
                           SGH161223ComponentsDemoViewController.new,
                           SGH170208ViewController.new,
                           SGH190129YYKitViewController.new,
                           SHReactiveCocoaViewController.new,
                           ] mutableCopy];
    
    
    self.titlesArray=[@[@"16-07-28",
                        @"3、第三方组件",
                        @"4、2017-02-08",
                        @"5、YYKit",
                        @"6、ReactiveCocoa",
                        ] mutableCopy];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //显示bar
    //[self.navigationController setNavigationBarHidden:NO animated:animated];
    
    //UINavigationBarDelegate
    //self.navigationController.navigationBar.delegate
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
#if 1
    UIViewController *viewController = _controllersArray[indexPath.row];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
#elif 0
    Class cls=NSClassFromString(_controllersArray[indexPath.row]);
    if (cls) {
        
        [self.navigationController pushViewController:[cls new] animated:YES];
    }
#endif
}

#pragma mark - 重写系统方法设置该控制器的 statusBar
-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
-(BOOL)prefersStatusBarHidden {
    return YES;
}
-(UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationFade;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
