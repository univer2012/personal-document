//
//  SGH0812LayerViewController.swift
//  SwiftDemo160801
//
//  Created by huangaengoln on 16/8/12.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

import UIKit

class SGH0812LayerViewController: UIViewController {

    
    @IBOutlet weak var cloud1: UIImageView!
    @IBOutlet weak var cloud2: UIImageView!
    @IBOutlet weak var cloud3: UIImageView!
    @IBOutlet weak var cloud4: UIImageView!
    
    @IBOutlet weak var heading: UILabel!
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    var statusPosition = CGPoint.zero
    
    
    
    //MARK: further UI
    let spinner = UIActivityIndicatorView(style: .whiteLarge)
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
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loginButton.center.y += 30.0
        loginButton.alpha = 0.0
        
        
        username.layer.position.x -= view.bounds.width
        password.layer.position.x -= view.bounds.width
        
        username.layer .setNeedsDisplay()
        password.layer .setNeedsDisplay()
        
        delay(seconds: 5.0) {
            print("fields 去哪里了？")
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        /*  position就是这个层所处的位于父层中的位置。*/
        let flyRight = CABasicAnimation(keyPath: "position.x")
        flyRight.fillMode = CAMediaTimingFillMode.both
        flyRight.fromValue = -view.bounds.size.width / 2
        flyRight.toValue = view.bounds.size.width / 2
        flyRight.isRemovedOnCompletion = false
        flyRight.duration = 0.5
        heading.layer.add(flyRight, forKey: nil)
        
        flyRight.beginTime = CACurrentMediaTime() + 0.3
        
        username.layer.add(flyRight, forKey: nil)
        
        flyRight.beginTime = CACurrentMediaTime() + 0.4
        password.layer.add(flyRight, forKey: nil)
        
        username.layer.position.x = view.bounds.width / 2
        password.layer.position.x = view.bounds.width / 2
        
        
        /**
         dampingRatio   控制阻尼的量，并且会逐渐减少，直到动画越来越接近界面元素最终的状态，接手的值是0.0~1.0，越接近0，代表越具有弹簧性，
         velocity       弹簧初始速度值，控制动画的初始速度，数值越大，开始的移动速度越快
         - returns:
         */
        
        
        
        
        //按钮会随着弹簧的移动效果忽隐忽现，
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
            self.loginButton.center.y -= 30.0
            self.loginButton.alpha = 1.0
            }, completion: nil)
        
        // opacity 透明度
        let fadeIn = CABasicAnimation(keyPath: "opacity")
        fadeIn.fromValue = 0.0
        fadeIn.toValue = 1.0
        fadeIn.duration = 0.5
        fadeIn.fillMode = CAMediaTimingFillMode.backwards
        fadeIn.beginTime = CACurrentMediaTime() + 0.5
        cloud1.layer.add(fadeIn, forKey: nil)
        
        fadeIn.beginTime = CACurrentMediaTime() + 0.7
        cloud2.layer.add(fadeIn, forKey: nil)
        
        fadeIn.beginTime = CACurrentMediaTime() + 0.9
        cloud3.layer.add(fadeIn, forKey: nil)
        
        fadeIn.beginTime = CACurrentMediaTime() + 1.1
        cloud4.layer.add(fadeIn, forKey: nil)
        
        
        
        
        self.p_animateCloud(cloud1)
        self.p_animateCloud(cloud2)
        self.p_animateCloud(cloud3)
        self.p_animateCloud(cloud4)
        
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextField = (textField === username) ? password : username
        nextField?.becomeFirstResponder()
        return true
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
    
    func p_animateCloud(_ cloud: UIImageView) {
        //云朵用60秒横穿屏幕，
        let cloudSpeed = 60.0 / view.frame.size.width
        //动画时间
        let duration = (view.frame.size.width - cloud.frame.origin.x) * cloudSpeed
        UIView.animate(withDuration: TimeInterval(duration), delay: 0.0, options: .curveLinear, animations: {
            cloud.frame.origin.x = self.view.frame.size.width
        }) { (_) in
            //在右侧消失后，重置到最左侧，并循环，
            cloud.frame.origin.x = -cloud.frame.size.width
            self.p_animateCloud(cloud)
        }
        
        
    }
    
    

    @IBAction func p_login() {
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
