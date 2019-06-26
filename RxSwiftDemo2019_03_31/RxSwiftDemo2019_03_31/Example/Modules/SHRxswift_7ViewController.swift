//
//  SHRxswift_7ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by rrd on 2019/6/26.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class SHRxswift_7ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var switch1: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        switch1.rx.isOn.asObservable()
            .subscribe(onNext: {
                print("当前开关状态：\($0)")
            }).disposed(by: disposeBag)
        
    }
}
