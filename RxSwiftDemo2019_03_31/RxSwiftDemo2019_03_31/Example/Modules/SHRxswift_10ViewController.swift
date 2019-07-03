//
//  SHRxswift_10ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by 远平 on 2019/7/1.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class SHRxswift_10ViewController: UIViewController {
    var tableView: UITableView!
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = UITableView(frame:self.view.frame, style:.plain)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(self.tableView)
        
        let items = Observable.just([
            "文本输入框的用法",
            "开关按钮的用法",
            "进度条的用法",
            "文本标签的用法",
            ])
        items.bind(to: tableView.rx.items) { (tableView,row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(row): \(element)"
            return cell
        }
    }
    
}
