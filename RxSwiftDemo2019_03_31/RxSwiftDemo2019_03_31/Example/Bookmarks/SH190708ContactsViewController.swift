//
//  SH190708ContactsViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by rrd on 2019/7/8.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit

import RxSwift

import SnapKit


class SH190708ContactsViewController: UIViewController, UIGestureRecognizerDelegate {
    
    let titlesArray: [[String: String]] = [
        ["d1": "1基本介绍、安装配置"],
        ["d2": "2响应式编程与传统式编程的比较样例"],
        ["d3": "3Observable介绍、创建可观察序列"],
        ["d4": "4Observable订阅、事件监听、订阅销毁"],
        ["d5": "5UITextView"],
        ["d6": "6UIButton"],
        ["d7": "7UISwitch 与 UISegmentedControl"],
        ["d8": "8双向绑定<->"],
        ["d9": "9UIGestureRecognizer"],
        ["d10": "10UITableView"],
        ["d11": "11可编辑表格"],
        ["d12": "12不同单元格混用"],
        ["d13": "13tableView 样式修改"],
        ["d14": "1UICollectionView"],
        ["d15": "2刷新集合数据"],
        ["d16": "3pickView"],
        ["d17": "4weak_unowned"],
        ["d18": "5URLSession结果处理、模型转换"],
        ["d19": "6结合RxAlamofire使用"],
        ["d20": "7结合Moya使用"],
        ["d21": "使用详解43（URLSession的使用1：请求数据）"],
        ["d22": "使用详解44（URLSession的使用2：结果处理、模型转换）"],
        ["d23": "使用详解45（结合RxAlamofire使用1：数据请求）"],
        ["d24": "使用详解46（结合RxAlamofire使用2：结果处理、模型转换）"],
        ["d25": "使用详解47（结合RxAlamofire使用3：文件上传）"],
        ["d26": "使用详解48（结合RxAlamofire使用4：文件下载）"],
        ["d27": "使用详解49（结合Moya使用1：数据请求）"],
        ["d28": "使用详解50（结合Moya使用2：结果处理、模型转换）"],
        ["d29": "使用详解52（MVVM架构演示2：使用Observable样例）"],
        ["d30": "使用详解53（MVVM架构演示3：使用Driver样例）"],
        ["d31": "使用详解54（一个用户注册样例1：基本功能实现）"],
        ["d32": "使用详解55（一个用户注册样例2：显示网络请求活动指示器）"],
        ["d33": "使用详解56（结合MJRefresh使用1：下拉刷新）"],
        ["d34": "使用详解57（结合MJRefresh使用2：上拉加载、以及上下拉组合）"],
        ["d35": "使用详解58（DelegateProxy样例1：获取地理定位信息 ）"],
        ["d36": "使用详解59（DelegateProxy样例2：图片选择功能 ）"],
        ["d37": "使用详解60（DelegateProxy样例3：应用生命周期的状态变化）"],
        ["d38": "使用详解61（sendMessage和methodInvoked的区别）"],
        ["d39": "使用详解62 (订阅UITableViewCell里的按钮点击事件)"],
        ["d40": "使用详解63 (通知NotificationCenter的使用)"],
        ["d41": "使用详解64（键值观察KVO的使用）"],
    ]
    
    
    
    private func getController(with key:String) -> UIViewController {
        switch key {
        case "d1":
            return storyboard(with: "SHRxswift_1ViewController")
        case "d2":
            return SHRxswift_2ViewController()
        case "d3":
            return SHRxswift_3ViewController()
        case "d4":
            return storyboard(with: "SHRxswift_4ViewController")
        case "d5":
            return storyboard(with: "SHRxswift_5ViewController")
        case "d6":
            return storyboard(with: "SHRxswift_6ViewController")
        case "d7":
            return storyboard(with: "SHRxswift_7ViewController")
        case "d8":
            return storyboard(with: "SHRxswift_8ViewController")
        case "d9":
            return SHRxswift_9ViewController()
        case "d10":
            return storyboard(with: "SHRxswift_10ViewController")
        case "d11":
            return storyboard(with: "SHRxswift_11ViewController")
        case "d12":
            return storyboard(with: "SHRxswift_12ViewController")
        case "d13":
            return SHRxswift_13ViewController()
        case "d14":
            return SHRxswift_14ViewController()
        case "d15":
            return storyboard(with: "SHRxswift_15ViewController")
        case "d16":
            return SHRxswift_16ViewController()
        case "d17":
            return storyboard(with: "SHRxswift_17ViewController")
        case "d18":
            return SHRxswift_18ViewController()
        case "d19":
            return SHRxswift_19ViewController()
        case "d20":
            return SHRxswift_20ViewController()
        case "d21":
            return storyboard(with: "SHRxswift_43ViewController")
        case "d22":
            return SHRxswift_44ViewController()
        case "d23":
            return storyboard(with: "SHRxswift_45ViewController")
        case "d24":
            return SHRxswift_46ViewController()
        case "d25":
            return storyboard(with: "SHRxswift_47ViewController")
        case "d26":
            return storyboard(with: "SHRxswift_48ViewController")
        case "d27":
            return SHRxswift_49ViewController()
        case "d28":
            return SHRxswift_50ViewController()
        case "d29":
            return SHRxswift_52GithubViewController()
        case "d30":
            return SHRxswift_53GithubViewController()
        case "d31":
            return storyboard(with: "SHRxswift_54ViewController")
        case "d32":
            return storyboard(with: "SHRxswift_55ViewController")
        case "d33":
            return SHRxswift_56ViewController()
        case "d34":
            return SHRxswift_57ViewController()
        case "d35":
        return storyboard(with: "SHRxswift_58ViewController")
        case "d36":
            return storyboard(with: "SHRxswift_59ViewController")
        case "d37":
            return SHRxswift_60ViewController()
        case "d38":
            return SHRxswift_61ViewController()
        case "d39":
            return SHRxswift_62ViewController()
        case "d40":
            return SHRxswift_63ViewController()
        case "d41":
            return SHRxswift_64ViewController()
        default:
            break
        }
        return UIViewController()
    }
    
    private func storyboard(with classStr: String) -> UIViewController {
        if let cl = NSClassFromString(classStr) {
            return UIStoryboard(name: "Bookmark", bundle: Bundle(for: cl)).instantiateViewController(withIdentifier: classStr)
        }
        return UIViewController()
    }
    
    
    
    var tableView : UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "RxSwift Demo"
        //设置滑动返回
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        //初始化tableView的数据
        self.tableView = UITableView(frame: CGRect.zero, style: .plain)
        //设置tableView的数据源
        self.tableView!.dataSource = self
        //设置tableView的委托
        self.tableView!.delegate = self
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "bookmarksCell")
        self.view.addSubview(self.tableView!)
        self.tableView!.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
    }
    
}




extension SH190708ContactsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titlesArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookmarksCell", for:indexPath)
        cell.textLabel?.text = titlesArray[indexPath.row].values.first
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        return cell
    }
}
extension SH190708ContactsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let key = self.titlesArray[indexPath.row].keys.first {
            
            let viewController = getController(with: key)
            viewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
