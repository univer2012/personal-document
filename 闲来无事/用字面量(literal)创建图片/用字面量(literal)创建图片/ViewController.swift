//
//  ViewController.swift
//  用字面量(literal)创建图片
//
//  Created by huangaengoln on 15/11/4.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // 用字面量(literal)创建图片
        let image=[#Image(imageLiteral: "kitten2.png")#]
        let imageView=UIImageView(image: image)
        imageView.frame=CGRect(x: 100, y: 100, width: 100, height: 100)
        self.view.addSubview(imageView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

