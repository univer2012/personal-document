//
//  SGH0803GradientLayerViewController.swift
//  SwiftDemo160801
//
//  Created by huangaengoln on 16/8/3.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

import UIKit

class SGH0803GradientLayerViewController: UIViewController {

    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var slideView: SGHAnimatedMaskLabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(SGH0803GradientLayerViewController.p_didSlide))
        slideView.addGestureRecognizer(swipe)
    }
    
    func p_didSlide() {
        //reveal the menu upon successful slide
        let image = UIImageView(image: UIImage(named: "meme"))
        image.center = view.center
        image.center.x += view.bounds.size.width
        view.addSubview(image)
        
        UIView.animate(withDuration: 0.33, delay: 0.0, options: [], animations: { 
            self.time.center.y -= 200.0
            self.slideView.center.y += 200.0
            image.center.x -= self.view.bounds.size.width
            }, completion: nil)
        
        UIView.animate(withDuration: 0.33, delay: 0.0, options: [], animations: { 
            self.time.center.y += 200.0
            self.slideView.center.y -= 200.0
            image.center.x += self.view.bounds.size.width
            }) { (_) in
                image.removeFromSuperview()
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
