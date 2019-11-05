//
//  SHRxswift_47ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by 远平 on 2019/11/5.
//  Copyright © 2019 远平. All rights reserved.
//

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
        .bind(to: progressView.rx.progress)     //将进度绑定UIProgressView上
        .disposed(by: disposeBag)
        
    }

}


////需要上传的文件路径
//let fileURL = Bundle.main.url(forResource: "hangge", withExtension: "zip")
////服务器路径
//let uploadURL = URL(string: "http://www.hangge.com/upload.php")!
//
////将文件上传到服务器
//upload(fileURL!, urlRequest: try! urlRequest(.post, uploadURL)).subscribe(onNext: { (element) in
//    print("--- 开始上传 ---")
//    element.uploadProgress(closure: { (progress) in
//        print("当前进度：\(progress.fractionCompleted)")
//        print(" 已上传载：\(progress.completedUnitCount / 1024)KB")
//        print(" 总大小：\(progress.totalUnitCount / 1024)KB")
//    })
//}, onError: { (error) in
//    print("上传失败！失败原因：\(error)")
//}, onCompleted: {
//    print("上传完毕！")
//}).disposed(by: disposeBag)



////需要上传的文件路径
//let fileURL = Bundle.main.url(forResource: "hangge", withExtension: "zip")
////服务器路径
//let uploadURL = URL(string: "http://www.hangge.com/upload.php")!
//
////将文件上传到服务器
//upload(fileURL!, urlRequest: try! urlRequest(.post, uploadURL)).subscribe(onCompleted: {
//
//    print("上传完毕！")
//}).disposed(by: disposeBag)
