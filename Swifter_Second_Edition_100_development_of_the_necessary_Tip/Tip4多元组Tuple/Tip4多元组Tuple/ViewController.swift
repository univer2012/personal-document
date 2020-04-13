//
//  ViewController.swift
//  Tip4多元组Tuple
//
//  Created by huangaengoln on 16/4/3.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ==========例2
        //Objective-C中
        
        //
        let rect = CGRectMake(0, 0, 100, 100)
        let (small, large) = rect.divide(20, fromEdge: .MinXEdge)
        print("small : \(small) , large : \(large)")
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // ========== 例1
    //以前的写法
    func swapMe<T>(inout a: T, inout b: T) {
        let temp = a
        a = b
        b = temp
    }
    //现在的写法
    func swapMe1<T>(inout a: T, inout b: T) {
        (a, b) = (b, a)
    }
    

}

extension CGRect {
    //...
    func divide(atDistance: CGFloat, fromEdge: CGRectEdge) -> (slice: CGRect, remainder: CGRect) {
        //function body
        var sliceTemp = CGRect()
        var remainderTemp = CGRect()
        CGRectDivide(self, &sliceTemp, &remainderTemp, atDistance, fromEdge)
        return (sliceTemp ,remainderTemp)
    }
    //...
}

