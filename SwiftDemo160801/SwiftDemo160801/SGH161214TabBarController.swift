//
//  SGH161214TabBarController.swift
//  SwiftDemo160801
//
//  Created by huangaengoln on 2016/12/14.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

import UIKit

class SGH161214TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationItem.hidesBackButton = false
        let bookmarksNavController = UINavigationController(rootViewController: SGH1214BookmarksViewController())
        //bookmarksNavController.navigationItem.hidesBackButton = false
        bookmarksNavController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        
        
        let favoritesNavController = UINavigationController(rootViewController: SGH1214FavoritesViewController())
        favoritesNavController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        self.viewControllers = [bookmarksNavController, favoritesNavController]
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
