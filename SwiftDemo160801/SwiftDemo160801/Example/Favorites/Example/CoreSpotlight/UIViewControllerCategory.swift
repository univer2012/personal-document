//
//  UIViewControllerCategory.swift
//  SwiftDemo160801
//
//  Created by rrd on 2019/7/11.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

import Foundation

import UIKit

extension UIViewController {
    class func current() -> UIViewController? {
        var vc = UIApplication.shared.keyWindow?.rootViewController!
        while true {
            if vc?.isKind(of: UITabBarController.self) ?? false {
                vc = (vc as! UITabBarController).selectedViewController
            }
            if vc?.isKind(of: UINavigationController.self) ?? false {
                vc = (vc as! UINavigationController).visibleViewController
            }
            if ((vc?.presentedViewController) != nil) {
                vc = vc?.presentedViewController
            } else {
                break
            }
        }
        return vc
    }
}
