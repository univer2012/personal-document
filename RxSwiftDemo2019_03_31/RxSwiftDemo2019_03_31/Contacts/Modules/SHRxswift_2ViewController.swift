//
//  SHRxswift_2ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by rrd on 2019/6/17.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit



struct Music {
    let name: String
    let singer: String
    init(name: String, singer: String) {
        self.name = name
        self.singer = singer
    }
}
extension Music: CustomStringConvertible {
    var description: String {
        return "name: \(name) singer: \(singer)"
    }
}


#if false    //3，过去我们会这么做（传统式编程）
struct MusicListViewModel {
    let data = [
    Music(name: "无条件", singer: "陈奕迅"),
    Music(name: "你曾是少年", singer: "S.H.E."),
    Music(name: "从前的我", singer: "陈洁仪"),
    Music(name: "在木星", singer: "朴树"),]
}


class SHRxswift_2ViewController: UIViewController {
    
    var tableView: UITableView!
    let musicListViewModel = MusicListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初始化tableView的数据
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "musicCell")
        self.view.addSubview(self.tableView!)
        
        tableView.dataSource = self
        tableView.delegate = self

        // Do any additional setup after loading the view.
    }
}
extension SHRxswift_2ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicListViewModel.data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "musicCell")!
        let music = musicListViewModel.data[indexPath.row]
        cell.textLabel?.text = music.name
        cell.detailTextLabel?.text = music.singer
        return cell
    }
}
extension SHRxswift_2ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("你选中的歌曲信息【\(musicListViewModel.data[indexPath.row])】")
    }
}

#else   //4，现在使用 RxSwift 进行改造（响应式编程）

import RxSwift
import RxCocoa

struct MusicListViewModel {
    let data =  Observable.just([
        Music(name: "无条件", singer: "陈奕迅"),
        Music(name: "你曾是少年", singer: "S.H.E."),
        Music(name: "从前的我", singer: "陈洁仪"),
        Music(name: "在木星", singer: "朴树"),
        ])
}

class SHRxswift_2ViewController: UIViewController {
    var tableView: UITableView!
    let musicListViewModel = MusicListViewModel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初始化tableView的数据
        self.tableView = UITableView(frame: self.view.frame, style: .plain)
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "musicCell")
        self.view.addSubview(self.tableView!)
        //
        musicListViewModel.data.bind(to: tableView.rx.items(cellIdentifier:"musicCell")) {_, music,cell in
            cell.textLabel?.text = music.name
            cell.detailTextLabel?.text = music.singer
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Music.self).subscribe(onNext:{music in
            print("你选中的歌曲信息【\(music)】")
        }).disposed(by: disposeBag)
    }
}

#endif
