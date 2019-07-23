//
//  SHRxswift_20ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2019/7/22.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

import Moya

class SHRxswift_20ViewController: UIViewController {
    let disposeBag = DisposeBag()
    var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //创建表视图
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(tableView)
        //获取列表数据
        let data = DouBanProvider.rx.request(.channels)
            .mapJSON()
            .map { (data) -> [[String: Any]] in
                print("data:",data)
                if let json = data as? [String: Any], let channels = json["channels"] as? [[String: Any]] {
                    return channels
                } else {
                    return []
                }
            }.asObservable()
        //将数据绑定到表格
        data.bind(to: tableView.rx.items) {(tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(element["name"]!)"
            cell.accessoryType = .disclosureIndicator
            return cell
        }.disposed(by: disposeBag)
        
        //单元格点击
        tableView.rx.modelSelected([String: Any].self)
            .map{ $0["channel_id"] as! String }
            .flatMap { DouBanProvider.rx.request(.playlist($0)) }
            .mapJSON()
            .subscribe(onNext: { [weak self] (data) in
                //解析数据，获取歌曲信息
                if let json = data as? [String: Any], let musics = json["song"] as? [[String: Any]] {
                    let artist = musics[0]["artist"]!
                    let title = musics[0]["title"]!
                    let message = "歌手：\(artist)\n歌曲：\(title)"
                    //将歌曲信息弹出显示
                    self?.showAlert(title: "歌曲信息", message: message)
                }
            }).disposed(by: disposeBag)
    }
    
    func showAlert(title:String, message:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
}
