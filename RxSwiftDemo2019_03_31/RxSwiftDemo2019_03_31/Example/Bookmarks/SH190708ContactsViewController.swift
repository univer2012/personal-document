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

class SGHCellModel: NSObject {
    var title: String = ""
    var className: String = ""
    
    init(title: String, className: String) {
        self.title = title
        self.className = className
    }
    
    override convenience init() {
        self.init(title:"", className: "")
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



class SH190708ContactsViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var tableView : UITableView?
    var dataArray = [[SGHCellModel]]()
    var sectionTitle = [String]()
    
    var inStoryboardVCArray: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "RxSwift Demo"
        //设置滑动返回
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        self.tableView = {
            //初始化tableView的数据
            let tableV = UITableView(frame: CGRect.zero, style: .plain)
            //设置tableView的数据源
            tableV.dataSource = self
            //设置tableView的委托
            tableV.delegate = self
            tableV.register(UITableViewCell.self, forCellReuseIdentifier: "bookmarksCell")
            self.view.addSubview(tableV)
            return tableV
        }()
        self.tableView!.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        //section 1
        let tempTitleArray = [
            "1基本介绍、安装配置",
            "2响应式编程与传统式编程的比较样例",
            "3Observable介绍、创建可观察序列",
            "4Observable订阅、事件监听、订阅销毁",
            "5UITextView",
            "6UIButton",
            "7UISwitch 与 UISegmentedControl",
            "8双向绑定<->",
            "9UIGestureRecognizer",
            "10UITableView",
            "11可编辑表格",
            "12不同单元格混用",
            "13tableView 样式修改",
            "1UICollectionView",
            "2刷新集合数据",
            "3pickView",
            "4weak_unowned",
            "5URLSession结果处理、模型转换",
            "6结合RxAlamofire使用",
            "7结合Moya使用",
            "使用详解43（URLSession的使用1：请求数据）",
            "使用详解44（URLSession的使用2：结果处理、模型转换）",
            "使用详解45（结合RxAlamofire使用1：数据请求）",
            "使用详解46（结合RxAlamofire使用2：结果处理、模型转换）",
            "使用详解47（结合RxAlamofire使用3：文件上传）",
            "使用详解48（结合RxAlamofire使用4：文件下载）",
            "使用详解49（结合Moya使用1：数据请求）",
            "使用详解50（结合Moya使用2：结果处理、模型转换）",
            "使用详解52（MVVM架构演示2：使用Observable样例）",
            "使用详解53（MVVM架构演示3：使用Driver样例）",
            "使用详解54（一个用户注册样例1：基本功能实现）",
            "使用详解55（一个用户注册样例2：显示网络请求活动指示器）",
            "使用详解56（结合MJRefresh使用1：下拉刷新）",
            "使用详解57（结合MJRefresh使用2：上拉加载、以及上下拉组合）",
            "使用详解58（DelegateProxy样例1：获取地理定位信息 ）",
            "使用详解59（DelegateProxy样例2：图片选择功能 ）",
            "使用详解60（DelegateProxy样例3：应用生命周期的状态变化）",
            "使用详解61（sendMessage和methodInvoked的区别）",
            "使用详解62 (订阅UITableViewCell里的按钮点击事件)",
            "使用详解63 (通知NotificationCenter的使用)",
            "使用详解64（键值观察KVO的使用）",
        ]
        let tempClassNameArray = [
            "SHRxswift_1ViewController",
            "SHRxswift_2ViewController",
            "SHRxswift_3ViewController",
            "SHRxswift_4ViewController",
            "SHRxswift_5ViewController",
            "SHRxswift_6ViewController",
            "SHRxswift_7ViewController",
            "SHRxswift_8ViewController",
            "SHRxswift_9ViewController",
            "SHRxswift_10ViewController",
            "SHRxswift_11ViewController",
            "SHRxswift_12ViewController",
            "SHRxswift_13ViewController",
            "SHRxswift_14ViewController",
            "SHRxswift_15ViewController",
            "SHRxswift_16ViewController",
            "SHRxswift_17ViewController",
            "SHRxswift_18ViewController",
            "SHRxswift_19ViewController",
            "SHRxswift_20ViewController",
            "SHRxswift_43ViewController",
            "SHRxswift_44ViewController",
            "SHRxswift_45ViewController",
            "SHRxswift_46ViewController",
            "SHRxswift_47ViewController",
            "SHRxswift_48ViewController",
            "SHRxswift_49ViewController",
            "SHRxswift_50ViewController",
            "SHRxswift_52ViewController",
            "SHRxswift_53ViewController",
            "SHRxswift_54ViewController",
            "SHRxswift_55ViewController",
            "SHRxswift_56ViewController",
            "SHRxswift_57ViewController",
            "SHRxswift_58ViewController",
            "SHRxswift_59ViewController",
            "SHRxswift_60ViewController",
            "SHRxswift_61ViewController",
            "SHRxswift_62ViewController",
            "SHRxswift_63ViewController",
            "SHRxswift_64ViewController",
        ]
        
        self.inStoryboardVCArray = [
            
            "SHRxswift_1ViewController",
            "SHRxswift_4ViewController",
            "SHRxswift_5ViewController",
            "SHRxswift_6ViewController",
            "SHRxswift_7ViewController",
            "SHRxswift_8ViewController",
            "SHRxswift_10ViewController",
            "SHRxswift_11ViewController",
            "SHRxswift_12ViewController",
            "SHRxswift_15ViewController",
            "SHRxswift_17ViewController",
            "SHRxswift_43ViewController",
            "SHRxswift_45ViewController",
            "SHRxswift_47ViewController",
            "SHRxswift_48ViewController",
            "SHRxswift_54ViewController",
            "SHRxswift_55ViewController",
            "SHRxswift_58ViewController",
            "SHRxswift_59ViewController",
        ]
        
        self.p_addSectionData(with: tempClassNameArray, titleArray: tempTitleArray, title: "Rxswift demo")
        
    }
    
    private func p_addSectionData(with classNameArray:[String], titleArray:[String],title:String) {
        var firstArray = [SGHCellModel]()
        for (idx,item) in classNameArray.enumerated() {
            let cellModel = SGHCellModel()
            cellModel.className = item
            cellModel.title = titleArray[idx]
            firstArray.append(cellModel)
        }
        
        self.addSection(with: title, sectionArray: firstArray)
    }
    
    private func addSection(with title:String, sectionArray: [SGHCellModel]) {
        self.dataArray.append(sectionArray)
        self.sectionTitle.append(title)
    }
    
}




extension SH190708ContactsViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionTitle[section]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookmarksCell", for:indexPath)
        let cellModel = self.dataArray[indexPath.section][indexPath.row]
        cell.textLabel?.text = cellModel.title
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        return cell
    }
}
extension SH190708ContactsViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cellModel = self.dataArray[indexPath.section][indexPath.row]
        let className = cellModel.className
        
        ///解决方案来自：[Swift 通过字符串 转换成对应的 UIViewController](https://www.jianshu.com/p/d5daa8485227)
        
        // 1.动态获取命名空间
        guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"]as? String else{
        return;
        }
        // 2.根据字符串获取对应的Class并转成控制器的类型
        if let cls = NSClassFromString(nameSpace + "." + className) as? UIViewController.Type {
            
            if inStoryboardVCArray?.contains(className) ?? false {
                
                let vc = UIStoryboard(name: "Bookmark", bundle: Bundle(for: cls)).instantiateViewController(withIdentifier: className)
                vc.title = cellModel.title
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
                
            } else {

                // 3.创建对应的控制器对象
                let vc: UIViewController = cls.init()
                vc.title = cellModel.title
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
        
    }
}
