//
//  SHRxswift_4ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by rrd on 2019/6/17.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class SHRxswift_4ViewController: UIViewController {
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let infiniteInterval$ = Observable<Int>
            .interval(0.1, scheduler: MainScheduler.instance)
            .do(onNext: {print("infinite$: \($0)")},
                onSubscribe: {print("开始订阅 infinite$")},
                onDispose: {print("销毁 infinite$")})
        
        let limited$ = Observable<Int>
            .interval(0.5, scheduler: MainScheduler.instance)
            .take(2)
            .do(onNext: {print("limited$: \($0)")},
                onSubscribe: {print("开始订阅 limited$")},
                onDispose: {print("销毁 limited$")})
        
        let o: Observable<Int> = Observable.using({ () -> AnyDisposable in
            return AnyDisposable(infiniteInterval$.subscribe())
        }, observableFactory: {_ in return limited$})
        o.subscribe()
    }
}
class AnyDisposable: Disposable {
    let _dispose: () -> Void
    init(_ disposable: Disposable) {
        _dispose = disposable.dispose
    }
    func dispose() {
        _dispose()
    }
}
