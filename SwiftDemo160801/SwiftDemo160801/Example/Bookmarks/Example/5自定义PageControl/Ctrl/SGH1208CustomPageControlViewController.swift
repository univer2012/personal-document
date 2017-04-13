//
//  SGH1208CustomPageControlViewController.swift
//  SwiftDemo160801
//
//  Created by huangaengoln on 2016/12/8.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//


/*
 来自：https://github.com/kasper-lahti/PageControl
 */
import UIKit
//import PageControl

class SGH1208CustomPageControlViewController: UIViewController, UIScrollViewDelegate {
    
     var scrollView: UIScrollView!
     var pageControl: PageControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView = UIScrollView(frame: CGRect(x: 0, y: 80, width: self.view.frame.size.width, height: 300))
        scrollView.contentSize = CGSize(width: self.view.frame.size.width * 3, height: 300)
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        pageControl = PageControl(frame: CGRect(x: 0, y: 360, width: self.view.frame.size.width, height: 20))
        pageControl.backgroundColor = UIColor.clear
        pageControl.currentPage = 0
        pageControl.isUserInteractionEnabled = false
        pageControl.currentPageIndicatorTintColor = UIColor.blue
        pageControl.numberOfPages = 3
        pageControl.addTarget(self, action: #selector(pageControlDidChangeCurrentPage(_:)), for: .valueChanged)
        self.view.addSubview(pageControl)
        
        
        //let colorArray = [UIColor.red, UIColor.blue, UIColor.black]
        
        let screenWidth = self.view.frame.size.width
        let view1 = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 300))
        view1.backgroundColor = UIColor.red
        scrollView.addSubview(view1)
        
        let view2 = UIView(frame: CGRect(x: screenWidth, y: 0, width: screenWidth, height: 300))
        view2.backgroundColor = UIColor.gray
        scrollView.addSubview(view2)
        
        let view3 = UIView(frame: CGRect(x: screenWidth * 2, y: 0, width: screenWidth, height: 300))
        view3.backgroundColor = UIColor.black
        scrollView.addSubview(view3)
        
        // Do any additional setup after loading the view.
    }
    
    func pageControlDidChangeCurrentPage(_ pageControl: PageControl) {
        scrollView.setContentOffset(CGPoint(x: scrollView.bounds.width * CGFloat(pageControl.currentPage), y: 0), animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isDragging || scrollView.isDecelerating {
            let page = scrollView.contentOffset.x / scrollView.bounds.width
            pageControl.setCurrentPage(page)
        }
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
