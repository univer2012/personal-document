//
//  SHRxswift_45ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2019/11/4.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxAlamofire

class SHRxswift_45ViewController: UIViewController {
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string: urlString)!
        
        //创建并发起请求
        requestData(.get, url).subscribe(onNext: { (response, data) in
            if 200 ..< 300 ~= response.statusCode {
                //数据处理
                let str = String(data: data, encoding: String.Encoding.utf8)
                print("请求成功！返回的数据是：",str ?? "")
            } else {
                print("请求失败！")
            }
        }).disposed(by: disposeBag)
    }

}



////创建URL对象
//let urlString = "https://www.douban.com/j/app/radio/channels"
//let url = URL(string: urlString)!
//
////创建并发起请求
//requestData(.get, url).subscribe(onNext: { (response, data) in
//    if 200 ..< 300 ~= response.statusCode {
//        //数据处理
//        let str = String(data: data, encoding: String.Encoding.utf8)
//        print("请求成功！返回的数据是：",str ?? "")
//    } else {
//        print("请求失败！")
//    }
//}).disposed(by: disposeBag)


////创建URL对象
//let urlString = "https://www.douban.com/xxxxx/app/radio/channels"
//let url = URL(string: urlString)!
//
////创建并发起请求
//request(.get, url).data().subscribe(onNext: { (data) in
//    //数据处理
//    let str = String(data: data, encoding: String.Encoding.utf8)
//    print("返回的数据时：",str ?? "")
//},onError: { error in
//    print("请求失败！错误原因：",error)
//}).disposed(by: disposeBag)

