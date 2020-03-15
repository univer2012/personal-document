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



class SH190617BookmarksViewController: UIViewController,UIGestureRecognizerDelegate {
    var tableView : UITableView?
    
    let titlesArray: [[String: String]] = [
        ["d1": "1、加速传感器（CoreMotion）的用法（要用真机）"],
        ["d2": "2、解析JSON数据"],
        ["d3": "3、CALayer Demos"],
    ]
    private func getController(with key:String) -> UIViewController {
        switch key {
        case "d1":
            return SHCoreMotionDemoViewController()
        case "d2":
            return SHJSONSerializationViewController()
        case "d3":
            return SHLayerListDemoViewController()
        default:
            break
        }
        return UIViewController()
    }
        
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

    }
}

extension SH190617BookmarksViewController : UITableViewDataSource {
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
extension SH190617BookmarksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let key = self.titlesArray[indexPath.row].keys.first {
            
            let viewController = getController(with: key)
            viewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
