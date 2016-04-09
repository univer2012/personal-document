//
//  ViewController.swift
//  闭包_Map_Filter_Reduce
//
//  Created by huangaengoln on 15/11/14.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //map
        let intArray=[1,111,1111]
        let stringArray=intArray.map({(intValue) -> String in
            return "\(intValue)"
        })
        
        //Filter
        let filterArray=intArray.filter({(intValue)-> Bool in
            return intValue > 30
        })
        
        // Reduce
        let sum=intArray.reduce(0, combine: +)
        let sum2=intArray.reduce(0) {(int,int2) -> Int in
            return int + int2
        }
        print("intArray : \(intArray),stringArray : \(stringArray),filterArray : \(filterArray),sum : \(sum),sum2 : \(sum2)")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

