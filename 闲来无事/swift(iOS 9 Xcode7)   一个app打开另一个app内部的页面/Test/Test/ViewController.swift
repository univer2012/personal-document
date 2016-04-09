//
//  ViewController.swift
//  Test
//
//  Created by huangaengoln on 15/10/29.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        openAppButton()
    }
    func openAppButton() {
        let button=UIButton()
        self.view.addSubview(button)////(必须要先把button加进来，才可以用去写它的布局)erminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'couldn't find a common superview for <UIButton: 0x136682f20; frame = (0 0; 0 0); opaque = NO; layer = <CALayer: 0x136682e70>> and <UIView: 0x136683900; frame = (0 0; 414 736); autoresize = W+H; layer = <CALayer: 0x136682be0>>'*** First throw call stack:
        button.frame=CGRectMake(20, 100, self.view.frame.size.width-2*20, 40);
//        button.center=self.view.center
        button.setTitle("打开BasicGrammar", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.cyanColor(), forState: UIControlState.Normal)
        button.setTitleColor(UIColor.greenColor(), forState: UIControlState.Highlighted)
        button.titleLabel?.font=UIFont.systemFontOfSize(18)
        
        //设置button边框
        button.layer.borderColor=UIColor.greenColor().CGColor
        button.layer.borderWidth=2
        button.layer.cornerRadius=10
//        button.layer.masksToBounds=true
        button.addTarget(self, action: "openApp", forControlEvents: UIControlEvents.TouchUpInside)
    }
    func openApp() {
        //记得设置info.plist里面的LSApplicationQueriesSchemes，iOS9止呕需要，iOS9之后提高了app的安全性，需要给出一个类似白名单的东西，在白名单里面的才能打开app。不然报错：： -canOpenURL: failed for URL: "OpenAppTest://mark?id=007" - error: "This app is not allowed to query for scheme OpenAppTest"
        //OpenAppTest://mark?id=xxxx   (调用BasicGrammar app 拼接参数字符串，拼接的时候就像url那样子  OpenAppTest://标记名字?name＝xiaomin&age＝23)
        let urlStr="OpenAppTest://mark?id="+"007"
        let customUrl=NSURL(string: urlStr)
        if UIApplication.sharedApplication().canOpenURL(customUrl!) {
            UIApplication.sharedApplication().openURL(customUrl!)
        } else {
            //提示没有安装BasicGrammar app
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

