//
//  SGH160802ViewController.swift
//  SwiftDemo160801
//
//  Created by huangaengoln on 16/8/2.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

import UIKit

class SGH160802ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView : UITableView?
    let reuseIdentifier = "SGH160802TableViewCell"
    
    var titlesArray = ["1、UITableView编辑删除添加",
                       "2、形状、遮罩层和挤压动画的实现",
                       "3、渐变动画的实现",
                       "4、路径动画的实现",
                       "5、复制动画的实现"
    ]
    var controllersArray = [SGH0802TableEditDeleteViewController(),
                            SGH0802CollideViewController(),
                            SGHGradientLayerViewController(),
                            SGHPullToRefreshTableViewController(),
                            SGHAssistantIrisViewController()
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(p_navigationBack))
        self.navigationItem.backBarButtonItem = backBarButtonItem
        // Do any additional setup after loading the view.
        p_initView()
    }
    @objc func p_navigationBack() {
        self.navigationController?.popViewController(animated: true)
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
        /*
        if toViewController.isKindOfClass(SGH0802CollideViewController) {
            self.presentViewController(toViewController, animated: true, completion: {
                
            })
        }
        else {
            self.navigationController?.pushViewController(toViewController, animated: true)
        }
 */
        
        
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
