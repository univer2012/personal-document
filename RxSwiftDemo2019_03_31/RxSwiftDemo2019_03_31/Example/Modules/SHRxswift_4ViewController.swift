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

//创建一个BehaviorSubject
let subject = BehaviorSubject(value: "111")

//第1次订阅subject
subject.subscribe { (event) in
    print("第1次订阅：",event)
}.disposed(by: disposeBag)
//发送next事件
subject.onNext("222")

//发送error事件
subject.onError(NSError(domain: "local", code: 0, userInfo: nil))

//第2次订阅subject
subject.subscribe { (event) in
    print("第2次订阅：",event)
}
        
        
    }
}

