//
//  SHWordIndexViewController.swift
//  SwiftDemo160801
//
//  Created by Mac on 2019/11/8.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

import UIKit

class SHWordIndexViewController: UIViewController {

    // 定义变量
    var mainTableView:UITableView!
    var mainArray:NSMutableArray!
    let sortArray = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLocalData()
        setUI()
    }
    // MARK: - 数据
    func setLocalData() {
        self.mainArray = NSMutableArray()
        
        for charTmp in self.sortArray {
            switch charTmp {
            case "U", "V", "L":
                break
            default:
                let array = NSMutableArray()
                let number = arc4random() % 10 + 1
                for index in 1...number {
                    let text = String(format: "%@-%ld", arguments: [charTmp, index])
                    array.add(text)
                }
                
                let dict = NSMutableDictionary()
                dict["sectionArray"] = array
                dict["sectionTitle"] = charTmp
                
                self.mainArray.add(dict)
            }
            
        }
    }
    
    // MARK: - 视图
    func setUI() {
        self.mainTableView = UITableView(frame: self.view.bounds, style: .plain)
        self.view.addSubview(self.mainTableView)
        self.mainTableView.autoresizingMask = .flexibleHeight
        self.mainTableView.backgroundColor = UIColor.clear
        self.mainTableView.delegate = self as UITableViewDelegate
        self.mainTableView.dataSource = self as UITableViewDataSource
            self.mainTableView.tableFooterView = UIView.init()
            
        // 索引
        // 设置索引值颜色
        self.mainTableView.sectionIndexColor = .gray
        // 设置选中时的索引背景颜色
        self.mainTableView.sectionIndexTrackingBackgroundColor = .clear
        // 设置索引的背景颜色
        self.mainTableView.sectionIndexBackgroundColor = .clear
    }
    

}
extension SHWordIndexViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let dict:NSDictionary! = self.mainArray.object(at: section) as? NSDictionary
        let array:NSArray! = dict.object(forKey: "sectionArray") as? NSArray

            return array.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: "UITableViewCell")
            }
            
        let dict:NSDictionary! = self.mainArray.object(at: indexPath.section) as? NSDictionary
        let array:NSArray! = dict.object(forKey: "sectionArray") as? NSArray
        let text:String! = array.object(at: indexPath.row) as? String
            cell.textLabel!.text = text
            
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }

    
    
    
    // MARK: 索引（使用索引功能时，必须是有分组的列表，即有section分组）
    // section分组
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.mainArray.count
    }
        
    // section分组标题（通常与索引值数组相同）
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
            let dict:NSDictionary! = self.mainArray.object(at: section) as? NSDictionary
            let text:String! = dict.object(forKey: "sectionTitle") as? String
                
                return text
    }
    
    // 索引值数组
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.sortArray
    }
    
    // 索引值与列表关联点击事件
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        for i in 0 ..< self.mainArray.count {
            let dict:NSDictionary! = self.mainArray.object(at: i) as? NSDictionary
            let text:String! = dict.object(forKey: "sectionTitle") as? String
            if text == title {
                return i
            }
        }
        
        return index
    }
    
}
