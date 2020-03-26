//
//  SHReactiveCocoaViewController.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/11/15.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "SHReactiveCocoaViewController.h"

#pragma mark - model
@interface SGHCellModel : NSObject
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *className;

@end

@implementation SGHCellModel

@end
#pragma mark - controller
@interface SHReactiveCocoaViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *sectionTitle;

@end

@implementation SHReactiveCocoaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"RAC Example";
    self.dataArray=@[].mutableCopy;
    self.sectionTitle=@[].mutableCopy;
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.tableView=({
        UITableView *tableView=[UITableView new];
        [self.view addSubview:tableView];
        tableView.frame=CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        tableView.delegate=self;
        tableView.dataSource=self;
        tableView;
    });
    
    
    
    //section 1
    NSArray *tempClassNameArray=@[@"LxDBAnythingViewController",
                                  @"SGHTargetActionViewController",
                                  @"SGHGesturerViewController",
                                  @"SGHNotificationViewController",
                                  @"SGHSchedulerViewController",
                                  @"SGHSwitchDelegateViewController",
                                  @"SGHKVOViewController"
                                  ];
    NSArray *tempTitleArray=@[@"1、LxDBAnything Example",
                              @"2、文本框响应事件",
                              @"3、手势",
                              @"4、通知(不需要removeObserver:)",
                              @"5、定时器",
                              @"6、替换代理(有局限，只能取代没有返回值的代理方法)",
                              @"7、KVO"];
    [self p_addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"基础"];
    
    //section 2
    tempClassNameArray=@[@"SGHSignalViewController",
                         @"SGHMapViewController",
                         @"SGHFilterViewController",
                         @"SGHDelayViewController",
                         @"SGHStartWithViewController",
                         @"SGHTimeoutViewController",
                         @"SGHTakeViewController",
                         @"SGHSkipViewController",
                         @"SGHTakeLastViewController",
                         @"SGHTakeUntilViewController",
                         @"SGHTakeWhileBlockViewController",
                         @"SGHSkipWhileBlockViewController",
                         @"SGHSkipUntilBlockViewController",
                         @"SGHThrottleViewController",
                         @"SGHDistinctUntilChangedViewController",
                         @"SGHIgnoreViewController",
                         @"SGHSwitchToLatestViewController",
                         @"SGHRepeatViewController"];
    tempTitleArray=@[@"1、信号订阅与接收",
                     @"2、map映射",
                     @"3、filter过滤",
                     @"4、delay延迟",
                     @"5、startWith",
                     @"6、timeout:超时",
                     @"7、take:",
                     @"8、skip:",
                     @"9、takeLast:",
                     @"10、takeUntil",
                     @"11、takeWhileBlock",
                     @"12、skipWhileBlock",
                     @"13、skipUntilBlock",
                     @"14、throttle(即时搜索优化)",
                     @"15、distinctUntilChanged(即时搜索优化改进1)",
                     @"16、ignore(即时搜索优化改进2)",
                     @"17、switchToLatest(即时搜索优化改进3)",
                     @"18、repeat重复"];
    [self p_addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"进阶(单个信号)"];
    
    //section 3
    tempClassNameArray=@[@"SGHMergeViewController",
                         @"SGHCombineLatestReduceViewController",
                         @"SGHConcatViewController",
                         @"SGHZipwithViewController",
                         @"SGHDefineRACViewController",
                         @"SGHStopwatchViewController",
                         @"SGHSumupViewController"];
    tempTitleArray=@[@"1、merge合并",
                     @"2、combineLatest:reduce:(还没写例子)",
                     @"3、concat(一个异步请求完成后，再启动另一个)",
                     @"4、zipWith:(多个异步请求都完成后，再做某件事)",
                     @"5、宏RAC(TARGET,...)",
                     @"6、用最少的代码写一个秒表",
                     @"7、总结/大量使用RAC的写法"];
    [self p_addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"多个信号"];
    
    //section 4
    tempClassNameArray=@[
        @"SHAnimationMasonryLoginVC",
        @"SHRAC1ViewController",
        @"SHRAC4ViewController",
        @"SHRAC9ViewController",
        @"SHRAC10ViewController",
        @"SHRAC12ViewController",
    ];
    tempTitleArray=@[
        @"1、Autolayout_masonry登录动画",
        @"2、介绍（一）——基本介绍",
        @"3、介绍四_流程分析",
        @"4、介绍九_RACSubject流程分析",
        @"5、介绍十_RACMulticastConnection",
        @"6、介绍十二_RACCommand",
    ];
    [self p_addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"RAC介绍系列"];
    
    
    [self.tableView reloadData];
}
-(void)p_addSectionDataWithClassNameArray:(NSArray *)classNameArray titleArray:(NSArray *)titleArray title:(NSString *)title {
    @autoreleasepool {
        NSMutableArray *firstArray=@[].mutableCopy;
        
        [classNameArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            SGHCellModel *cellModel = [SGHCellModel new];
            cellModel.className=obj;
            cellModel.title=titleArray[idx];
            [firstArray addObject:cellModel];
        }];
        
        [self p_addSectionTitle:title dataArray:firstArray];
        
        
    }
}

-(void)p_addSectionTitle:(NSString *)sectionTitle dataArray:(NSMutableArray *)dataArray {
    [self.dataArray addObject:dataArray];
    [self.sectionTitle addObject:sectionTitle];
}


#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sectionTitle[section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSMutableArray *)self.dataArray[section]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YY"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YY"];
    }
    SGHCellModel *cellMoel= self.dataArray[indexPath.section][indexPath.row];
    cell.textLabel.text = cellMoel.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SGHCellModel *cellMoel= self.dataArray[indexPath.section][indexPath.row];
    NSString *className = cellMoel.className;
    
    if ([className  isEqualToString: @"SHRAC1ViewController"]) {
        UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:className];
        vc.title = cellMoel.title;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        Class cls=NSClassFromString(className);
        if (cls) {
            UIViewController *vc = [cls new];
            vc.title = cellMoel.title;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
