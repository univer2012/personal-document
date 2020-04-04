//
//  SGH0404SequenceMapViewController.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/4/4.
//  Copyright © 2020 远平. All rights reserved.
//
/*
 * 来自：[iOS开发之ReactiveCocoa下的MVVM](https://www.cnblogs.com/ludashi/p/4925042.html)
 */
#import "SGH0404SequenceMapViewController.h"

#import "SGH04RACLoginViewController.h"

@interface SGH0404SequenceMapViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *selectors;
@property(nonatomic,strong)NSArray *titlesArray;

@end

@implementation SGH0404SequenceMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.tableView=({
        UITableView *tableView=[UITableView new];
        [self.view addSubview:tableView];
        tableView.frame=CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        tableView.delegate=self;
        tableView.dataSource=self;
        tableView;
    });

    
    self.titlesArray = @[
        @"1.使用RACSequence中的signal的map方法，让每个元素的首字母大写",
        @"2.把上面方法中的一坨代码可以写成下方的一串",
        @"3.使用RACSignal的switchToLatest，生成switchSignal，对信号进行切换",
        @"4.使用combineLatest:reduce:把多个信号组合为一个信号",
        @"5.用merge把多个信号，放入数组中通过merge函数来合并数组中的所有信号为一个",
        @"6.登录demo",
    ];
    self.selectors = @[
        @"uppercaseString",
        @"uppercaseString2",
        @"signalSwitch",
        @"combiningLatest",
        @"merge",
        @"loginDemo",
    ];
}

//MARK: 6.登录demo
- (void)loginDemo {
    SGH04RACLoginViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"SGH04RACLoginViewController"];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

//MARK: 5.用merge把多个信号，放入数组中通过merge函数来合并数组中的所有信号为一个
/* Item: 5.信号的合并（merge）
 (1) 创建三个自定义信号, 用于merge
 (2) 合并上面创建的3个信号
 (3) 往信号里灌入数据
 */
//合并信号
- (void)merge {
    RACSubject *letters = [RACSubject subject];
    RACSubject *numbers = [RACSubject subject];
    RACSubject *chinese = [RACSubject subject];
    
    [[RACSignal merge:@[letters, numbers, chinese]]
     subscribeNext:^(id  _Nullable x) {
        NSLog(@"merge: %@",x);
    }];
    
    [letters sendNext:@"AAA"];
    [numbers sendNext:@"66"];
    [chinese sendNext:@"你好！"];
}

//MARK: 4.使用combineLatest:reduce:把多个信号组合为一个信号
/* Item: 4.信号的合并(combineLatest)
 Desc: 信号的合并说白了就是把两个水管中的水合成一个水管中的水。**但这个合并有个限制，当两个水管中都有水的时候才合并。如果一个水管中有水，另一个水管中没有水，那么有水的水管会等到无水的水管中来水了，在与这个水管中的水按规则进行合并。**下面这个实例就是把两个信号进行合并。
 
 (1) 首先创建两个自定义的信号letters和numbers
 (2) 吧两个信号通过combineLatest函数进行合并，combineLatest说明要合并信号中最后发送的值
 (3) reduce块中是合并规则：把numbers中的值拼接到letters信号中的值后边。
 (4) 经过上面的步骤就是创建所需的相关信号，也就是相当于架好运输的管道。接着我们就可以通过sendNext方法来往信号中发送值了，也就是往管道中进行灌水。
 */
//组合信号
- (void)combiningLatest {
    RACSubject *letters = [RACSubject subject];
    RACSubject *numbers = [RACSubject subject];
    
    [[RACSignal combineLatest:@[letters, numbers] reduce:^(NSString *letter, NSString *number){
        return [letter stringByAppendingString:number];
    }]
     subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    //B1 C1 D2
    [letters sendNext:@"A"];
    [letters sendNext:@"B"];
    [numbers sendNext:@"1"];
    [letters sendNext:@"C"];
    [numbers sendNext:@"2"];
    
}

//MARK:3.使用RACSignal的switchToLatest，生成switchSignal，对信号进行切换
/*Item: 3.信号开关Switch
 (1) 首先创建3个自定义信号（3个水管），前两个水管是用来接通不同的水源的(google, baidu), 而最后一个信号是用来对接不同水源水管的水管（signalOfSignal）。signalOfSignal接baidu水管上，他就流baidu水源的水，接google水管上就流google水源的水。
 (2) 把signalOfSignal信号通过switchToLatest方法加工成开关信号。
 (3) 紧接着是对通过开关数据进行处理。
 (4) 开关对接baidu信号，然后baidu和google信号同时往水管里灌入数据，那么起作用的是baidu信号。
 (5) 开关对接google信号，google和baidu信号发送数据，则google信号输出到signalOfSignal中
 */
//信号开关Switch
- (void)signalSwitch {
    //创建3个自定义信号
    RACSubject *google = [RACSubject subject];
    RACSubject *baidu = [RACSubject subject];
    RACSubject *signalOfSignal = [RACSubject subject];
    
    //获取开关信号
    RACSignal *switchSignal = [signalOfSignal switchToLatest];
    
    //对通过开关的信号进行操作
    [[switchSignal  map:^id(NSString * value) {
        return [@"https//www." stringByAppendingFormat:@"%@", value];
    }] subscribeNext:^(NSString * x) {
        NSLog(@"%@", x);
    }];
    
    
    //通过开关打开baidu
    [signalOfSignal sendNext:baidu];
    [baidu sendNext:@"baidu.com"];
    [google sendNext:@"google.com"];
    
    //通过开关打开google
    [signalOfSignal sendNext:google];
    [baidu sendNext:@"baidu.com/"];
    [google sendNext:@"google.com/"];
}

//MARK:2.把上面方法中的一坨代码可以写成下方的一串
- (void)uppercaseString2 {
    [[[@[@"you", @"are", @"beautiful"] rac_sequence].signal
      map:^id _Nullable(NSString * _Nullable value) {
        return [value capitalizedString];
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"capitalizedSignal --- %@", x);
    }];
}

//MARK:1.使用RACSequence中的signal的map方法，让每个元素的首字母大写

/* Item: 2.Sequence和Map
 （1）把NSArray通过rac_sequence方法生成RAC中的Sequence
 （2）获取该Sequence对象的信号
 （3）调用Signal的Map方法，使每个元素的首字母大写
 （4）通过subscribNext方法对其进行遍历输出
 */
//uppercaseString use map
- (void)uppercaseString {
    RACSequence *sequence = [@[@"you", @"are", @"beautiful"] rac_sequence];
    
    RACSignal *signal = sequence.signal;
    
    RACSignal *capitalizedSignal = [signal map:^id _Nullable(NSString *value) {
        return [value capitalizedString];
    }];
    
    [signal subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"signal --- %@",x);
    }];
    
    [capitalizedSignal subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"capitalizedSignal --- %@",x);
    }];
}



//MARK: tableViewDelegate && tableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titlesArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.textLabel.text = _titlesArray[indexPath.row];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SEL sel = NSSelectorFromString(self.selectors[indexPath.row]);
    if (sel) {
        [self performSelector:sel];
    }
}

@end
