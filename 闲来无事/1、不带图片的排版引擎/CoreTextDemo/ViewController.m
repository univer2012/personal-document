//
//  ViewController.m
//  CoreTextDemo
//
//  Created by huangaengoln on 15/11/8.
//  Copyright (c) 2015年 huangaengoln. All rights reserved.
//

#import "ViewController.h"
#import "CTDisplayView.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet CTDisplayView *ctView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CTFrameParserConfig *config=[[CTFrameParserConfig alloc]init];
    config.textColor=[UIColor redColor];
    config.width=self.ctView.width;
    
    CoreTextData *data=[CTFrameParser parseContent:@"按照以上原则，我们将‘CTDisplayView’中的部分内容拆开。" config:config];
    self.ctView.data=data;
    self.ctView.height=data.height;
    self.ctView.backgroundColor=[UIColor yellowColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
