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
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
let disposeBag = DisposeBag()

let source = PublishSubject<Int>()
let notifier = PublishSubject<String>()

source
    .sample(notifier)
    .subscribe(onNext: { print($0) })
    .disposed(by: disposeBag)

source.onNext(1)

//让源序列接收接收消息
notifier.onNext("A")

source.onNext(2)

//让源序列接收消息
notifier.onNext("B")
notifier.onNext("C")

source.onNext(3)
source.onNext(4)

//让源序列接收消息
notifier.onNext("D")

source.onNext(5)

//让源序列接收消息
notifier.onCompleted()
        
    }
}

