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
        
        //观察者
        let observer :AnyObserver<String> = AnyObserver { (event) in
            switch event {
            case .next(let text):
                //收到发出的索引数后显示到label上
                self.label.text = text
            default:
                break
            }
        }
        //Observable序列（每隔1秒钟发出一个索引数）
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observable.map{"当前索引数：\($0)"}
        .bind(to: observer)
        .disposed(by: disposeBag)
    }
}
