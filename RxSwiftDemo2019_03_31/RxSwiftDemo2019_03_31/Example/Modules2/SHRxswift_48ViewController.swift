//
//  SHRxswift_48ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by 远平 on 2019/11/6.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxAlamofire
import Alamofire

class SHRxswift_48ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //指定下载路径（文件名不变）
        let destination: DownloadRequest.DownloadFileDestination = {_, response in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            print("documentsURL:",documentsURL)
            let fileURL = documentsURL.appendingPathComponent(response.suggestedFilename!)
            //两个参数表示如果有同名文件则会覆盖，如果路径中文件夹不存在则会自动创建
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        //需要下载的文件
        let fileURL = URL(string: "http://www.hangge.com/blog/images/logo.png")!
        
        //开始下载
        download(URLRequest(url: fileURL), to: destination).subscribe(onNext: { (element) in
            print("开始下载。")
        }, onError: { (error) in
            print("下载失败！失败原因：\(error)")
        }, onCompleted: {
            print("下载完毕")
        }).disposed(by: disposeBag)
        
    }
    
}






////指定下载路径（文件名不变）
//let destination: DownloadRequest.DownloadFileDestination = {_, response in
//    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//    let fileURL = documentsURL.appendingPathComponent(response.suggestedFilename!)
//    //两个参数表示如果有同名文件则会覆盖，如果路径中文件夹不存在则会自动创建
//    return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
//}
//
////需要下载的文件
//let fileURL = URL(string: "http://www.hangge.com/blog/images/logo.png")!
//
////开始下载
//download(URLRequest(url: fileURL), to: destination).subscribe(onNext: { (element) in
//    print("开始下载。")
//}, onError: { (error) in
//    print("下载失败！失败原因：\(error)")
//}, onCompleted: {
//    print("下载完毕")
//}).disposed(by: disposeBag)

