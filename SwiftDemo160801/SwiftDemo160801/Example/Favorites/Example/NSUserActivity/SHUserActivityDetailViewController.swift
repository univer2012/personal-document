//
//  SHUserActivityDetailViewController.swift
//  SwiftDemo160801
//
//  Created by rrd on 2019/7/10.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

import UIKit

class SHUserActivityDetailViewController: UIViewController {
    var person: Person!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = person.name
        imageView.image = person.image
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
