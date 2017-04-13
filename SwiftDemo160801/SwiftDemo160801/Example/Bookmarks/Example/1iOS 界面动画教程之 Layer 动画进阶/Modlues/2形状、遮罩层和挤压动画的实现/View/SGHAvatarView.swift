//
//  SGHAvatarView.swift
//  SwiftDemo160801
//
//  Created by huangaengoln on 16/8/2.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable
class SGHAvatarView: UIView {
    
    //Constants
    let lineWidth : CGFloat = 6.0
    let animationDuration = 1.0
    
    //ui
    let photoLayer = CALayer()
    let circleLayer = CAShapeLayer()
    let maskLayer = CAShapeLayer()
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "ArialRoundedBold", size: 18.0)
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
    }()
    
    //variables
    @IBInspectable
    var image: UIImage! {
        didSet {
            photoLayer.contents = image.cgImage
        }
    }
    @IBInspectable
    var name: String? {
        didSet {
            label.text = name
        }
    }
    
    var shouldTransitionToFinishedState = false
    var isSquare = false
    
    override func didMoveToWindow() {
        layer.addSublayer(photoLayer)
        
        photoLayer.mask = maskLayer
        layer.addSublayer(circleLayer)
        self
        
        addSubview(label)
        
    }
    
    override func layoutSubviews() {
        //size the avatar image to fit
        photoLayer.frame = CGRect(
            x: (self.bounds.size.width - image.size.width + lineWidth) / 2,
            y: (self.bounds.size.height - image.size.height + lineWidth) / 2,
            width: image.size.width,
            height: image.size.height)
        
        //Draw the circle
        circleLayer.path = UIBezierPath(ovalIn: bounds).cgPath
        circleLayer.strokeColor = UIColor.white.cgColor
        circleLayer.lineWidth = lineWidth
        circleLayer.fillColor = UIColor.clear.cgColor
        
        //Size the layer
        maskLayer.path = circleLayer.path
        maskLayer.position = CGPoint(x: 0.0, y: lineWidth / 2)
        
        //Size the label
        label.frame = CGRect(x: 0.0, y: bounds.size.height + 10.0, width: bounds.size.width, height: 24.0)
    }
    
    
    
    func bounceOffPoint(_ bouncePoint: CGPoint, morphSize: CGSize) {
        let originalCenter = center
        
        
        UIView.animate(withDuration: animationDuration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: [], animations: { 
            self.center = bouncePoint
            }) { (_) in
                if self.shouldTransitionToFinishedState {
                    self.animateToSquare()
                }
        }
        
        
        UIView.animate(withDuration: animationDuration, delay: animationDuration, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: [], animations: { 
            self.center = originalCenter
            }) { (_) in
//                delay(seconds: 0.1, completion: { 
//                    self.bounceOffPoint(bouncePoint, morphSize: morphSize)
//                })
                if !self.isSquare {
                    self.bounceOffPoint(bouncePoint, morphSize: morphSize)
                }
        }
        
        let morphedFrame = (originalCenter.x > bouncePoint.x) ?
        CGRect(x: 0.0, y: bounds.height - morphSize.height,
               width: morphSize.width, height: morphSize.height) :
        CGRect(x: bounds.width - morphSize.width, y: bounds.height - morphSize.height,
               width: morphSize.width, height: morphSize.height)
        
        let morphAnimation = CABasicAnimation(keyPath: "path")
        morphAnimation.duration = animationDuration
        morphAnimation.toValue = UIBezierPath(ovalIn: morphedFrame).cgPath
        morphAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        circleLayer.add(morphAnimation, forKey: nil)
        maskLayer.add(morphAnimation, forKey: nil)
        
    }
    
    func animateToSquare() {
        isSquare = true
        
        let squarePath = UIBezierPath(rect: bounds).cgPath
        let morph = CABasicAnimation(keyPath: "path")
        morph.duration = 0.25
        morph.fromValue = circleLayer.path
        morph.toValue = squarePath
        
        circleLayer.add(morph, forKey: nil)
        maskLayer.add(morph, forKey: nil)
        
        circleLayer.path = squarePath
        maskLayer.path = squarePath
    }
    
    
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
