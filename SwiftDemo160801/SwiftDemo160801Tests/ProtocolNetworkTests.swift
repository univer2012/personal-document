//
//  ProtocolNetworkTests.swift
//  SwiftDemo160801
//
//  Created by huangaengoln on 2016/12/22.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

import XCTest
@testable import SwiftDemo160801

class ProtocolNetworkTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    //MARK:测试
    struct LocalFileClient: Client {
        func send<T : Request>(_ r: T, handler: @escaping (T.Response?) -> Void) {
            switch r.path {
            case "/users/onevcat":
                guard let fileURL = Bundle(for: ProtocolNetworkTests.self).url(forResource:"users_onevcat", withExtension: "txt") else {
                    fatalError()
                }
                guard let data = try? Data(contentsOf: fileURL) else {
                    fatalError()
                }
                handler(T.Response.parse(data: data))
            default:
                fatalError("Unknown path")
            }
        }
        //为了满足`Client`的要求，实际我们不会发送请求
        let host = ""
    }
    
    func testUserRequest() {
        let client = LocalFileClient()
        client.send(UserRequest(name: "onevcat")) {
            user in
            XCTAssertNil(user)
            XCTAssertEqual(user!.name, "Wei Wang")
        }
    }
    
}
