//
//  SGHBahamaAirLoginViewController.swift
//  SwiftDemo160801
//
//  Created by huangaengoln on 16/8/4.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//




import UIKit


class SGHBahamaAirLoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var cloud1: UIImageView!
    @IBOutlet weak var cloud2: UIImageView!
    @IBOutlet weak var cloud3: UIImageView!
    @IBOutlet weak var cloud4: UIImageView!
    
    
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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        heading.center.x -= view.bounds.width
        username.center.x -= view.bounds.width
        password.center.x -= view.bounds.width
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        // 1创建视图动画
        /*
         本课时所讲的知识点：
         · 为动画设置stage
         · 创建移动和淡化效果动画
         · 调整移动动画的平滑度
         · 反向和重复动画
         
         */
//        #if false
        
        UIView.animate(withDuration: 0.5, animations: { 
            self.heading.center.x += self.view.bounds.width
        }) 
        /**
         *	options: 是UIViewAnimationOptions结构体：
         Repeat  用这个选项的动画，会永远循环下去，
         Autoreverse 这个选项只能与 Repeat 结合使用，它会让动画从头到尾再从尾到头，循环播放，
         
         一类选项与动画缓冲相关:
         CurveEaseInOut: 开始时加速，结束时减速
         CurveEaseIn: 开始时加速
         CurveEaseOut: 结束时减速
         CurveLinear: 线性速度，
         */
        UIView.animate(withDuration: 0.5, delay: 0.3, options: UIViewAnimationOptions(), animations: {
            self.username.center.x += self.view.bounds.width
            }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.4, options: [.repeat, .autoreverse], animations: {
            self.password.center.x += self.view.bounds.width
            }, completion: nil)
        
//        #elseif true
//        
//            
//        #endif
        
        
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: further methods
    
    @IBAction func login() {
        view.endEditing(true)
    }
    
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextField = (textField === username) ? password : username
        nextField?.becomeFirstResponder()
        return true
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
