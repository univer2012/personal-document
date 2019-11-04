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



struct SH190708ContactsViewModel {
    let titles = [
        "1UICollectionView",
        "2刷新集合数据",
        "3pickView",
        "4weak_unowned",
        "5URLSession结果处理、模型转换",
        "6结合RxAlamofire使用",
        "7结合Moya使用",
        "8Github搜索",
        "使用详解43（URLSession的使用1：请求数据）",
        "使用详解44（URLSession的使用2：结果处理、模型转换）",
        "使用详解45（结合RxAlamofire使用1：数据请求）",
        ]
    let controllers = [
        SHRxswift_14ViewController(),
        UIStoryboard(name: "Bookmark", bundle: Bundle(for: SHRxswift_15ViewController.self)).instantiateViewController(withIdentifier: "SHRxswift_15ViewController"),
        SHRxswift_16ViewController(),
        UIStoryboard(name: "Bookmark", bundle: Bundle(for: SHRxswift_17ViewController.self)).instantiateViewController(withIdentifier: "SHRxswift_17ViewController"),
        SHRxswift_18ViewController(),
        SHRxswift_19ViewController(),
        SHRxswift_20ViewController(),
        SHRxswift_GithubViewController(),
        UIStoryboard(name: "Bookmark", bundle: Bundle(for: SHRxswift_43ViewController.self)).instantiateViewController(withIdentifier: "SHRxswift_43ViewController"),
        SHRxswift_44ViewController(),
        UIStoryboard(name: "Bookmark", bundle: Bundle(for: SHRxswift_45ViewController.self)).instantiateViewController(withIdentifier: "SHRxswift_45ViewController"),
    ]
}

class SH190708ContactsViewController: UIViewController, UIGestureRecognizerDelegate {
    var tableView : UITableView?
    let bookmarksViewModel = SH190708ContactsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Contacts"
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
        return bookmarksViewModel.titles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookmarksCell", for:indexPath)
        cell.textLabel?.text = bookmarksViewModel.titles[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        return cell
    }
}
extension SH190708ContactsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = bookmarksViewModel.controllers[indexPath.row]
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
