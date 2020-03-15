//
//  SGH1214FavoritesViewController.swift
//  SwiftDemo160801
//
//  Created by huangaengoln on 2016/12/14.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

/*
 
 HandOff 的教程
 1. [多台设备同步 NSUserActivity详解](https://blog.csdn.net/baidu_31683691/article/details/51897542)
 2. [iOS Search API - NSUserActivity](https://www.jianshu.com/p/2ec61e2c00cb)
 */


import UIKit


class SGH1214FavoritesViewController: UIViewController,UIGestureRecognizerDelegate {

    
    var tableView : UITableView!
    let titlesArray: [[String: String]] = [
        ["d1": "1、NSUserActivity"],
        ["d2": "2、Core Spotlight"],
        ["d3": "3、Web Mark Up"],
        ["d4": "4、Universal Links"],
        ["d5": "5、Smart App Banners"],
        ["d6": "6、Handoff"],
    ]
    
    private func getController(with key:String) -> UIViewController {
        switch key {
        case "d1":
            return UIViewController()
        case "d2":
            return UIStoryboard(name: "Favorites", bundle: Bundle(for: SHCoreSpot1907TableViewController.self)).instantiateViewController(withIdentifier: "SHCoreSpot1907TableViewController")
        case "d3":
            return UIViewController()
        case "d4":
            return UIViewController()
        case "d5":
            return UIViewController()
        case "d6":
            return UIViewController()
        default:
            break
        }
        return UIViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: nil)
        self.title = "Favorites"
        //设置滑动返回
    self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        
        //初始化tableView的数据
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        //设置tableView的数据源
        self.tableView.dataSource = self
        //设置tableView的委托
        self.tableView.delegate = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension SGH1214FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    //UITableViewDataSource
    
    //总行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titlesArray.count
    }
    
    //加载数据
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        let row = indexPath.row as Int
        cell.textLabel?.text = self.titlesArray[row].values.first
        return cell
    }
    
    
    ///UITableViewDelegate
    //选择一行
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let key = self.titlesArray[indexPath.row].keys.first {
            
            let viewController = getController(with: key)
            viewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
