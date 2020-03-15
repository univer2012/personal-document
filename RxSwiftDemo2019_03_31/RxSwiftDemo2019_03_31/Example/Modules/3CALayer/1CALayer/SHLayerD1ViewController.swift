//
//  SHLayerD1ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2020/3/15.
//  Copyright © 2020 远平. All rights reserved.
//

import UIKit

class SHLayerD1ViewController: UIViewController {
    
    var viewForLayer: UIView = UIView()
    
    var layer: CALayer {
        return viewForLayer.layer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        
        setUpLayer()
    }
    
    func setUpLayer() {
        layer.backgroundColor = UIColor.blue.cgColor
        layer.borderWidth = 100.0
        layer.borderColor = UIColor.red.cgColor
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 10.0
    }
    
    private func initUI() {
        view.addSubview(viewForLayer)
        viewForLayer.snp_makeConstraints { (make) in
            make.width.equalTo(300)
            make.height.equalTo(300)
            make.center.equalToSuperview()
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognized(_:)))
        let pin = UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureRecognized(_:)))
        self.view.addGestureRecognizer(tap)
        self.view.addGestureRecognizer(pin)
    }
    
    @objc func tapGestureRecognized(_ sender: UITapGestureRecognizer) {
        
    }
    @objc func pinchGestureRecognized(_ sender: UIPinchGestureRecognizer) {
        
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
