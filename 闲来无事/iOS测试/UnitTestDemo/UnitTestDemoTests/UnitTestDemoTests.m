//
//  UnitTestDemoTests.m
//  UnitTestDemoTests
//
//  Created by huangaengoln on 16/1/27.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TestManager.h"

@interface UnitTestDemoTests : XCTestCase

@end

@implementation UnitTestDemoTests

-(void)testAddNumber {
    NSInteger res=[[TestManager sharedManager]addNuber:10 withNumber:20];
    XCTAssertEqual(res, 30);
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
