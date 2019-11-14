//
//  SHRxswift_59ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by 远平 on 2019/11/14.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SHRxswift_59ViewController: UIViewController {
    let disposeBag = DisposeBag()
    //拍照按钮
    @IBOutlet weak var cameraButton: UIButton!
    
    //选择照片按钮
    @IBOutlet weak var galleryButton: UIButton!
    
    //选择照片并裁减按钮
    @IBOutlet weak var cropButton: UIButton!
    
    //显示照片的imageView
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //初始化图片控制器
        let imagePicker = UIImagePickerController()
        
        //判断并决定“z拍照”按钮是否可用
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        //“拍照”按钮点击
        cameraButton.rx.tap.bind { [weak self] (_) -> Void in
            imagePicker.sourceType = .camera    //来源为相机
            
        }
    }
}
