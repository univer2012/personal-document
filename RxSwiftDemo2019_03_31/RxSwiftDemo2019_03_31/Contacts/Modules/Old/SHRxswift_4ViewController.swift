//
//  SHRxswift_4ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by rrd on 2019/6/17.
//  Copyright © 2019 远平. All rights reserved.
//
/*
 * 来自：[Swift - RxSwift的使用详解22（UI控件扩展2：UITextField、UITextView）](https://www.jianshu.com/p/7abbff16857e)
 */
import UIKit

import RxSwift
import RxCocoa

class SHRxswift_4ViewController: UIViewController {
    let disposeBag = DisposeBag()
    //用户名输入框
    @IBOutlet weak var username: UITextField!
    //密码输入框
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //在用户名输入框中按下 return 键
        username.rx.controlEvent([.editingDidEndOnExit])
            .subscribe(onNext: {[weak self] (_) in
                self?.password.becomeFirstResponder()
            })
            .disposed(by: disposeBag)
        //在密码输入框中按下 return 键
        password.rx.controlEvent([.editingDidEndOnExit])
            .subscribe(onNext: {[weak self] (_) in
                self?.password.resignFirstResponder()
            })
            .disposed(by: disposeBag)
        
    }
}
