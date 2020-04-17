



### 类比1

SHRxswift_3ViewController.swift`的代码：


```swift
import UIKit

import RxSwift
import RxCocoa

class SHRxswift_3ViewController: SHBaseTableViewController {
		let viewModel = SHRxswift_3ViewModel()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.priceTextFld.frame = CGRect(x: 0, y: 200, width: self.view.frame.size.width, height: 50)
        self.priceTextFld.backgroundColor = UIColor.gray
        self.view.addSubview(priceTextFld)
        
        self.observer = self.viewModel.didClickOpen("").asObservable()
        
        observer?.subscribe(onNext: { (text) in
            print("callBack_succeed_observer：\(text)__OK")
        }).disposed(by: self.disposeBag)
      
    }
	
}
```



`SHRxswift_3ViewModel.swift`代码：

```swift
import UIKit
import RxSwift

class SHRxswift_3ViewModel: NSObject {
    
    let disposeBag = DisposeBag()
    
    
    func didClickOpen(_ text: String) -> Single<String> {
        print("执行操作:\(text)__success")
        
        
        return Single.create { (singleFunc) -> Disposable in
            singleFunc(.success("OK"))
            
            return Disposables.create()
        }
    }
    
    override init() {
        super.init()
    }   
}
```



这代码相当于RAC中的如下代码：

```
excute:@""]subscribe(onNext:)];
```

通知执行相关操作，并返回回调。



第2个:

```swift
let _ = self.viewModel.didClickOpen("不用回调")
```

相当于RAC中的：

```objc
[self.xxxCommand excute:nil];
```

也就是直接通知执行，不需要回调。





