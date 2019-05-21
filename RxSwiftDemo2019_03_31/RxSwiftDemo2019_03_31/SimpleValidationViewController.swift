//
//  SimpleValidationViewController.swift
//  RxExample
//
//  Created by Krunoslav Zaher on 12/6/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

fileprivate let minimalUsernameLength = 5
fileprivate let minimalPasswordLength = 5

class SimpleValidationViewController : ViewController {

    @IBOutlet weak var usernameOutlet: UITextField!
    @IBOutlet weak var usernameValidOutlet: UILabel!

    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var passwordValidOutlet: UILabel!

    @IBOutlet weak var doSomethingOutlet: UIButton!
    
    var bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        usernameValidOutlet.text = "Username has to be at least \(minimalUsernameLength) characters"
        passwordValidOutlet.text = "Password has to be at least \(minimalPasswordLength) characters"
        // 用户名是否有效
        let usernameValid = usernameOutlet.rx.text.orEmpty
            // 用户名 -> 用户名是否有效
            .map { $0.count >= minimalUsernameLength }
            .share(replay: 1) // without this map would be executed once for each binding, rx is stateless by default
        // 密码是否有效
        let passwordValid = passwordOutlet.rx.text.orEmpty
            .map{ $0.count >= minimalPasswordLength}
        .share(replay: 1)

        // 所有输入是否有效
        //combineLatest  结合最新的
        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }// 取用户名和密码同时有效
            .share(replay: 1)
        // 用户名是否有效 -> 密码输入框是否可用
        usernameValid
            .bind(to: passwordOutlet.rx.isEnabled)
            .disposed(by: bag)
        // 用户名是否有效 -> 用户名提示语是否隐藏
        usernameValid
            .bind(to: usernameValidOutlet.rx.isHidden)
            .disposed(by: bag)
        
        // 密码是否有效 -> 密码提示语是否隐藏
        passwordValid
            .bind(to: passwordValidOutlet.rx.isHidden)
            .disposed(by: bag)

        // 所有输入是否有效 -> 绿色按钮是否可点击
        everythingValid
            .bind(to: doSomethingOutlet.rx.isEnabled)
            .disposed(by: bag)

        doSomethingOutlet.rx.tap
            .subscribe(onNext: { [weak self] _ in self?.showAlert() })
            .disposed(by: bag)
    }

    func showAlert() {
        let alertView = UIAlertView(
            title: "RxExample",
            message: "This is wonderful",
            delegate: nil,
            cancelButtonTitle: "OK"
        )

        alertView.show()
    }

}
