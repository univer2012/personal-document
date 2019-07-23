# 50、结合Moya使用2：结果处理、模型转换
## 三、将结果转为 JSON 对象
### 1，实现方法
（1）如果服务器返回的数据是 `json` 格式的话，直接通过 `Moya` 提供的 `mapJSON` 方法即可将其转成 `JSON` 对象。

注意：关于 `DouBanProvider` 里的具体内容，可以参考上文（[点击查看](https://link.jianshu.com/?t=http%3A%2F%2Fwww.hangge.com%2Fblog%2Fcache%2Fdetail_2012.html)）。

```
import UIKit

import RxSwift
import RxCocoa

import Moya

class SHRxswift_20ViewController: UIViewController {
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //获取数据
        DouBanProvider.rx.request(.channels)
            .subscribe(onSuccess: { (response) in
                let json = try? response.mapJSON() as! [String: Any]
                print("--- 请求成功！返回的如下数据 ---")
                print(json!)
            }) { (error) in
                print("数据请求失败!错误原因：", error)
            }
            .disposed(by: disposeBag)
    }
}
```
（2）或者使用下面这种写法也是可以的。
```
import UIKit

import RxSwift
import RxCocoa

import Moya

class SHRxswift_20ViewController: UIViewController {
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //获取数据
        DouBanProvider.rx.request(.channels)
        .mapJSON()
            .subscribe(onSuccess: { (data) in
                let json = data as! [String: Any]
                print("--- 请求成功！返回的如下数据 ---")
                print(json)
            }) { (error) in
                print("数据请求失败!错误原因：", error)
            }.disposed(by: disposeBag)
    }
}
```
（3）运行结果如下：
![](https://raw.githubusercontent.com/univer2012/personal-document/master/Pictures/2019/Rxswift/Rx_50_1.png)

### 2，使用样例
（1）效果图

* 我们使用 `Moya` 调用豆瓣 `FM` 的 `API` 接口，获取所有的频道列表并显示在表格中。
* 点击任意一个频道，调用另一个接口随机获取该频道下的一首歌曲，并弹出显示。

（2）样例代码
