//
//  SHReactiveCocoaViewController.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/11/15.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "SHReactiveCocoaViewController.h"

#import "SHAnimationMasonryLoginVC.h"
#import "SHRAC1ViewController.h"
#import "SHRAC4ViewController.h"

@interface SHReactiveCocoaViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *controllersArray;
@property(nonatomic,strong)NSMutableArray *titlesArray;

@end

@implementation SHReactiveCocoaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView=({
        UITableView *tableView=[UITableView new];
        [self.view addSubview:tableView];
        tableView.frame=CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        tableView.delegate=self;
        tableView.dataSource=self;
        tableView;
    });
    _controllersArray= [@[SHAnimationMasonryLoginVC.new,
                          [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle bundleForClass:SHRAC1ViewController.class]] instantiateViewControllerWithIdentifier:@"SHRAC1ViewController"],
                          SHRAC4ViewController.new,
                          ] mutableCopy];
    
    self.titlesArray=[@[@"1、Autolayout_masonry登录动画",
                        @"2、介绍（一）——基本介绍",
                        @"3、介绍四_流程分析",
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
    [self.navigationController pushViewController:_controllersArray[indexPath.row] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
