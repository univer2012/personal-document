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
    let label:UILabel = UILabel()
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
let disposeBag = DisposeBag()

//创建一个PublishSubject
let subject = PublishSubject<String>()

//由于当前没有任何订阅者，所以这条信息不会输出到控制台
subject.onNext("111")

//第1次订阅subject
subject.subscribe(onNext: { (string) in
    print("第1次订阅：",string)
}, onCompleted: {
    print("第1次订阅：onCompleted")
}).disposed(by: disposeBag)

//当前有1个订阅，则该信息会输出到控制台
subject.onNext("222")

//第2次订阅subject
subject.subscribe(onNext: { (string) in
    print("第2次订阅：",string)
}, onCompleted: {
    print("第2次订阅：onCompleted")
}).disposed(by: disposeBag)

//当前有2个订阅，则该信息会输出到控制台
subject.onNext("333")

//让subject结束
subject.onCompleted()

//subject完成后会发出.next事件了。
subject.onNext("444")

//subject完成后它的所有订阅（包括结束后的订阅），都能收到subject的.completed事件，
subject.subscribe(onNext: { (string) in
    print("第3次订阅：",string)
}, onCompleted: {
    print("第3次订阅：onCompleted")
}).disposed(by: disposeBag)
        
        
        
    }
}

