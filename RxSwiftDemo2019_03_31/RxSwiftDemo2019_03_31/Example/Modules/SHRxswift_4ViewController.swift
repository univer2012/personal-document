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
        //创建文本输入框
        let inputFiled = UITextField(frame: CGRect(x: 10, y: 80, width: 200, height: 30))
        inputFiled.borderStyle = UITextField.BorderStyle.roundedRect
        self.view.addSubview(inputFiled)
        
        //创建文本输入框
        let outputFiled = UITextField(frame: CGRect(x: 10, y: 150, width: 200, height: 30))
        outputFiled.borderStyle = UITextField.BorderStyle.roundedRect
        self.view.addSubview(outputFiled)
        
        
        //创建文本标签
        let label = UILabel(frame: CGRect(x: 20, y: 190, width: 300, height: 30))
        self.view.addSubview(label)
        
        //创建按钮
        let button: UIButton = UIButton(type: .custom)
        button.frame = CGRect(x: 20, y: 230, width: 40, height: 30)
        button.setTitleColor(.blue, for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        button.setTitle("提交", for: .normal)
        self.view.addSubview(button)
        
        //当文本框内容改变
        let input = inputFiled.rx.text.orEmpty.asDriver()
        .throttle(0.3)
        
        //内容绑定到另一个输入框中
        input.drive(outputFiled.rx.text)
        .disposed(by: disposeBag)
        
        //内容绑定到文本标签中
        input.map{ "当前字数：\($0.count)" }
        .drive(label.rx.text)
        .disposed(by: disposeBag)
        
        //根据内容字数决定按钮是否可用
        input.map{ $0.count > 5 }
        .drive(button.rx.isEnabled)
        .disposed(by: disposeBag)
    }
}
