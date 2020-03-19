//
//  SGH1214BookmarksViewController.swift
//  SwiftDemo160801
//
//  Created by huangaengoln on 2016/12/14.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

import UIKit

class SGH1214BookmarksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {

    var tableView : UITableView?
    var titlesArray: [[String:String]] = {
        
        var array = [
            
            ["d1": "1、iOS 界面动画教程之 Layer 动画进阶"],
            ["d2": "2、iOS 界面动画教程之与视图相关的动画"],
            ["d3": "3、iOS 界面动画教程之 Layer 动画基础"],
            ["d4": "4、iOS 界面动画教程之自动布局"],
            ["d5": "5、自定义PageControl"],
            ["d6": "6、尝试面向轨道编程"],
            ["d7": "7、Auto Layout 使用心得"],
            ["d8": "8、面向协议编程与 Cocoa 的邂逅 (下)"],
            ["d9": "9、架构师之泛型应用分析介绍"],
            ["d10": "10、UICollectionViewCell Auto Sizing(自适应高度)"],
        ]
        if #available(iOS 13.0, *) {
            array.append(["d11": "11、NFC_passport"])
        }
        array.append(["d12": "12、TableView的字母索引"])
        array.append(["d13": "13、FileManager实例"])
        
        return array
    }()
    private func getController(with key:String) -> UIViewController {
        switch key {
        case "d1":
            return SGH160802ViewController()
        case "d2":
            return SGH0804ViewController()
        case "d3":
            return SGH160811ViewController()
        case "d4":
            return SGH160818AutoLayoutViewController()
        case "d5":
            return SGH1208CustomPageControlViewController()
        case "d6":
            return SGH1213TrackProgramViewController()
        case "d7":
            return SGH1214AutolayoutViewController()
        case "d8":
            return SGH1222POPAndCocoaViewController()
        case "d9":
            return DreamGenericViewController()
        case "d10":
            return SGH1901AutoSizingViewController()
        case "d11":
            if #available(iOS 13.0, *) {
                return SHNFCPassportViewController()
            }
            
        case "d12":
            return SHWordIndexViewController()
        case "d13":
            return SHFileManagerDemoVC()
        default:
            break
        }
        return UIViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //[self.navigationItemsetHidesBackButton:YES];
        self.title = "Bookmarks"
        //设置滑动返回
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
//        //自定义后退按钮的文字和颜色(这代码写在push前的控制器里才有效)
//        let backBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(p_navigationBack))
//        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        p_initView()
    }
    func p_initView() {
        //初始化tableView的数据
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        //设置tableView的数据源
        self.tableView!.dataSource = self
        //设置tableView的委托
        self.tableView!.delegate = self
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //UITableViewDataSource
    
    //总行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titlesArray.count
    }
    
    //加载数据
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        let row = indexPath.row as Int
        cell.textLabel?.text = self.titlesArray[row].values.first
        return cell
    }
    
    
    ///UITableViewDelegate
    //选择一行
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let key = self.titlesArray[indexPath.row].keys.first {
            
            let viewController = getController(with: key)
            viewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
    }
}
