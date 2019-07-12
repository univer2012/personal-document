//
//  SGHAnimateKeyFrameViewController.swift
//  SwiftDemo160801
//
//  Created by huangaengoln on 16/8/11.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

import UIKit

class SGHAnimateKeyFrameViewController: UIViewController {

    
    @IBOutlet weak var bgImageView: UIImageView!
    
    @IBOutlet weak var summaryIcon: UIImageView!
    @IBOutlet weak var summary: UILabel!
    
    @IBOutlet weak var flightNr: UILabel!
    @IBOutlet weak var gateNr: UILabel!
    
    @IBOutlet weak var departingFrom: UILabel!
    @IBOutlet weak var arrivingTo: UILabel!
    @IBOutlet weak var planeImage: UIImageView!
    
    @IBOutlet weak var statusBanner: UIImageView!
    @IBOutlet weak var flightStatus: UILabel!
    
    var snowView: SGH0808SnowView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //adjust ui
        summary.addSubview(summaryIcon)
        summaryIcon.center.y = summary.frame.size.height / 2
        
        
        //add the snow effect layer
        snowView = SGH0808SnowView(frame: CGRect(x: -150, y: -100, width: 300, height: 50))
        let snowClipView = UIView(frame: view.frame.offsetBy(dx: 0, dy: 50))
        snowClipView.clipsToBounds = true
        snowClipView.addSubview(snowView)
        view.addSubview(snowClipView)
        
        //start rotating the flights
        p_changeFlightDataTo(londonToParis)

        
        
    }
    
    /**
     淡入淡出动画
     - parameter imageView:			想要做淡入淡出的imageView
     - parameter toImage:					要淡入的新的图片
     - parameter showEffects:	是否显示雪花飘落
     */
    func p_fadeImageView(_ imageView: UIImageView, toImage: UIImage, showEffects: Bool) {
        //动画 imageView
        UIView.transition(with: imageView, duration: 1.0, options: .transitionCrossDissolve, animations: {
            imageView.image = toImage
            }, completion: nil)
        //动画 snowView
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
            self.snowView.alpha = showEffects ? 1.0 : 0.0
            }, completion: nil)
    }
    
    /**
     3D转场动画
     - parameter label:					想要进行动画的label
     - parameter text:						将要显示的新文本
     - parameter direction:	显示文本是从上还是从下
     */
    /// 飞机的号码
    func p_cubeTransition(label: UILabel, text: String, direction: SGHAnimationDirection) {
        //辅助label： auxLabel 新的label
        let auxLabel = UILabel(frame: label.frame)
        auxLabel.text = text
        auxLabel.font = label.font
        auxLabel.textAlignment = label.textAlignment
        auxLabel.textColor = label.textColor
        //        auxLabel.textColor = UIColor.redColor()
        auxLabel.backgroundColor = label.backgroundColor
        
        //偏移量
        let auxLabelOffset = CGFloat(direction.rawValue) * label.frame.size.height / 2.0
        /**
         *	CGAffineTransformConcat 是串联2个仿射矩阵的
         *	@param 1.0	改变原有高度为。0.1倍
         *	@param 0.1
         */
        auxLabel.transform = CGAffineTransform(scaleX: 1.0, y: 0.1).concatenating(CGAffineTransform(translationX: 0.0, y: auxLabelOffset))
        
        label.superview!.addSubview(auxLabel)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
            //CGAffineTransformIdentity  是系统提供的常量，代表原图
            auxLabel.transform = CGAffineTransform.identity
            label.backgroundColor = UIColor.clear
            label.transform = CGAffineTransform(scaleX: 1.0, y: 0.1).concatenating(CGAffineTransform(translationX: 0.0, y: -auxLabelOffset))
        }) { (_) in
            label.text = auxLabel.text
            label.transform = CGAffineTransform.identity
            
            auxLabel.removeFromSuperview()
        }
    }
    
    ///飞机两边的label的动画
    func p_moveLabel(_ label: UILabel, text: String, offset: CGPoint) {
        //创建辅助label： auxLabel 新的label
        let auxLabel = UILabel(frame: label.frame)
        auxLabel.text = text
        auxLabel.font = label.font
        auxLabel.textAlignment = label.textAlignment
        auxLabel.textColor = label.textColor
        auxLabel.backgroundColor = UIColor.clear
        
        auxLabel.transform = CGAffineTransform(translationX: offset.x, y: offset.y)
        auxLabel.alpha = 0
        view.addSubview(auxLabel)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            label.transform = CGAffineTransform(translationX: offset.x, y: offset.y)
            label.alpha = 0.0
            }, completion: nil)
        
        UIView.animate(withDuration: 0.25, delay: 0.1, options: .curveEaseIn, animations: {
            auxLabel.transform = CGAffineTransform.identity
            auxLabel.alpha = 1.0
        }) { (_) in
            //clean up
            auxLabel.removeFromSuperview()
            
            label.text = text
            label.alpha = 1.0
            label.transform = CGAffineTransform.identity
        }
        
    }
    
    
    func p_planeDepart() {
        let originalCenter = planeImage.center
        UIView.animateKeyframes(withDuration: 1.5, delay: 0.0, options: [], animations: {
            /**
             *	frameStartTime 关键帧动画的百分比
             frameDuration  关键帧动画的百分比 0.25 就是25%
             
             */
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25, animations: {
                self.planeImage.center.x += 80.0
                self.planeImage.center.y -= 10.0
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.4, animations: { () -> Void in
                self.planeImage.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 4/2))
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25, animations: { () -> Void in
                self.planeImage.center.x += 100.0
                self.planeImage.center.y -= 50.0
                self.planeImage.alpha = 0.0
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.51, relativeDuration: 0.01, animations: { () -> Void in
                self.planeImage.transform = CGAffineTransform.identity
                self.planeImage.center = CGPoint(x: 0.0, y: originalCenter.y)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.55, relativeDuration: 0.45, animations: { () -> Void in
                self.planeImage.alpha = 1.0
                self.planeImage.center = originalCenter
            })
            
            }, completion: nil)
        
        /**
         关键帧动画是不支持系统内部的缓冲曲线动画的，这是因为，关键帧动画是在指定的时间内，平滑的从一个阶段过渡到下一个阶段，要是中间阶段有缓冲的话，就会有非常尴尬的效果，我们也不能对整个的动画，加缓冲的曲线，这样的效果、选项是被忽略的
         */
        
    }
    
    func p_summarySwitchTo(_ summaryText: String) {
        UIView.animateKeyframes(withDuration: 1.0, delay: 0.0, options: [], animations: { 
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.45, animations: { 
                self.summary.center.y -= 100.0
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.45, relativeDuration: 0.01, animations: { 
                
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.45, animations: { 
                self.summary.center.y += 100.0
            })
            
        }, completion: nil)
        
        delay(seconds: 0.5) { 
            self.summary.text = summaryText
        }
    }
    
    
    func p_changeFlightDataTo(_ data: SGH0808FlightData, animated: Bool = false) {
        
        if animated {
            
            p_planeDepart()
            
            p_fadeImageView(bgImageView, toImage: UIImage(named: data.weatherImageName)!, showEffects: data.showWeatherEffects)
            //飞机型号动画
            let direction: SGHAnimationDirection = data.isTakingOff ? .positive : .negative
            p_cubeTransition(label: flightNr, text: data.flightNr, direction: direction)
            p_cubeTransition(label: gateNr, text: data.gateNr, direction: direction)
            //飞机图片两边的label的动画
            let offsetDeparting = CGPoint(x: CGFloat(direction.rawValue * 80), y: 0.0)
            p_moveLabel(departingFrom, text: data.departingFrom, offset: offsetDeparting)
            
            let offsetArriving = CGPoint(x: 0.0, y: CGFloat(direction.rawValue * 50))
            p_moveLabel(arrivingTo, text: data.arrivingTo, offset: offsetArriving)
            
            p_summarySwitchTo(data.summary)
            
        }
        else {
            bgImageView.image = UIImage(named: data.weatherImageName)
            snowView.isHidden = !data.showWeatherEffects
            
            flightNr.text = data.flightNr
            gateNr.text = data.gateNr
            departingFrom.text = data.departingFrom
            
            arrivingTo.text = data.arrivingTo
            flightStatus.text = data.flightStatus
            
            summary.text = data.summary
        }
        //populate the UI with the next flight's data
        
        
        //schedule next flight
        delay(seconds: 3.0) {
            self.p_changeFlightDataTo(data.isTakingOff ? parisToRome : londonToParis, animated: true)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
