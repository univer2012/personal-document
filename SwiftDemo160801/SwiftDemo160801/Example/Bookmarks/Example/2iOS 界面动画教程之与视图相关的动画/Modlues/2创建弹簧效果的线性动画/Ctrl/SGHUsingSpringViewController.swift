//
//  SGHUsingSpringViewController.swift
//  SwiftDemo160801
//
//  Created by huangaengoln on 16/8/5.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

//创建弹簧效果的线性动画
/*
 课时知识点：
 · 弹簧动画的制作
 · 用户交互时的动画
 */

import UIKit

class SGHUsingSpringViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var cloud1: UIImageView!
    @IBOutlet weak var cloud2: UIImageView!
    @IBOutlet weak var cloud3: UIImageView!
    @IBOutlet weak var cloud4: UIImageView!
    
    
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
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        heading.center.x -= view.bounds.width
        username.center.x -= view.bounds.width
        password.center.x -= view.bounds.width
        
        loginButton.center.y += 30.0
        loginButton.alpha = 0.0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
        
        UIView.animate(withDuration: 0.5, animations: {
            self.heading.center.x += self.view.bounds.width
        }) 
        
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [], animations: {
            self.username.center.x += self.view.bounds.width
            }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.4, options: [], animations: {
            self.password.center.x += self.view.bounds.width
            }, completion: nil)
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
    @IBAction func login() {
        view.endEditing(true)
        
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: [], animations: { 
            self.loginButton.bounds.size.width += 80.0
            }, completion: nil)
        
        UIView.animate(withDuration: 0.33, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: [], animations: {
            self.loginButton.center.y += 60.0
            self.loginButton.backgroundColor = UIColor(red: 0.85, green: 0.83, blue: 0.45, alpha: 1.0)
            
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
