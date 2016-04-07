//
//  ViewController.swift
//  Tip2将protocol的方法声明为mutating
//
//  Created by huangaengoln on 16/4/2.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

protocol Vehicle {
    var numberOfWheels: Int {get}
    var color: UIColor {get set}
    
    mutating func changeColor()
}
struct MyCar: Vehicle {
    let numberOfWheels = 4
    var color = UIColor.blueColor()
    
    mutating func changeColor() {
        color = UIColor.redColor()
    }
}

