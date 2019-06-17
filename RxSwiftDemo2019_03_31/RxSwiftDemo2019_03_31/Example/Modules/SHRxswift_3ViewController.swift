//
//  SHRxswift_3ViewController.swift
//  
//
//  Created by rrd on 2019/6/17.
//

import UIKit

import RxSwift

class SHRxswift_3ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //1，just() 方法
        let observable = Observable<Int>.just(5)
        //2，of() 方法
        let observable2 = Observable.of("A","B","C")
        //3，from() 方法
        let observable3 = Observable.from(["A","B","C"])
        //4，empty() 方法
        let observable4 = Observable<Int>.empty()
        //5，never() 方法
        let observable5 = Observable<Int>.never()
        //6，error() 方法
        enum MyError: Error {
            case A
            case B
        }
        let observable6 = Observable<Int>.error(MyError.A)
        
        //7，range() 方法
        //使用range()
        let observable7_1 = Observable.range(start: 1, count: 5)
        //使用of()
        let observable7_2 = Observable.of(1,2,3,4,5)
        
        //8，repeatElement() 方法
        let observable8 = Observable.repeatElement(1)
        
        //9，generate() 方法
        
        
        //10，create() 方法
        
        
        //11，deferred() 方法
        
        
        //12，interval() 方法
        
        let observable12 = Observable<Int>.timer(5, scheduler: MainScheduler.instance)
        observable12.subscribe { (event) in
            print(event)
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
