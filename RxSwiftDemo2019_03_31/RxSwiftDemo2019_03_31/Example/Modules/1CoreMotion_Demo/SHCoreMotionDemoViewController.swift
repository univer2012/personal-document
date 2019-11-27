//
//  SHCoreMotionDemoViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by 远平 on 2019/11/26.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit

import CoreMotion

class SHCoreMotionDemoViewController: UIViewController, UIAccelerometerDelegate {

    var ball: UIImageView!
    var speedX: UIAccelerationValue = 0
    var speedY: UIAccelerationValue = 0
    var motionManager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //放一个小球在中央
        ball = UIImageView(image: UIImage(named: "ball"))
        ball.frame = CGRect(x: 0, y: 0, width: 50, height:50)
        ball.center = self.view.center
        self.view.addSubview(ball)
        
        motionManager.accelerometerUpdateInterval = 1/60
        
        if motionManager.isAccelerometerAvailable {
            let queue = OperationQueue.current!
            motionManager.startAccelerometerUpdates(to: queue) { (accelerometerData, error) in
                //动态设置小球位置
                //self.speedX += accelerometerData.accelera
                
            }
        }
    }
}
