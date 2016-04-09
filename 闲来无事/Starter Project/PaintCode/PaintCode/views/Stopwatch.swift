//
//  Stopwatch.swift
//  PaintCode
//
//  Created by huangaengoln on 16/2/3.
//  Copyright © 2016年 Ray Wenderlich. All rights reserved.
//

import UIKit

@IBDesignable
class Stopwatch: UIView {

    override func drawRect(rect: CGRect) {
        PaintCodeTutorial.drawStopwatch()
    }

}
