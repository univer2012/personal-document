在之前的两篇文章中，我介绍了 `RxSwift` 对 `URLSession` 的扩展以及使用。当然除了可以使用 `URLSession` 进行网络请求外，网上还有许多优秀的第三方网络库也可以与 `RxSwift` 结合使用的，比如：`RxAlamofire` 和 `Moya`。这次我先介绍下前者。

## 一 、安装配置

### 1，引入 Alamofire

由于 `RxAlamofire` 是对 `Alamofire` 的封装，所以我们项目中先要把 `Alamofire` 库给引入进来。关于 `Alamofire` 的安装配置可以参考航哥之前的文章：

- [Swift - HTTP网络操作库Alamofire使用详解1（配置，以及数据请求）](https://link.jianshu.com?t=https%3A%2F%2Fwww.hangge.com%2Fblog%2Fcache%2Fdetail_970.html)

### 2，添加 RxAlamofire

（1）这里我使用手动配置的方式，先把 `RxAlamofire` 库下载到本地。

- Github 主页：[https://github.com/RxSwiftCommunity/RxAlamofire](https://link.jianshu.com?t=https%3A%2F%2Fgithub.com%2FRxSwiftCommunity%2FRxAlamofire) 

（2）接着把里面的 `RxAlamofire.swift` 文件添加到我们的项目中即可。

![img](https:////upload-images.jianshu.io/upload_images/3788243-5af30fb74ba61cd4.png?imageMogr2/auto-orient/strip|imageView2/2/w/267)

## 二、基本用法

### 1，使用 request 请求数据

（1）下面代码我们通过豆瓣提供的频道列表接口获取数据，并将返回结果输出到控制台中。

```
返回的数据时： {"channels":[{"name_en":"Personal Radio","seq_id":0,"abbr_en":"My","name":"私人兆赫","channel_id":0},{"name":"华语","seq_id":0,"abbr_en":"","channel_id":"1","name_en":""},{"name":"欧美","seq_id":1,"abbr_en":"","channel_id":"2","name_en":""},{"name":"七零","seq_id":2,"abbr_en":"","channel_id":"3","name_en":""},{"name":"八零","seq_id":3,"abbr_en":"","channel_id":"4","name_en":""},{"name":"九零","seq_id":4,"abbr_en":"","channel_id":"5","name_en":""},{"name":"粤语","seq_id":5,"abbr_en":"","channel_id":"6","name_en":""},
//... ...
```



```swift
//创建URL对象
let urlString = "https://www.douban.com/j/app/radio/channels"
let url = URL(string: urlString)!

//创建并发起请求
request(.get, url).data().subscribe(onNext: { (data) in
    //数据处理
    let str = String(data: data, encoding: String.Encoding.utf8)
    print("返回的数据时：",str ?? "")
}).disposed(by: disposeBag)
```



（2）如果还**要处理失败的情况，可以在 `onError` 回调中操作**。我们把 `url` 改成一个错误的地址，运行结果如下：

```
请求失败！错误原因： responseValidationFailed(reason: Alamofire.AFError.ResponseValidationFailureReason.unacceptableStatusCode(code: 404))
```



```rust
//创建URL对象
let urlString = "https://www.douban.com/xxxxx/app/radio/channels"
let url = URL(string: urlString)!

//创建并发起请求
request(.get, url).data().subscribe(onNext: { (data) in
    //数据处理
    let str = String(data: data, encoding: String.Encoding.utf8)
    print("返回的数据时：",str ?? "")
},onError: { error in
    print("请求失败！错误原因：",error)
}).disposed(by: disposeBag)
```

### 2，使用 requestData 请求数据

（1）下面代码同样是获取豆瓣频道数据，并将返回结果输出到控制台中。

```swift
//创建URL对象
let urlString = "https://www.douban.com/j/app/radio/channels"
let url = URL(string: urlString)!

//创建并发起请求
requestData(.get, url).subscribe(onNext: { (response, data) in
    //数据处理
    let str = String(data: data, encoding: String.Encoding.utf8)
    print("返回的数据时：",str ?? "")
}).disposed(by: disposeBag)
```

2）使用 `requestData` 的话，不管请求成功与否都会进入到 `onNext` 这个回调中。如果我们想要根据响应状态进行一些相应操作，通过 `response` 参数即可实现。

```swift
//创建URL对象
let urlString = "https://www.douban.com/jxxxxxxx/app/radio/channels"
let url = URL(string:urlString)!
 
//创建并发起请求
requestData(.get, url).subscribe(onNext: {
    response, data in
    //判断响应结果状态码
    if 200 ..< 300 ~= response.statusCode {
        let str = String(data: data, encoding: String.Encoding.utf8)
        print("请求成功！返回的数据是：", str ?? "")
    }else{
        print("请求失败！")
    }
}).disposed(by: disposeBag)
```

### 3，获取 String 类型数据

（1）如果请求的数据是字符串类型的，**我们可以在 `request` 请求时直接通过 `responseString()`方法实现自动转换，省的在回调中还要手动将 `data` 转为 `string`。**

![img](https:////upload-images.jianshu.io/upload_images/3788243-82c386d96d1fa6c6.png?imageMogr2/auto-orient/strip|imageView2/2/w/541)

```csharp
//创建URL对象
let urlString = "https://www.douban.com/j/app/radio/channels"
let url = URL(string:urlString)!
 
//创建并发起请求
request(.get, url)
    .responseString()
    .subscribe(onNext: {
        response, data in
        //数据处理
        print("返回的数据是：", data)
    }).disposed(by: disposeBag)
```