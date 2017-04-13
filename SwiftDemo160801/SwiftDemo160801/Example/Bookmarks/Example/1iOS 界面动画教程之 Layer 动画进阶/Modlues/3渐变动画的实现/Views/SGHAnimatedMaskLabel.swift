//
//  SGHAnimatedMaskLabel.swift
//  SwiftDemo160801
//
//  Created by huangaengoln on 16/8/3.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable
class SGHAnimatedMaskLabel: UIView {
    
    let gradientLayer : CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        let colors = [UIColor.yellow.cgColor,
                      UIColor.green.cgColor,
                      UIColor.orange.cgColor,
                      UIColor.cyan.cgColor,
                      UIColor.red.cgColor,
                      UIColor.yellow.cgColor]
            //[UIColor.blackColor().CGColor, UIColor.whiteColor().CGColor, UIColor.blackColor().CGColor]
        gradientLayer.colors = colors
        
        let locations = [0.0, 0.0, 0.0, 0.0, 0.0, 0.25]
            //[0.25, 0.5, 0.75]
        gradientLayer.locations = locations as [NSNumber]?
        
        return gradientLayer
    }()
    
    
    let textAttributes : [String: AnyObject] = {
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        return [NSFontAttributeName: UIFont(name: "HelveticaNeue-Thin", size: 28.0)!,
                NSParagraphStyleAttributeName : style]
    }()
    
    
    @IBInspectable var text: String! {
        didSet {
            setNeedsDisplay()
            UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
            text.draw(in: bounds, withAttributes: textAttributes)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            let maskLayer = CALayer()
            maskLayer.backgroundColor = UIColor.clear.cgColor
            //因为 gradientLayer.frame 是3倍的 bounds.size.width ，所以要作偏移，刚好在gradientLayer的中间上
            maskLayer.frame = bounds.offsetBy(dx: bounds.size.width, dy: 0)
            maskLayer.contents = image?.cgImage
            
            gradientLayer.mask = maskLayer
            
        }
    }
    
    override func layoutSubviews() {
        layer.borderColor = UIColor.green.cgColor
        gradientLayer.frame = CGRect(x: -bounds.size.width, y: bounds.origin.y, width: bounds.size.width * 3, height: bounds.size.height)
        //bounds
        
        
    }
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        layer.addSublayer(gradientLayer)
        
        let gradientAnimation = CABasicAnimation(keyPath: "locations")
        gradientAnimation.fromValue = [0.0, 0.0, 0.0, 0.0, 0.0, 0.25]
            //[0.0, 0.0, 0.25]
        gradientAnimation.toValue = [0.65, 0.8, 0.85, 0.9, 0.95, 1.0]
            //[0.75, 1.0, 1.0]
        gradientAnimation.duration = 3.0
        gradientAnimation.repeatCount = Float.infinity
        gradientLayer.add(gradientAnimation, forKey: nil)
        
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
