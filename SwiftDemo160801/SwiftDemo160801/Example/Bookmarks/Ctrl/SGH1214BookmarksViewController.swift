//
//  SGH1214BookmarksViewController.swift
//  SwiftDemo160801
//
//  Created by huangaengoln on 2016/12/14.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

import UIKit

class SGH1214BookmarksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {

    var tableView : UITableView?
    var titlesArray = ["1、iOS 界面动画教程之 Layer 动画进阶",
                       "2、iOS 界面动画教程之与视图相关的动画",
                       "3、iOS 界面动画教程之 Layer 动画基础",
                       "4、iOS 界面动画教程之自动布局",
                       "5、自定义PageControl",
                       "6、尝试面向轨道编程",
                       "7、Auto Layout 使用心得",
                       "8、面向协议编程与 Cocoa 的邂逅 (下)",
                       "9、架构师之泛型应用分析介绍"
    ]
    
    var controllersArray = [SGH160802ViewController(),
                            SGH0804ViewController(),
                            SGH160811ViewController(),
                            SGH160818AutoLayoutViewController(),
                            SGH1208CustomPageControlViewController(),
                            SGH1213TrackProgramViewController(),
                            SGH1214AutolayoutViewController(),
                            SGH1222POPAndCocoaViewController(),
                            DreamGenericViewController()
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //[self.navigationItemsetHidesBackButton:YES];
        self.title = "Bookmarks"
        //设置滑动返回
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
//        //自定义后退按钮的文字和颜色(这代码写在push前的控制器里才有效)
//        let backBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(p_navigationBack))
//        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        p_initView()
    }
    func p_initView() {
        //初始化tableView的数据
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        //设置tableView的数据源
        self.tableView!.dataSource = self
        //设置tableView的委托
        self.tableView!.delegate = self
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView!)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
