//
//  SH190617BookmarksViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by rrd on 2019/6/17.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit
import RxSwift

import SnapKit

struct SH190617BookmarksViewModel {
    let titles = [
        "1基本介绍、安装配置",
        "2响应式编程与传统式编程的比较样例",
        "3Observable介绍、创建可观察序列",
        "4Observable订阅、事件监听、订阅销毁",
        "5UITextView",
        "6UIButton",
        "7UISwitch 与 UISegmentedControl",
        "8双向绑定<->",
        "9UIGestureRecognizer",
        "10UITableView"]
    let controllers = [
        SHRxswift_1ViewController(),
        SHRxswift_2ViewController(),
        SHRxswift_3ViewController(),
        UIStoryboard(name: "Bookmark", bundle: Bundle(for: SHRxswift_4ViewController.self)).instantiateViewController(withIdentifier: "SHRxswift_4ViewController"),
        UIStoryboard(name: "Bookmark", bundle: Bundle(for: SHRxswift_5ViewController.self)).instantiateViewController(withIdentifier: "SHRxswift_5ViewController"),
        UIStoryboard(name: "Bookmark", bundle: Bundle(for: SHRxswift_6ViewController.self)).instantiateViewController(withIdentifier: "SHRxswift_6ViewController"),
        UIStoryboard(name: "Bookmark", bundle: Bundle(for: SHRxswift_7ViewController.self)).instantiateViewController(withIdentifier: "SHRxswift_7ViewController"),
        UIStoryboard(name: "Bookmark", bundle: Bundle(for: SHRxswift_8ViewController.self)).instantiateViewController(withIdentifier: "SHRxswift_8ViewController"),
        //UIStoryboard(name: "Bookmark", bundle: Bundle(for: SHRxswift_9ViewController.self)).instantiateViewController(withIdentifier: "SHRxswift_9ViewController"),
        SHRxswift_9ViewController(),
        UIStoryboard(name: "Bookmark", bundle: Bundle(for: SHRxswift_10ViewController.self)).instantiateViewController(withIdentifier: "SHRxswift_10ViewController"),
    ]
}



class SH190617BookmarksViewController: UIViewController,UIGestureRecognizerDelegate {
    var tableView : UITableView?
    
    let bookmarksViewModel = SH190617BookmarksViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Bookmarks"
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

        // Do any additional setup after loading the view.
    }
}

extension SH190617BookmarksViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarksViewModel.titles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookmarksCell", for:indexPath)
        cell.textLabel?.text = bookmarksViewModel.titles[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        return cell
    }
}
extension SH190617BookmarksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = bookmarksViewModel.controllers[indexPath.row]
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
