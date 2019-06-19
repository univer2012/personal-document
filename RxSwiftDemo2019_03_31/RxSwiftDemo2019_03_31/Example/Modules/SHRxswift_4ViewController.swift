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

//创建一个初始值为111的Variable
let variable = Variable("111")

//修改value值
variable.value = "222"

//第1次订阅
variable.asObservable().subscribe{
    print("第1次订阅：",$0)
}.disposed(by: disposeBag)

//修改value值
variable.value = "333"

//第2次订阅
variable.asObservable().subscribe{
    print("第2次订阅：",$0)
}.disposed(by: disposeBag)

//修改value值
variable.value = "444"
        
    }
}

