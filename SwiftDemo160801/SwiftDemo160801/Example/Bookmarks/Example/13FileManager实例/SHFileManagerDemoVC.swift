//
//  SHFileManagerDemoVC.swift
//  SwiftDemo160801
//
//  Created by 远平 on 2019/11/15.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

import UIKit

class SHFileManagerDemoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // 1.获取路径操作代码
        
        // 沙盒下有三个目录 分别是Documents/Library/tmp 通常我们将文件放到Documents下
        // 获取document的文件夹路径
        var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let pathDocuments = path[0]
        print(pathDocuments)
        
        // 2. 创建文件操作
        let file1 = "file1.txt"
        let file2 = "file2.txt"
        let file1Path: String = NSString(format: "%@/%@", pathDocuments,file1) as String//生成一个绝对路径
        let file2Path: String = NSString(format: "%@/%@", pathDocuments,file2) as String//生成一个绝对路径
        // 进行file1文件生成操作
        if FileManager.default.fileExists(atPath: file1Path as String){
            print("文件已存在")
        }else{
            let data = "Hello world By Swift2.0 file1".data(using: String.Encoding.utf8)//.data(usingEncoding: NSUTF8StringEncoding)
            FileManager.default.createFile(atPath: file1Path, contents: data, attributes: nil)//创建新文件 //当然也有直接向已存在文件中写入内容的方法
        }
        // 进行file2文件生成操作
        if FileManager.default.fileExists(atPath: file2Path as String){
            print("文件已存在")
        }else{
            let data = "Hello world By Swift2.0 file2".data(using: String.Encoding.utf8)//.data(usingEncoding: NSUTF8StringEncoding)
            FileManager.default.createFile(atPath: file2Path, contents: data, attributes: nil)//创建新文件 //当然也有直接向已存在文件中写入内容的方法
        }
        
        // 3.删除文件 将原先的创建的删除
        let deletePath = NSString(format: "%@/%@", pathDocuments,file1) as String
        print("要删除的文件路径:\(deletePath)")
        do{
            try FileManager.default.removeItem(atPath: deletePath)
        }catch let error as NSError{
            print("error is \(error)")
        }
        
        // 以下内容只做拓展
        /*
         var arrayContent = NSArray(contentsOfFile: filePath)//必须是完整路径
         var dictContent = NSDictionary(contentsOfFile: filePath)
         var imgContent = UIImage(contentsOfFile: filePath)
         */
        
        // 4.获取文件信息
        // 文件属性 是一个字典类型
        let attrFile1 = try? FileManager.default.attributesOfItem(atPath: file1Path)
        let attrFile2 = try? FileManager.default.attributesOfItem(atPath: file2Path)
        print(attrFile1)//打印nil 因为file1不存在
        print(attrFile2)//打印出信息
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
