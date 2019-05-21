//
//  SGH0802TableEditDeleteViewController.swift
//  SwiftDemo160801
//
//  Created by huangaengoln on 16/8/2.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

import UIKit

class SGH0802TableEditDeleteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableView : UITableView?
    var items = ["武汉", "上海", "北京", "深圳", "广州", "重庆", "香港", "台海", "天津"]
    var leftButton : UIButton?
    var rightButtonItem : UIBarButtonItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //12、设置 左边按钮和back按钮同时存在
        self.navigationItem.leftItemsSupplementBackButton = true;
        
        initView()
        setupRightBarButtonItem()
        setupLeftBarButtonItem()
        self.leftButton!.isUserInteractionEnabled = true


        // Do any additional setup after loading the view.
    }

    func initView() {
        //初始化tableView的数据
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        //设置tableView的数据源
        self.tableView!.dataSource = self
        //设置tableView的委托
        self.tableView!.delegate = self
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView!)
    }
    
    //加左边按钮
    func setupLeftBarButtonItem() {
        self.leftButton = UIButton(type: .custom)
        self.leftButton!.frame = CGRect(x: 0, y: 0, width: 50, height: 40)
        self.leftButton?.setTitleColor(UIColor.red, for: UIControl.State())
        self.leftButton?.setTitle("Edit", for: UIControl.State())
        self.leftButton!.tag = 100
        self.leftButton!.isUserInteractionEnabled = false
        self.leftButton?.addTarget(self, action: #selector(SGH0802TableEditDeleteViewController.leftBarButtonItemClicked), for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: self.leftButton!)
        self.navigationItem.leftBarButtonItem = barButtonItem
    }
    //左边按钮事件
    @objc func leftBarButtonItemClicked() {
        print("leftBarButton")
        if self.leftButton!.tag == 100 {
            self.tableView?.setEditing(true, animated: true)
            self.leftButton?.tag = 200
            self.leftButton?.setTitle("Done", for: UIControl.State())
            //将增加按钮设置不能用
            self.rightButtonItem!.isEnabled = false
        }
        else {
            //恢复增加按钮
            self.rightButtonItem!.isEnabled = true
            self.tableView?.setEditing(false, animated: true)
            self.leftButton?.tag = 100
            self.leftButton?.setTitle("Edit", for: UIControl.State())
        }
    }
    
    //加右边按钮
    func setupRightBarButtonItem() {
        self.rightButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(SGH0802TableEditDeleteViewController.rightBarButtonItemClicked))
        self.navigationItem.rightBarButtonItem = self.rightButtonItem
    }
    
    @objc func rightBarButtonItemClicked() {
        let row = self.items.count
        let indexPath = IndexPath(row: row, section: 0)
        self.items.append("杭州")
        self.tableView?.insertRows(at: [indexPath], with: .left)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //总行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    //加载数据
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        let row = indexPath.row as Int
        cell.textLabel?.text = self.items[row]
        cell.imageView?.image = UIImage(named: "green.png")
        return cell
    }
    //删除一行
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let index = indexPath.row as Int
        self.items.remove(at: index)
        self.tableView?.deleteRows(at: [indexPath], with: .top)
        print("删除\(indexPath.row)")
    }
    
    //选择一行
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertView()
        alert.title = "提示"
        alert.message = "你选择的是\(self.items[indexPath.row])"
        alert.addButton(withTitle: "OK")
        alert.show()
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
