## 六、文件上传
### 1，支持的上传类型
`Alamofire` 支持如下上传类型，使用 `RxAlamofire` 也是一样的：

* `File`
* `Data`
* `Stream`
* `MultipartFormData`

### 2，使用文件流的形式上传文件
```
//需要上传的文件路径
let fileURL = Bundle.main.url(forResource: "hangge", withExtension: "zip")
//服务器路径
let uploadURL = URL(string: "http://www.hangge.com/upload.php")!
//将文件上传到服务器
upload(fileURL!, urlRequest: try! urlRequest(.post, uploadURL))
    .subscribe(onCompleted: {
        print("上传完毕！")
    }).disposed(by: disposeBag)
```

附：服务端代码（`upload.php`）
```

```