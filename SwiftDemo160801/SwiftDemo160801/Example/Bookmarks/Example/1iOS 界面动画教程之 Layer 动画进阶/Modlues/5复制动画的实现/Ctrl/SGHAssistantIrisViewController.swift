//
//  SGHAssistantIrisViewController.swift
//  SwiftDemo160801
//
//  Created by huangaengoln on 16/8/4.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

import UIKit

class SGHAssistantIrisViewController: UIViewController {

    
    @IBOutlet weak var meterLabel: UILabel!
    
    @IBOutlet weak var speakButton: UIButton!
    
    let monitor = SGH0804MicMonitor()
    let assistant = SGH0804Assistant()
    
    //对于缩放的动画，我们需要将最后的比例存储到这个变量
    var lastTransformScale : CGFloat = 0.0
    //重复符号
    let replicator = CAReplicatorLayer()
    //点
    let dot = CALayer()
    //点的宽度和高度
    let dotLength : CGFloat = 6.0
    //点的偏移
    let dotOffset: CGFloat = 8.0
    
    
    
    /**
     我们为什么要复制图片，因为它绝对不是简单的复制，我们可以让每一个克隆体都有微小的变化。例如我们可以逐步的改变克隆体的色调，
     */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //使replicator层的大小与控制器大小完全一样，并作为子视图添加到view中
        replicator.frame = view.bounds
        view.layer.addSublayer(replicator)
        
        
        //dot在视图最右边的(竖直方向的)中间，
        dot.frame = CGRect(x: replicator.frame.size.width - dotLength, y: replicator.position.y, width: dotLength, height: dotLength)
        //背景色
        dot.backgroundColor = UIColor.lightGray.cgColor
        //边的颜色
        dot.borderColor = UIColor(white: 1.0, alpha: 1.0).cgColor
        //边的宽度
        dot.borderWidth = 0.5
        //圆角
        dot.cornerRadius = 1.5
        //把dot添加到replicator层中
        replicator.addSublayer(dot)
        
        //实例数量。此时运行还是只有一个点，是因为全部点重叠在一起了，要设置子layer的偏移
        replicator.instanceCount = Int(view.frame.width / dotOffset)
        
        //子layer的x、y、z方向的偏移
        replicator.instanceTransform = CATransform3DMakeTranslation(-dotOffset, 0, 0)
        
        #if false
        // 测试动画
        let move = CABasicAnimation(keyPath: "position.y")
        move.fromValue = dot.position.y
        move.toValue = dot.position.y - 50.0
        move.duration = 1.0
        move.repeatCount = 10
        dot.addAnimation(move, forKey: nil)
        #endif
        
        
        //每个实例一次延迟的时间
        replicator.instanceDelay = 0.02
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //当用户按住按钮时，会激活这个方法
    @IBAction func actionStartMonitoring(_ sender: AnyObject) {
        //改变dot的颜色为绿色
        dot.backgroundColor = UIColor.green.cgColor
        
        //开始监听。level是声音的大小
        monitor.startMointoringWithHandler { (level) in
            self.meterLabel.text = String(format: "%.2f db", level)
            
            //缩放因子在 0.1 ~ 25.0 之间
            let scaleFactor = max(0.2, CGFloat(level) + 50) / 2

            //只针对y轴方向比例缩放，缩放的效果是从前一个比例变到最新的比例
            let scale = CABasicAnimation(keyPath: "transform.scale.y")
            scale.fromValue = self.lastTransformScale
            scale.toValue = scaleFactor
            scale.duration = 0.1
            scale.isRemovedOnCompletion = false
            scale.fillMode = CAMediaTimingFillMode.forwards
            self.dot.add(scale, forKey: nil)
            
            //保存这个 scale
            self.lastTransformScale = scaleFactor
        }
        
    }

    @IBAction func actionEndMonitoring(_ sender: AnyObject) {
        //禁止麦克风的监听，
        monitor.stopMonitoring()
        //移除dot上所有的动画
        dot.removeAllAnimations()
        
        //speak after 1 second
        delay(seconds: 1.0) { 
            self.p_startSpeaking()
        }
        
        
    }
    
    
    func p_startSpeaking() {
        print("speak back")
        //获取一个文字
        meterLabel.text = assistant.randomAnswer()
        //调用speak读这段文字，读完后调用p_endSpeaking()
        assistant.speak(meterLabel.text!) {
            self.p_endSpeaking()
        }
        speakButton.isHidden = true
        
        //缩放dot的大小，让它在水平方向扩大1.4倍，在垂直方向扩大15倍
        let scale = CABasicAnimation(keyPath: "transform")
        scale.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        scale.toValue = NSValue(caTransform3D: CATransform3DMakeScale(1.4, 15, 1.0))
        scale.duration = 0.33
        scale.repeatCount = Float.infinity
        //往返变
        scale.autoreverses = true
        scale.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        dot.add(scale, forKey: "dotScale")
        
        
        //淡入淡出
        let fade = CABasicAnimation(keyPath: "opacity")
        fade.fromValue = 1.0
        fade.toValue = 0.2
        fade.duration = 0.33
        //0.33的延时
        fade.beginTime = CACurrentMediaTime() + 0.33
        fade.repeatCount = Float.infinity
        fade.autoreverses = true
        fade.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        dot.add(fade, forKey: "dotOpacity")
        
        
        //改变背景色：从洋红色过渡到青灰色
        let tint = CABasicAnimation(keyPath: "backgroundColor")
        tint.fromValue = UIColor.magenta.cgColor
        tint.toValue = UIColor.cyan.cgColor
        tint.duration = 0.66
        //0.28秒的延时，
        tint.beginTime = CACurrentMediaTime() + 0.28
        tint.repeatCount = Float.infinity
        tint.autoreverses = true
        fade.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        dot.add(tint, forKey: "dotColor")
        
        
        //旋转已经变形了的克隆体，旋转在0.0~0.01弧度之间，
        let initialRotation = CABasicAnimation(keyPath: "instanceTransform.rotation")
        initialRotation.fromValue = 0.0
        initialRotation.toValue = 0.01
        initialRotation.duration = 0.33
        initialRotation.isRemovedOnCompletion = false
        initialRotation.fillMode = CAMediaTimingFillMode.forwards
        initialRotation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        replicator.add(initialRotation, forKey: "initialRotation")
        
        
        //这个动画是在前一个动画的后面才开始的。
        let rotation = CABasicAnimation(keyPath: "instanceTransform.rotation")
        rotation.fromValue = 0.01
        rotation.toValue = -0.01
        rotation.duration = 0.99
        rotation.beginTime = CACurrentMediaTime() + 0.33
        rotation.repeatCount = Float.infinity
        rotation.autoreverses = true
        rotation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        replicator.add(rotation, forKey: "replicatorRotation")
        
    }
    
    
    func p_endSpeaking() {
        //移除所有的动画效果
        replicator.removeAllAnimations()
        
        //用动画回归到原始的状态
        let scale = CABasicAnimation(keyPath: "transform")
        scale.toValue = NSValue(caTransform3D: CATransform3DIdentity)
        scale.duration = 0.33
        scale.isRemovedOnCompletion = false
        scale.fillMode = CAMediaTimingFillMode.forwards
        dot.add(scale, forKey: nil)
        
        
        //移除dot的2个动画，设置dot的背景色
        dot.removeAnimation(forKey: "dotColor")
        dot.removeAnimation(forKey: "dotOpacity")
        dot.backgroundColor = UIColor.lightGray.cgColor
        //显示speak按钮
        speakButton.isHidden = false
        
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
