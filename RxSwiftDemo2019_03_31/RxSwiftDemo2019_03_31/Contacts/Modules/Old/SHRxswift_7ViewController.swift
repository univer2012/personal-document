//
//  SHRxswift_7ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by rrd on 2019/6/26.
//  Copyright © 2019 远平. All rights reserved.
//
/**
 * 来自：[Swift - RxSwift的使用详解24（UI控件扩展4：UISwitch、UISegmentedControl）](https://www.jianshu.com/p/81f2d74d8308)
 */
import UIKit

import RxSwift
import RxCocoa

class SHRxswift_7ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var switch1: UISwitch!
    //分段选择控件
    @IBOutlet weak var segmented: UISegmentedControl!
    //图片显示控件
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var stepper: UIStepper!
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
//        activityIndicator.hidesWhenStopped = true
//        switch1.rx.value
//            .bind(to: activityIndicator.rx.isAnimating)
//            .disposed(by: disposeBag)
        
        switch1.rx.value
            .bind(to: UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: disposeBag)
        
//        segmented.rx.selectedSegmentIndex.asObservable()
//            .subscribe(onNext: {
//                print("当前项：\($0)")
//            })
//        .disposed(by: disposeBag)
        //创建一个当前需要显示的图片的可观察序列
        let showImageObservable: Observable<UIImage> = segmented.rx.selectedSegmentIndex.asObservable()
            .map {
                let images = [UIImage.image(withColor: .red),
                              UIImage.image(withColor: .gray),
                              UIImage.image(withColor: .blue)]
                return images[$0]!
        }
        //把需要显示的图片绑定到 imageView 上
        showImageObservable.bind(to: imageView.rx.image).disposed(by: disposeBag)
        
        
//        slider.rx.value.asObservable()
//            .subscribe(onNext: {
//                print("当前值为：\($0)")
//            })
//        .disposed(by: disposeBag)
        
        stepper.rx.value.asObservable()
            .subscribe(onNext: {
                print("当前值为：\($0)")
            })
            .disposed(by: disposeBag)
        
        slider.rx.value
            .map{Double($0)}  //由于slider值为Float类型，而stepper的stepValue为Double类型，因此需要转换
            .bind(to: stepper.rx.stepValue)
            .disposed(by: disposeBag)
        
    }
}
