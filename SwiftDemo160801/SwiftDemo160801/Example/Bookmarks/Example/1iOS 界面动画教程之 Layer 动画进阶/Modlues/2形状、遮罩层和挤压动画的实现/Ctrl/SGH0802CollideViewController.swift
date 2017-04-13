//
//  SGH0802CollideViewController.swift
//  SwiftDemo160801
//
//  Created by huangaengoln on 16/8/2.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

import UIKit

func delay(seconds: Double, completion:@escaping ()->()) {
    let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds)) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: popTime) { 
        completion()
    }
    
}



class SGH0802CollideViewController: UIViewController {
    
    @IBOutlet weak var status: UILabel!
    
    
    @IBOutlet weak var vs: UILabel!
    @IBOutlet weak var opponentAvatar: SGHAvatarView!
    
    @IBOutlet weak var myAvatar: SGHAvatarView!
    
    @IBOutlet weak var searchAgain: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchAgain.alpha = 0.0
        vs.alpha = 0.0

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchForOpponent()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func actionSearchAgain(_ sender: AnyObject) {
        
        searchAgain.alpha = 0.0
        vs.alpha = 0.0
        opponentAvatar.image = UIImage(named: "empty")
        opponentAvatar.name = ""
        searchForOpponent()
    }

    
    func searchForOpponent() {
        
        let avatarSize = myAvatar.frame.size
        let bounceXOffset : CGFloat = avatarSize.width / 1.9
        let morphSize = CGSize(width: avatarSize.width * 0.85, height: avatarSize.height * 1.1)
        
        let rightBoucePoint = CGPoint(
            x: view.frame.size.width / 2.0 + bounceXOffset,
            y: myAvatar.center.y)
        let leftBouncePoint = CGPoint(
            x: view.frame.size.width / 2.0 - bounceXOffset,
            y: myAvatar.center.y)
        
        myAvatar.bounceOffPoint(rightBoucePoint, morphSize: morphSize)
        opponentAvatar.bounceOffPoint(leftBouncePoint, morphSize: morphSize)
        
        delay(seconds: 4.0, completion: foundOpponent)
        
        
    }
    
    func foundOpponent() {
        status.text = "Connecting..."
        
        opponentAvatar.image = UIImage(named: "avatar-2")
        opponentAvatar.name = "Ray"
        
        delay(seconds: 4.0, completion: connectedToOpponent)
    }
    
    func connectedToOpponent() {
        myAvatar.shouldTransitionToFinishedState = true
        opponentAvatar.shouldTransitionToFinishedState = true
        
        delay(seconds: 1.0, completion: completed)
    }
    
    func completed() {
        status.text = "Ready to play"
        UIView.animate(withDuration: 0.2, animations: {
            self.vs.alpha = 1.0
            self.searchAgain.alpha = 1.0
        }) 
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
