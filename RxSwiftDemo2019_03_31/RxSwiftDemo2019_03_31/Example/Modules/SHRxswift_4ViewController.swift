//
//  SHRxswift_4ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by rrd on 2019/6/17.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class SHRxswift_4ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //每隔1秒钟发送1个事件
        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .share(replay: 5)
        //第一个订阅者（立刻开始订阅）
        _ = interval.subscribe(onNext: {print("订阅1: \($0)")})
        //第二个订阅者（延迟5秒开始订阅）
        delay(5) {
            _ = interval.subscribe(onNext: {print("订阅2: \($0)")})
        }
    }
    ///延迟执行
    /// - Parameters:
    ///   - delay: 延迟时间（秒）
    ///   - closure: 延迟执行的闭包
    public func delay(_ delay: Double, closure:@escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            closure()
        }
    }
}

