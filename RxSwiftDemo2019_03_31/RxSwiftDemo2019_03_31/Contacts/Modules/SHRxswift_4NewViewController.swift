//
//  SHRxswift_4NewViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2020/4/17.
//  Copyright © 2020 远平. All rights reserved.
//
/*
 * 来自：[Swift - RxSwift的使用详解4（Observable订阅、事件监听、订阅销毁）](https://www.hangge.com/blog/cache/detail_1924.html)
 */
import UIKit
import RxSwift
import RxCocoa

class SHRxswift_4NewViewController: SHBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.actionType = .method
        //section 1
        let tempTitleArray = [
            "1.订阅 Observable - 第一种用法",
        ]
        let tempClassNameArray = [
            "demo1",
        ]
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "第1部分")
        
    }
    
    
    //MARK:1.订阅 Observable - 第一种用法
    @objc func demo1() {
        let observable = Observable.of("A", "B", "C")
        observable.subscribe { event in
            print(event)
        }
    }
    

}
