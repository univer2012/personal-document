//
//  SHRxswift_22ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2020/4/20.
//  Copyright © 2020 远平. All rights reserved.
//
/*
* 来自：[Swift - RxSwift的使用详解22（UI控件扩展2：UITextField、UITextView）](https://www.hangge.com/blog/cache/detail_1964.html)
*/
import UIKit
import RxSwift
import RxCocoa

class SHRxswift_22ViewController: SHBaseTableViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.actionType = .method
        //section 1
        var tempTitleArray = [
            "1.监听单个 textField 内容的变化（textView 同理）",
            "1_2.直接使用 change 事件效果也是一样的。",
            "2.将内容绑定到其他控件上",
        ]
        var tempClassNameArray = [
            "demo1",
            "demo1_2",
            "demo2",
        ]
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "二、UITextField 与 UITextView")
    }
    
    
    //MARK: 3.同时监听多个 textField 内容的变化（textView 同理）
    ///### 3，同时监听多个 textField 内容的变化（textView 同理）
    @objc func demo3() {
        
    }
    
    //MARK: 2.将内容绑定到其他控件上
    ///### 2，将内容绑定到其他控件上
    @objc func demo2() {
        //创建文本输入框
        let inputField = UITextField(frame: CGRect(x:10, y:80, width:200, height:30))
        inputField.borderStyle = UITextField.BorderStyle.roundedRect
        self.view.addSubview(inputField)
         
        //创建文本输出框
        let outputField = UITextField(frame: CGRect(x:10, y:150, width:200, height:30))
        outputField.borderStyle = UITextField.BorderStyle.roundedRect
        self.view.addSubview(outputField)
         
        //创建文本标签
        let label = UILabel(frame:CGRect(x:20, y:190, width:300, height:30))
        self.view.addSubview(label)
         
        //创建按钮
        let button:UIButton = UIButton(type:.system)
        button.frame = CGRect(x:20, y:230, width:40, height:30)
        button.setTitle("提交", for:.normal)
        self.view.addSubview(button)
         
        self.remakeTableViewConstraints(with: button)
         
        //当文本框内容改变
        let input = inputField.rx.text.orEmpty.asDriver() // 将普通序列转换为 Driver
            .throttle(0.3) //在主线程中操作，0.3秒内值若多次改变，取最后一次
         
        //内容绑定到另一个输入框中
        input.drive(outputField.rx.text)
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
    
    //MARK: 1_2.直接使用 change 事件效果也是一样的。
    ///当然我们直接使用 change 事件效果也是一样的。
    @objc func demo1_2() {
        //创建文本输入框
        let textField = UITextField(frame: CGRect(x:10, y:100, width:200, height:30))
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        self.view.addSubview(textField)
         
        self.remakeTableViewConstraints(with: textField)
        
        textField.rx.text.orEmpty.changed
            .subscribe(onNext: {
                print("您输入的是： \($0)")
            })
            .disposed(by: disposeBag)
    }

    //MARK: 二、UITextField 与 UITextView
    //MARK: 1.监听单个 textField 内容的变化（textView 同理）
    ///1，监听单个 textField 内容的变化（textView 同理）
    ///注意：.orEmpty 可以将 String? 类型的 ControlProperty 转成 String，省得我们再去解包。
    @objc func demo1() {
        //创建文本输入框
        let textField = UITextField(frame: CGRect(x:10, y:100, width:200, height:30))
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        self.view.addSubview(textField)
         
        self.remakeTableViewConstraints(with: textField)
        
        //当文本框内容改变时，将内容输出到控制台上
        textField.rx.text.orEmpty.asObservable()
            .subscribe(onNext: {
                print("您输入的是：\($0)")
            })
            .disposed(by: disposeBag)
    }
}
