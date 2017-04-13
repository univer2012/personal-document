//
//  SGH1222POPAndCocoaViewController.swift
//  SwiftDemo160801
//
//  Created by huangaengoln on 2016/12/22.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

import UIKit

class SGH1222POPAndCocoaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        let request = UserRequest(name: "onevcat")
//        request.send { user in
//            if let user = user {
//                print("\(user.message) from \(user.name)")
//                //Welcome to MDCC 16! from onevcat
//            }
//        }
        
        URLSessionClient().send(UserRequest(name: "onevcat")) { user in
            if let user = user {
                print("\(user.message) from \(user.name)")
                //Welcome to MDCC 16! from onevcat
            }
            
        }
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
