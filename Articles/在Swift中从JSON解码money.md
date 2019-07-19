# 在Swift中从JSON解码money

来自：[Decoding money from JSON in Swift](https://medium.com/wultra-blog/decoding-money-from-json-in-swift-d61a3fcf6404)

尽管看起来简单而琐碎，但在Swift中处理money——尤其是amount部分——可能是一件非常麻烦的事情。

假设我们在Swift中为我们正在开发的货币汇率app分配了这个简单的任务:

**将事务量从JSON反序列化为Swift结构**
![This is JSON that comes from your API](https://raw.githubusercontent.com/univer2012/personal-document/master/Pictures/2019/Decoding%20money%20from%20JSON%20in%20Swift_1.png)

## Easy!
这应该是2分钟的代码。让我们打开Xcode并编写概念证明。
```
import UIKit
import PlaygroundSupport

struct Money: Codable {
    let amount: Double
    let currency: String
}
let json = "{\"amount\": 128.8,\"currency\": \"EUR\"}"
let jsonData = json.data(using: .utf8)!

let decoder = JSONDecoder()

let money = try! decoder.decode(Money.self, from: jsonData)

money.amount
money.currency
```
![This is JSON that comes from your API](https://raw.githubusercontent.com/univer2012/personal-document/master/Pictures/2019/Decoding%20money%20from%20JSON%20in%20Swift_2.png)

## 那么问题来了
每个QA工程师都知道，输入字段是每个app中最常见的低挂起bug的来源。

让我们试着把欧元兑换成[巴林第纳尔](https://en.wikipedia.org/wiki/Bahraini_dinar)，他说。




