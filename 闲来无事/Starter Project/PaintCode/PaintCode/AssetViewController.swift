//
//  AssetViewController.swift
//  PaintCode
//
//  Created by Felipe Laso Marsetti on 1/15/15.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

class AssetViewController: UIViewController {
    @IBOutlet weak var stopWatchHandView: StopwatchHand!
    override func viewWillAppear(_ animated: Bool) {
        rotateStopWatchHand()
    }
    
    func rotateStopWatchHand() {
        UIView.animate(withDuration: 2.0, delay: 0, options: .curveLinear, animations: { () -> Void in
            self.stopWatchHandView.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi / 2))
//                CGAffineTransformRotate(self.stopWatchHandView.transform, CGFloat(M_PI_2))
            }) { (finished) -> Void in
                self.rotateStopWatchHand()
        }
    }
}

