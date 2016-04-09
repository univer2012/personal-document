//
//  AppDelegate.swift
//  BasicGrammar
//
//  Created by huangaengoln on 15/10/29.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        //这里进行判断是哪一个在打开此app，然后分别进行操作
        let
         scheme=url.scheme
        //不分大小写比较
        if scheme.caseInsensitiveCompare("OpenAppTest") == .OrderedSame {
            //执行跳转，跳转到你想要的页面
            let alert=UIAlertView(title: "\(scheme)", message: "\(url)", delegate: self, cancelButtonTitle: "确认")
            alert.show()
        }
        let vc=NextViewController()
        if let navVC=self.window?.rootViewController as? UINavigationController {
            navVC.pushViewController(vc, animated: true)
        }
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

