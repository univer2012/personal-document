//
//  SGH1214FavoritesViewController.swift
//  SwiftDemo160801
//
//  Created by huangaengoln on 2016/12/14.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

import UIKit

class SGH1214FavoritesViewController: UIViewController,UIGestureRecognizerDelegate {

    
    var tableView : UITableView!
    let titlesArray = ["1、NSUserActivity",
                       "2、Core Spotlight",
                       "3、Web Mark Up",
                       "4、Universal Links",
                       "5、Smart App Banners",
                       "6、Handoff"
    ]
    
    let controllersArray = [
        UIStoryboard(name: "Favorites", bundle: Bundle(for: SHUserActivity1907ViewController.self)).instantiateViewController(withIdentifier: "SHUserActivity1907ViewController"),
        UIViewController(),
        UIViewController(),
        UIViewController(),
        UIViewController(),
        UIViewController(),
    ]
    
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
        cell.textLabel?.text = self.titlesArray[row]
        return cell
    }
    
    
    ///UITableViewDelegate
    //选择一行
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = self.controllersArray[indexPath.row]
        viewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
