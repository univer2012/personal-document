//
//  SGH0819MiddleAutoLayoutViewController.swift
//  SwiftDemo160801
//
//  Created by huangaengoln on 16/8/19.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//
/*
 · 使用自动布局调整UI元素的位置
 · 使用自动布局对齐UI元素
 · 创建IBOutlet 和 IBAction 关联
 */
import UIKit

class SGH0819MiddleAutoLayoutViewController: UIViewController {
    
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var buttonMenu: UIButton!
    
    @IBOutlet var titleLabel: UILabel!
    
    //MARK: further class variables
    var slider: SGH0819HorizonalItemList!
    var isMenuOpen = false
    var items: [Int] = [5, 6, 7]
    
    //MARK: class methods
    @IBAction func actionToggleMenu(_ sender: AnyObject) {
        
    }
    func showItem(_ index: Int) {
        print("tapped item \(index)")
    }
    
}

let itemTitles = ["Icecream money",
                  "Great weather",
                  "Beach ball",
                  "Swim suit for him",
                  "Swim suit for her",
                  "Beach games",
                  "Ironing board",
                  "Cocktail mood",
                  "Sunglasses",
                  "Flip flops"]

extension SGH0819MiddleAutoLayoutViewController: UITableViewDelegate, UITableViewDataSource {
    //MARK: View Controller methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView?.rowHeight = 54.0
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    //MARK: Table View methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        cell.accessoryType = .none
        cell.textLabel?.text = itemTitles[items[indexPath.row]]
        cell.imageView?.image = UIImage(named: "summericons_100px_0\(items[indexPath.row]).png")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showItem(items[indexPath.row])
    }
    
}
