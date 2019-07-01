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
//        self.tableView.register
    }
    
}
