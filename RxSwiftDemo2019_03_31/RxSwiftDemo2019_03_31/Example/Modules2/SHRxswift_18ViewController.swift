//
//  SHRxswift_18ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2019/7/17.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import RxDataSources

class SHRxswift_18ViewController: UIViewController {
    let disposeBag = DisposeBag()
    var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView)
        //创建URL对象
        let urlString = "https://www.douban.com/j/app/radio/channels"
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        //获取列表数据
        let data = URLSession.shared.rx.json(request: request)
            .map { (result) -> [[String: Any]] in
                if let data = result as? [String: Any], let channels = data["channels"] as? [[String: Any]] {
                    return channels
                } else {
                    return []
                }
            }
        data.bind(to: tableView.rx.items) {(tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(row): \(element["name"]!)"
            return cell
        }.disposed(by: disposeBag)
        
    }
}

import ObjectMapper
import RxSwift
public enum RxObjectMapperError: Error {
    case parsingError
}

public extension Observable where Element: Any {
    public func mapObject<T>(type: T.Type) -> Observable<T> where T: Mappable {
        let mapper = Mapper<T>()
        
        return self.map({ (element) -> T in
            guard let parsedElement = mapper.map(JSONObject: element) else {
                throw RxObjectMapperError.parsingError
            }
            return parsedElement
        })
    }
    
    public func mapArray<T>(type: T.Type) -> Observable<[T]> where T: Mappable {
        let mapper = Mapper<T>()
        
        return self.map({ (element) -> [T] in
            guard let parsedArray = mapper.mapArray(JSONObject: element) else {
                throw RxObjectMapperError.parsingError
            }
            return parsedArray
        })
    }
}

