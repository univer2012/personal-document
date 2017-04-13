//
//  SGH160811ViewController.swift
//  SwiftDemo160801
//
//  Created by huangaengoln on 16/8/12.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//
/*
 本套课程中我们学习了iOS界面动画教程之Layer动画的相关基础知识。你应当掌握了以下知识：
 · 简单层动画的实现
 · 动画的键和委托的实现
 · 动画的分组
 · Layer层面的弹簧动画实现
 · 关键帧动画
 
 你可以使用这些技巧创建Layer层面的相关动画，如果想继续提高，你可以继续在极客学院学习iOS界面动画之层动画进阶课程
 */

import UIKit

class SGH160811ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView : UITableView?
    let reuseIdentifier = "SGH160802TableViewCell"
    
    var titlesArray = ["1、Layer 动画的实现",
                       "2、动画的键和委托的实现",
                       "3、分组动画",
                       "4、Layer 层面的弹簧动画实现",
                       "5、Layer 层面的关键帧动画"
                       
    ]
    var controllersArray = [SGH0812LayerViewController(),
                            SGHBasicAnimationDelegateViewController(),
                            SGHAnimationGroupViewController(),
                            SGH0816SpringAnimationViewController(),
                            SGH0817KeyFrameAnimationViewController()
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        p_initView()
    }
    
    func p_initView() {
        //初始化tableView的数据
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        //设置tableView的数据源
        self.tableView!.dataSource = self
        //设置tableView的委托
        self.tableView!.delegate = self
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        self.view.addSubview(self.tableView!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UITableViewDataSource
    
    //总行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titlesArray.count
    }
    
    //加载数据
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as UITableViewCell
        let row = indexPath.row as Int
        cell.textLabel?.text = self.titlesArray[row]
        return cell
    }
    
    
    //MARK: - UITableViewDelegate
    //选择一行
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let toViewController = self.controllersArray[indexPath.row]
        
        self.navigationController!.pushViewController(toViewController, animated: true)
//        self.presentViewController(toViewController, animated: true) {}
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}




