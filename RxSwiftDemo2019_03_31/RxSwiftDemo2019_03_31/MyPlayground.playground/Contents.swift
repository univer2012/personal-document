import UIKit

import RxSwift
import RxCocoa
import RxAtomic
//添加playground的库
import PlaygroundSupport
//设置实时变异，会显示在右边
PlaygroundPage.current.needsIndefiniteExecution = true


//var str = "Hello, playground"

let publicSubject = PublishSubject<String>()
publicSubject.subscribe({ (event) in
    print(event.element!)
}).dispose()

publicSubject.onNext("hello")
publicSubject.onNext("world")




