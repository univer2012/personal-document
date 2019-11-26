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

extension String {
    public subscript(start: Int, length: Int) -> String {
        get {
            let index1 = self.index(self.startIndex, offsetBy: start)
            let index2 = self.index(index1, offsetBy: length)
            return String(self[index1 ..< index2])
        }
        set {
            let tmp = self
            var s = ""
            var e = ""
            for (idx, item) in tmp.characters.enumerated() {
                if idx < start {
                    s += "\(item)"
                }
                if idx >= start + length {
                    e += "\(item)"
                }
            }
        }
    }
}


