//
//  SHRxswift_17ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by rrd on 2019/7/9.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import RxDataSources

class SHRxswift_17ViewController: UIViewController {
    let disposeBag = DisposeBag()
    @IBOutlet weak var startBtn: UIButton!
    
    @IBOutlet weak var cancelBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        
        URLSession.shared.rx.json(request: request).subscribe(onNext: { (data) in
//            let json
            print("----- 请求成功！返回的如下数据 --------")
            print(data)
        })
            .disposed(by: disposeBag)
        
//        startBtn.rx.tap.asObservable()
//            .flatMap {
//                URLSession.shared.rx.data(request: request)
//                .takeUntil(self.cancelBtn.rx.tap)
//            }
//            .subscribe(onNext: { (data) in
//                let str = String(data: data, encoding: String.Encoding.utf8)
//                print("请求成功！返回的数据是：",str ?? "")
//            }, onError: { (error) in
//                print("请求失败！错误原因：",error)
//            }).disposed(by: disposeBag)
    }
}
