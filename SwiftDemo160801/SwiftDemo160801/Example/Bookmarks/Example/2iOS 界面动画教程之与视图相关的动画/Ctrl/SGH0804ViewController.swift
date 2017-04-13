//
//  SGH0804ViewController.swift
//  SwiftDemo160801
//
//  Created by huangaengoln on 16/8/4.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

import UIKit

class SGH0804ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView : UITableView?
    let reuseIdentifier = "SGH160802TableViewCell"
    
    var titlesArray = ["1、创建视图动画",
                       "2、创建弹簧效果的线性动画",
                       "3、变形动画的实现",
                       "4、视图动画的综合实践",
                       "5、关键帧动画"
    ]
    var controllersArray = [SGHBahamaAirLoginViewController(),
                            SGHUsingSpringViewController(),
                            SGHTransitionAnimationViewController(),
                            SGHFadeCubeTransitionViewController(),
                            SGHAnimateKeyFrameViewController()
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
