//
//  UIImageCategory.swift
//  RxSwiftDemo2019_03_31
//
//  Created by rrd on 2019/6/26.
//  Copyright © 2019 远平. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    class func image(withColor color: UIColor?) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(color!.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
        
    }
}
