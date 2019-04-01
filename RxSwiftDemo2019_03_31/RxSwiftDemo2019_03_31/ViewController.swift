//
//  ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by 远平 on 2019/3/31.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellow
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func login(_ sender: Any) {
//        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    @IBAction func tableViewAction(_ sender: Any) {
//        navigationController?.pushViewController(RxTableViewController(), animated: true)
    }
    @IBAction func collectionViewAction(_ sender: Any) {
//        navigationController?.pushViewController(RxCollectionViewController(), animated: true)
    }
    
}

