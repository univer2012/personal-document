//
//  SHRxswift_4ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by rrd on 2019/6/17.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit

import RxSwift

class SHRxswift_4ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
let observable = Observable.of("A","B", "C")
        observable.do(onNext: { (element) in
            print("Intercepted Next:",element)
        }, onError: { (error) in
            print("Intercepted Next:", error)
        }, onCompleted: {
            print("Intercepted Completed")
        }, onDispose: {
            print("Intercepted Disposed")
        })
    }
        
        
        // Do any additional setup after loading the view.
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
