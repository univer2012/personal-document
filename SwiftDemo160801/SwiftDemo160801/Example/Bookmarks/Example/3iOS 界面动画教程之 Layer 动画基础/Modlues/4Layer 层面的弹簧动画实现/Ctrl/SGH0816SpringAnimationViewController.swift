//
//  SGH0816SpringAnimationViewController.swift
//  SwiftDemo160801
//
//  Created by huangaengoln on 16/8/16.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

/*
 课时知识点：
· 阻尼振子
 · UIKit与Core Animation弹簧实现的对比
 · 弹簧动画的属性
 */
import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


class SGH0816SpringAnimationViewController: UIViewController, CAAnimationDelegate {
    
    @IBOutlet weak var cloud1: UIImageView!
    @IBOutlet weak var cloud2: UIImageView!
    @IBOutlet weak var cloud3: UIImageView!
    @IBOutlet weak var cloud4: UIImageView!
    
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    var statusPosition = CGPoint.zero
    let info = UILabel()
    
    
    
    //MARK: further UI
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    let status = UIImageView(image: UIImage(named: "banner"))
    let label = UILabel()
    let message = ["Connecting ...", "Authorizing ...", "Sending credentials ...", "Failed"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //setup the UI
        loginButton.layer.cornerRadius = 8.0
        loginButton.layer.masksToBounds = true
        
        spinner.frame = CGRect(x: -20.0, y: 6.0, width: 20.0, height: 20.0)
        spinner.startAnimating()
        spinner.alpha = 0.0
        loginButton.addSubview(spinner)
        
        status.isHidden = true
        status.center = loginButton.center
        view.addSubview(status)
        
        label.frame = CGRect(x: 0.0, y: 0.0, width: status.frame.size.width, height: status.frame.size.height)
        label.font = UIFont(name: "HelveticaNeue", size: 18.0)
        label.textColor = UIColor(red: 0.89, green: 0.38, blue: 0.0, alpha: 1.0)
        label.textAlignment = .center
        status.addSubview(label)
        
        statusPosition = status.center
        
        
        info.frame = CGRect(x: 0.0, y: loginButton.center.y + 60.0, width: view.frame.size.width, height: 30)
        info.backgroundColor = UIColor.clear
        info.font = UIFont(name: "HelveticaNeue", size: 12.0)
        info.textAlignment = .center
        info.textColor = UIColor.white
        info.text = "请在上面的框中输入用户名和密码"
        view.insertSubview(info, belowSubview: loginButton)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        delay(seconds: 5.0) {
            print("fields 去哪里了？")
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let formGroup = CAAnimationGroup()
        formGroup.duration = 0.5
        formGroup.fillMode = kCAFillModeBackwards
        
        let flyRight = CABasicAnimation(keyPath: "position.x")
        flyRight.fromValue = -view.bounds.size.width / 2
        flyRight.toValue = view.bounds.size.width / 2
        
        let fadeFieldIn = CABasicAnimation(keyPath: "opacity")
        fadeFieldIn.fromValue = 0.25
        fadeFieldIn.toValue = 1.0
        
        formGroup.animations = [flyRight, fadeFieldIn]
        heading.layer.add(formGroup, forKey: nil)
        
        
        formGroup.delegate = self
        formGroup.setValue("form", forKey: "name")
        
        formGroup.setValue(username.layer, forKey: "layer")
        formGroup.beginTime = CACurrentMediaTime() + 0.3
        username.layer.add(formGroup, forKey: nil)
        
        formGroup.setValue(password.layer, forKey: "layer")
        formGroup.beginTime = CACurrentMediaTime() + 0.4
        password.layer.add(formGroup, forKey: nil)
        
        
        
        
        
        
        // opacity 透明度
        let fadeIn = CABasicAnimation(keyPath: "opacity")
        fadeIn.fromValue = 0.0
        fadeIn.toValue = 1.0
        fadeIn.duration = 0.5
        fadeIn.fillMode = kCAFillModeBackwards
        fadeIn.beginTime = CACurrentMediaTime() + 0.5
        cloud1.layer.add(fadeIn, forKey: nil)
        
        fadeIn.beginTime = CACurrentMediaTime() + 0.7
        cloud2.layer.add(fadeIn, forKey: nil)
        
        fadeIn.beginTime = CACurrentMediaTime() + 0.9
        cloud3.layer.add(fadeIn, forKey: nil)
        
        fadeIn.beginTime = CACurrentMediaTime() + 1.1
        cloud4.layer.add(fadeIn, forKey: nil)
        
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.beginTime = CACurrentMediaTime() + 0.5
        groupAnimation.duration = 0.5
        groupAnimation.fillMode = kCAFillModeBackwards
        groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        
        
        let scaleDown = CABasicAnimation(keyPath: "transform.scale")
        scaleDown.fromValue = 3.5
        scaleDown.toValue = 1.0
        
        let rotate = CABasicAnimation(keyPath: "transform.rotation")
        rotate.fromValue = CGFloat(M_PI_4)
        rotate.toValue = 1.0
        
        let fade = CABasicAnimation(keyPath: "opacity")
        fade.fromValue = 0.0
        fade.toValue = 1.0
        
        groupAnimation.animations = [scaleDown, rotate, fade]
        loginButton.layer.add(groupAnimation, forKey: nil)
        groupAnimation.timingFunction = CAMediaTimingFunction()
        
        
        
        
        
        
        self.p_animateCloud(cloud1.layer)
        self.p_animateCloud(cloud2.layer)
        self.p_animateCloud(cloud3.layer)
        self.p_animateCloud(cloud4.layer)
        
        /* 从右移到中间的layer动画*/
        let flyLeft = CABasicAnimation(keyPath: "position.x")
        flyLeft.fromValue = info.layer.position.x + view.frame.size.width
        flyLeft.toValue = info.layer.position.x
        flyLeft.duration = 5.0
        
        info.layer.add(flyLeft, forKey: "infoappear")
        
        
        /* 从0.2到1.0的透明度动画 */
        let fadeLabelIn = CABasicAnimation(keyPath: "opacity")
        fadeLabelIn.fromValue = 0.2
        fadeLabelIn.toValue = 1.0
        fadeLabelIn.duration = 4.5
        info.layer.add(fadeLabelIn, forKey: "fadein")
        
        username.delegate = self
        password.delegate = self
    }
    
    
    //MARK: further methods
    /*override*/ func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let name = anim.value(forKey: "name") as? String {
            if name == "form" {
                
                let layer = anim.value(forKey: "layer") as? CALayer
                anim.setValue(nil, forKey: "layer")
                
                let pluse = CASpringAnimation(keyPath: "transform.scale")
                pluse.damping = 7.5
                pluse.fromValue = 1.25
                pluse.toValue = 1.0
                pluse.duration = pluse.settlingDuration
                
                layer?.add(pluse, forKey: nil)
            }
            
            if name == "cloud" {
                if let layer = anim.value(forKey: "layer") as? CALayer {
                    anim.setValue(nil, forKey: "layer")
                    
                    layer.position.x = -layer.bounds.width / 2
                    delay(seconds: 0.5, completion: {
                        self.p_animateCloud(layer)
                    })
                }
            }
        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: further methods
    
    func p_showMessage(index: Int) {
        label.text = message[index]
        /**
         *	这个方法是以动画的方式，将status显示到视图控制器中，通过0.33秒的动画，以慢出、翻书向下的形式
         */
        /*
         TransitionNone:   没有
         TransitionFlipFromLeft: 从左侧
         TransitionFlipFromRight: 从右侧
         TransitionCurlUp: 从上面卷
         TransitionCurlDown:  从下面卷
         TransitionCrossDissolve: 十字溶解，
         TransitionFlipFromTop:  从上面翻
         TransitionFlipFromBottom 从下面翻
         */
        //进行变形动画，
        UIView.transition(with: status, duration: 0.33, options: [.curveEaseOut, .transitionCurlDown], animations: {
            self.status.isHidden = false
        }) { (_) in
            //变形动画完成后所执行的代码
            if index < self.message.count - 1 {
                delay(seconds: 2.0, completion: {
                    self.p_removeMeaage(index: index)
                })
            }
            else {
                //重置
                self.p_resetForm()
            }
            
        }
    }
    
    
    func p_removeMeaage(index: Int) {
        UIView.animate(withDuration: 0.33, delay: 0.0, options: [], animations: {
            self.status.center.x += self.view.frame.size.width
        }) { (_) in
            self.status.isHidden = true
            self.status.center = self.statusPosition
            self.p_showMessage(index: index + 1)
        }
    }
    
    func p_resetForm() {
        UIView.transition(with: status, duration: 0.2, options: .transitionCurlUp, animations: {
            //隐藏status，重置位置
            self.status.isHidden = true
            self.status.center = self.statusPosition
            }, completion: nil)
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [], animations: {
            //spinner移除视图，并渐隐
            self.spinner.center = CGPoint(x: -20.0, y: 16.0)
            self.spinner.alpha = 0.0
            //登录按钮还原 初始化颜色、宽度和中心的y
            self.loginButton.bounds.size.width -= 80.0
            self.loginButton.center.y -= 60.0
            }, completion: {(_) in
                let tintColor = UIColor(red: 0.63, green: 0.84, blue: 0.35, alpha: 1.0)
                self.p_tintBackgroundColor(layer: self.loginButton.layer, toColor: tintColor)
        })
        
        
    }
    
    func p_tintBackgroundColor(layer:CALayer, toColor: UIColor) {
        let tint = CABasicAnimation(keyPath: "backgroundColor")
        tint.fromValue = layer.backgroundColor
        tint.toValue = toColor.cgColor
        tint.duration = 1.0
        layer.add(tint, forKey: nil)
        layer.backgroundColor = toColor.cgColor
        
    }
    
    func p_animateCloud(_ layer: CALayer) {
        //1
        let cloudSpeed = 60.0 / Double(view.layer.frame.size.width)
        let duration: TimeInterval = Double(view.layer.frame.size.width - layer.frame.origin.x) * cloudSpeed
        
        //2
        let cloudMove = CABasicAnimation(keyPath: "position.x")
        cloudMove.duration = duration
        cloudMove.toValue = self.view.bounds.size.width + layer.bounds.width / 2
        cloudMove.delegate = self
        cloudMove.setValue("cloud", forKey: "name")
        cloudMove.setValue(layer, forKey: "layer")
        
        layer.add(cloudMove, forKey: nil)
        
    }
    
    @IBAction func login() {
        view.endEditing(true)
        
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: [], animations: {
            self.loginButton.bounds.size.width += 80.0
            }, completion: { _ in
                self.p_showMessage(index: 0)
        })
        
        let tintColor = UIColor(red: 0.85, green: 0.83, blue: 0.45, alpha: 1.0)
        p_tintBackgroundColor(layer: loginButton.layer, toColor: tintColor)
        
        
        UIView.animate(withDuration: 0.33, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: [], animations: {
            self.loginButton.center.y += 60.0
            
            
            self.spinner.center = CGPoint(x: 40.0, y: self.loginButton.frame.size.height / 2)
            self.spinner.alpha = 1.0
            
            }, completion: nil)
        
    }


}

//MARK: - UITextFieldDelegate
extension SGH0816SpringAnimationViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //print(info.layer.animationKeys())
        info.layer.removeAnimation(forKey: "infoappear")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextField = (textField === username) ? password : username
        nextField?.becomeFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.characters.count < 5 {
            let jump = CASpringAnimation(keyPath: "position.y")
            jump.fromValue = textField.layer.position.y + 1.0
            jump.toValue = textField.layer.position.y
            jump.initialVelocity = 100.0
            jump.mass = 10.0
            jump.stiffness = 1500.0
            jump.damping = 50.0
            jump.duration = jump.settlingDuration
            textField.layer.add(jump, forKey: nil)
            
        }
        
        // 边框有 从红到透明的震荡
        textField.layer.borderWidth = 3.0
        textField.layer.borderColor = UIColor.clear.cgColor
        
        let flash = CASpringAnimation(keyPath: "borderColor")
        flash.damping = 7.0
        flash.stiffness = 200.0
        flash.fromValue = UIColor(red: 0.96, green: 0.27, blue: 0.0, alpha: 1.0).cgColor
        flash.toValue = UIColor.clear.cgColor
        flash.duration = flash.settlingDuration
        textField.layer.add(flash, forKey: nil)
        
    }
}

