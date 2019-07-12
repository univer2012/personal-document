//
//  SGH0803RefreshView.swift
//  SwiftDemo160801
//
//  Created by huangaengoln on 16/8/3.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

import UIKit
import QuartzCore

protocol SGH0803RefreshViewDelegate {
    func refreshViewDidRefresh(_ refreshView: SGH0803RefreshView)
}


class SGH0803RefreshView: UIView, UIScrollViewDelegate {

    var delegate : SGH0803RefreshViewDelegate?
    var scrollView :UIScrollView?
    var refreshing: Bool = false
    var progress: CGFloat = 0.0
    
    var isRefreshing = false
    let ovalShapeLayer: CAShapeLayer = CAShapeLayer()
    let airplaneLayer: CALayer = CALayer()
    
    init(frame: CGRect, scrollView: UIScrollView) {
        super.init(frame: frame)
        
        self.scrollView = scrollView
        
        //add the background image
        let imageView = UIImageView(image: UIImage(named: "refresh-view-bg"))
        imageView.frame = bounds
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        addSubview(imageView)
        
        //虚线椭圆
        ovalShapeLayer.strokeColor = UIColor.white.cgColor
        ovalShapeLayer.fillColor = UIColor.clear.cgColor
        ovalShapeLayer.lineWidth = 4
        ovalShapeLayer.lineDashPattern = [2, 3]
        
        let refreshRadius = frame.size.height / 2 * 0.8
        
        ovalShapeLayer.path = UIBezierPath(ovalIn: CGRect(x: frame.size.width / 2 - refreshRadius, y: frame.size.height / 2 - refreshRadius, width: 2 * refreshRadius, height: 2 * refreshRadius)).cgPath
        layer.addSublayer(ovalShapeLayer)
        
        //创建 飞机
        let airplaneImage = UIImage(named: "airplane")
        airplaneLayer.contents = airplaneImage?.cgImage
        airplaneLayer.bounds = CGRect(x: 0.0, y: 0.0, width: airplaneImage!.size.width, height: airplaneImage!.size.height)
        //飞机起点位置
        airplaneLayer.position = CGPoint(x: frame.size.width / 2 + refreshRadius, y: frame.size.height / 2)
        // 不透明度
        airplaneLayer.opacity = 0.0
        layer.addSublayer(airplaneLayer)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Scroll View Delegate methods
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = CGFloat( max(-(scrollView.contentOffset.y + scrollView.contentInset.top), 0.0))
        self.progress = min(max(offsetY / frame.size.height, 0.0), 1.0)
        
        if !isRefreshing {
            redrawFromProgress(self.progress)
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if !isRefreshing && self.progress >= 1.0 {
            delegate?.refreshViewDidRefresh(self)
            beginRefreshing()
        }
    }
    
    //MARK: animate the Refresh View
    func beginRefreshing() {
        isRefreshing = true
        
        UIView.animate(withDuration: 0.3, animations: { 
            var newInsets = self.scrollView!.contentInset
            newInsets.top += self.frame.size.height
            self.scrollView!.contentInset = newInsets
        }) 
        // 虚线的 “转圈”动画
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.fromValue = -0.5
        strokeStartAnimation.toValue = 1.0
        
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.fromValue = 0.0
        strokeEndAnimation.toValue = 1.0
        
        let strokeAnimationGroup = CAAnimationGroup()
        strokeAnimationGroup.duration = 1.5
        strokeAnimationGroup.repeatCount = 5.0
        strokeAnimationGroup.animations = [strokeStartAnimation, strokeEndAnimation]
        
        ovalShapeLayer.add(strokeAnimationGroup, forKey: nil)
        
        
        // 飞机的路径动画
        let flightAnimation = CAKeyframeAnimation(keyPath: "position")
        flightAnimation.path = ovalShapeLayer.path
        // 使用平均速度
        flightAnimation.calculationMode = CAAnimationCalculationMode.paced
        
        //飞机的方向动画
        let airplaneOrientationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        airplaneOrientationAnimation.fromValue = 0
        airplaneOrientationAnimation.toValue = 2 * Double.pi
        
        let flightAnimationGroup = CAAnimationGroup()
        flightAnimationGroup.duration = 1.5
        flightAnimationGroup.repeatCount = 5.0
        flightAnimationGroup.animations = [flightAnimation, airplaneOrientationAnimation]
        
        airplaneLayer.add(flightAnimationGroup, forKey: nil)
        
    }
    
    func endRefreshing() {
        isRefreshing = false
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: { 
            var newInsets = self.scrollView!.contentInset
            newInsets.top -= self.frame.size.height
            self.scrollView!.contentInset = newInsets
            }) { (_) in
                //finished
        }
    }
    
    //往下拉时，用来刷新虚线椭圆
    func redrawFromProgress(_ progress: CGFloat) {
        ovalShapeLayer.strokeEnd = progress
        airplaneLayer.opacity = Float(progress)
    }
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
