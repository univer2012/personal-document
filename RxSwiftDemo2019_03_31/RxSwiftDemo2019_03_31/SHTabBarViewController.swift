//
//  SHTabBarViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by rrd on 2019/6/17.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit

class SHTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let bookmarksNavController = UINavigationController(rootViewController: SH190617BookmarksViewController())
        bookmarksNavController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        bookmarksNavController.title = "Bookmarks"
        self.viewControllers = [bookmarksNavController]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
