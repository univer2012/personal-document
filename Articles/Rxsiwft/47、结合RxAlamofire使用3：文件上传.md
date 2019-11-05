## 六、文件上传
### 1，支持的上传类型
`Alamofire` 支持如下上传类型，使用 `RxAlamofire` 也是一样的：

* `File`
* `Data`
* `Stream`
* `MultipartFormData`

### 2，使用文件流的形式上传文件
```swift
//需要上传的文件路径
let fileURL = Bundle.main.url(forResource: "hangge", withExtension: "zip")
//服务器路径
let uploadURL = URL(string: "http://www.hangge.com/upload.php")!

//将文件上传到服务器
upload(fileURL!, urlRequest: try! urlRequest(.post, uploadURL)).subscribe(onCompleted: {
    
    print("上传完毕！")
}).disposed(by: disposeBag)
```

附：服务端代码（`upload.php`）
```php
<?php 
/** php 接收流文件
* @param  String  $file 接收后保存的文件名
* @return boolean
*/ 
function receiveStreamFile($receiveFile){   
    $streamData = isset($GLOBALS['HTTP_RAW_POST_DATA'])? $GLOBALS['HTTP_RAW_POST_DATA'] : ''; 
   
    if(empty($streamData)){ 
        $streamData = file_get_contents('php://input'); 
    } 
   
    if($streamData!=''){ 
        $ret = file_put_contents($receiveFile, $streamData, true); 
    }else{ 
        $ret = false; 
    } 
  
    return $ret;   
} 
 
//定义服务器存储路径和文件名
$receiveFile =  $_SERVER["DOCUMENT_ROOT"]."/uploadFiles/hangge.zip"; 
$ret = receiveStreamFile($receiveFile); 
echo json_encode(array('success'=>(bool)$ret)); 
?>
```

> 如何在上传时附带上文件名？
>  有时我们在文件上传的同时还会想要附带一些其它参数，比如文件名。这样服务端接收到文件后，就可以根据我们传过来的文件名来保存。实现这个其实很简单，客户端和服务端分别做如下修改。
>
> - 客户端：将文件名以参数的形式跟在链接后面。比如：[http://hangge.com/upload.php?fileName=image1.png](https://link.jianshu.com?t=http%3A%2F%2Fhangge.com%2Fupload.php%3FfileName%3Dimage1.png) 
> - 服务端：通过 `$_GET["fileName"]`得到这个参数，并用其作为文件名保存。

### 3，获得上传进度

（1）下面代码在文件上传过程中会不断地打印当前进度、已上传部分的大小、以及文件总大小（单位都是字节）。

![img](https:////upload-images.jianshu.io/upload_images/3788243-3ff33b73a8bb378d.png?imageMogr2/auto-orient/strip|imageView2/2/w/299)

```swift
//需要上传的文件路径
let fileURL = Bundle.main.url(forResource: "hangge", withExtension: "zip")
//服务器路径
let uploadURL = URL(string: "http://www.hangge.com/upload.php")!

//将文件上传到服务器
upload(fileURL!, urlRequest: try! urlRequest(.post, uploadURL)).subscribe(onNext: { (element) in
    print("--- 开始上传 ---")
    element.uploadProgress(closure: { (progress) in
        print("当前进度：\(progress.fractionCompleted)")
        print(" 已上传载：\(progress.completedUnitCount / 1024)KB")
        print(" 总大小：\(progress.totalUnitCount / 1024)KB")
    })
}, onError: { (error) in
    print("上传失败！失败原因：\(error)")
}, onCompleted: {
    print("上传完毕！")
}).disposed(by: disposeBag)
```



（2）下面我换种写法，将进度转成可观察序列，并绑定到进度条上显示。

![img](https:////upload-images.jianshu.io/upload_images/3788243-bfd0fc987447168b.png?imageMogr2/auto-orient/strip|imageView2/2/w/320)

```swift
import UIKit
import RxSwift
import RxCocoa
import RxAlamofire

class SHRxswift_47ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //需要上传的文件路径
        let fileURL = Bundle.main.url(forResource: "hangge", withExtension: "zip")
        //服务器路径
        let uploadURL = URL(string: "http://www.hangge.com/upload.php")!

        //将文件上传到服务器
        upload(fileURL!, urlRequest: try! urlRequest(.post, uploadURL)).map{request in
            //返回一个关于进度的可观察序列
            Observable<Float>.create{observer in
                request.uploadProgress(closure: { (progress) in
                    observer.onNext(Float(progress.fractionCompleted))
                    if progress.isFinished {
                        observer.onCompleted()
                    }
                })
                return Disposables.create()
            }
        }
        .flatMap{$0}
        .bind(to: progressView.rx.progress)		//将进度绑定UIProgressView上
        .disposed(by: disposeBag)
        
    }

}
```

