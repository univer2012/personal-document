//
//  SHRxswift_3ViewModel.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2019/12/22.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit
import RxSwift

class SHRxswift_3ViewModel: NSObject {
    
    let disposeBag = DisposeBag()
    
    var priceSpreadSubject = PublishSubject<Bool>()
    var priceSpreadResponse = PublishSubject<Bool>()
    
    func didClickOpen(_ text: String) -> Single<String> {
        print("执行操作:%@",text)
        
        
        return Single.create { (singleFunc) -> Disposable in
            singleFunc(.success("OK"))
            
            return Disposables.create()
        }
    }
    
    override init() {
        super.init()
        self.priceSpreadSubject.subscribe(onNext: { [weak self] (isOK) in
            guard let `self` = self else { return }
            
            print("执行代码")
            self.priceSpreadResponse.onNext(true)
        }).disposed(by: self.disposeBag)
    }
    
    
}
