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
        
let disposeBag = DisposeBag()
//第1个Observable，及其订阅
let observable1 = Observable.of("A","B","C")
observable1.subscribe { (event) in
    print(event)
}.disposed(by: disposeBag)

//第2个Observable，及其订阅
let observable2 = Observable.of(1,2,3)
observable2.subscribe { (event) in
    print(event)
}.disposed(by: disposeBag)
        
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
