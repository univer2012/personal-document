//
//  ViewController.swift
//  SwiftDemo
//
//  Created by huangaengoln on 16/2/27.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tableView:UITableView?
    var controllersArray:NSMutableArray?
    var titlesArray:NSMutableArray?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title="SwiftDemo"
        
        self.view.backgroundColor=UIColor.whiteColor()
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

