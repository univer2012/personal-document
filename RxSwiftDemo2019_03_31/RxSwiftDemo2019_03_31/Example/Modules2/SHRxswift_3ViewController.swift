//
//  SHRxswift_3ViewController.swift
//  
//
//  Created by rrd on 2019/6/17.
//

import UIKit

import RxSwift
import RxCocoa

class SHRxswift_3ViewController: UIViewController {
    
    let viewModel = SHRxswift_3ViewModel()
    let disposeBag = DisposeBag()
    
    let priceTextFld = UITextField()
    
    var priceDispose :Disposable?
    
    var observer : Observer<String>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        self.viewModel.didClickOpen("你好").subscribe(onSuccess: { (text) in
//            print("这是回调，回调成功：%@",text)
//        }).disposed(by: disposeBag)
        
        
        //let _ = self.viewModel.didClickOpen("不用回调")
        
        //监听
        //self.viewModel.didClickOpen("")
        
        #if true
        
        priceTextFld.frame = CGRect(x: 0, y: 200, width: self.view.frame.size.width, height: 50)
        self.priceTextFld.backgroundColor = UIColor.gray
        self.view.addSubview(priceTextFld)
        
        self.observer = self.viewModel.didClickOpen("").asObservable()
        
        observer.subscribe(onNext: { (text) in
            print("callBack_succeed_observer：%@",text)
        }).disposed(by: self.disposeBag)
        
        self.priceTextFld.rx.text.asObservable().subscribe(onNext: {[weak self] (text) in
            guard let `self` = self else { return }
            
            let _ = self.viewModel.didClickOpen("不用回调")
//            self.viewModel.didClickOpen("你好").subscribe(onSuccess: { (text) in
//                print("callBack_succeed：%@",text)
//            }).disposed(by: self.disposeBag)
                        
            //响应
//            self.priceDispose?.dispose()
//            self.priceDispose = nil
//            self.priceDispose = self.viewModel.priceSpreadResponse.takeUntil(self.rx.deallocated).subscribe(onNext: { [weak self] (isOK) in
//                guard let `self` = self else { return }
//
//                print("监听priceTextFld的值2：")
//            })
//            self.viewModel.priceSpreadSubject.onNext(true)
            
            
        }).disposed(by: self.disposeBag)
        
        
        
        //响应
//        self.viewModel.priceSpreadResponse.subscribe(onNext: { [weak self] (isOK) in
//            guard let `self` = self else { return }
//
//            print("监听priceTextFld的值1：")
//        }).disposed(by: self.disposeBag)
        #endif
        
        #if false
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
        #endif
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
