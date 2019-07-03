//
//  SHRxswift_10ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by 远平 on 2019/7/1.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import RxDataSources

class SHRxswift_10ViewController: UIViewController {
    var tableView: UITableView!
    
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = UITableView(frame:self.view.frame, style:.plain)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(self.tableView)
        
        let randomResult = refreshButton.rx.tap.asObservable()
            .startWith(())  //加这个为了让一开始就能自动请求一次数据
            .flatMapLatest {
                self.getRandomResult().takeUntil(self.cancelButton.rx.tap)
            }
            .share(replay: 1)
        
        //创建数据源
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Int>>(configureCell: { (dataSource, tv, indexPath, element) -> UITableViewCell in
            let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "条目\(indexPath.row): \(element)"
            return cell
        })
        
        //绑定单元格数据
        randomResult.bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    //获取随机数据
    func getRandomResult() -> Observable<[SectionModel<String, Int>]> {
        print("正在请求数据......")
        let items = (0 ..< 5).map {_ in
            Int(arc4random())
        }
        let observable = Observable.just([SectionModel(model: "S", items: items)])
        return observable.delay(2, scheduler: MainScheduler.instance)
    }
}

