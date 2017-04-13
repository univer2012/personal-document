//
//  SGH0819AdvancedAutoLayoutViewController.swift
//  SwiftDemo160801
//
//  Created by huangaengoln on 16/8/19.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//
/*
 · 创建约束动画
 · 查看UI元素的约束
 · 替换的方式创建约束动画
 · 动画方式动态创建视图
 */
import UIKit

class SGH0819AdvancedAutoLayoutViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var buttonMenu: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var menuHeightConstraint: NSLayoutConstraint!
    
    
    

    //MARK: further class variables
    var slider: SGH0819HorizonalItemList!
    var isMenuOpen = false
    var items: [Int] = [5, 6, 7]
    
    //MARK: class methods
    @IBAction func actionToggleMenu(_ sender: AnyObject) {
        
        for con in titleLabel.superview!.constraints {
            print(" -> \(con.description)")
        }
        
        isMenuOpen = !isMenuOpen
        
        for constraint in titleLabel.superview!.constraints {
            if constraint.firstItem as? NSObject == titleLabel && constraint.firstAttribute == .centerX {
                constraint.constant = isMenuOpen ? -100.0 : 0.0
                continue
            }
            
            if constraint.identifier == "TitleCenterY" {
                constraint.isActive = false
                
                //创建一个新的约束
                let newConstraint = NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: titleLabel.superview, attribute: .centerY, multiplier: isMenuOpen ? 0.67 : 1.0, constant: 5.0)
                
                newConstraint.identifier = "TitleCenterY"
                newConstraint.isActive = true
                
                
                continue
            }
        }
        
        menuHeightConstraint.constant = isMenuOpen ? 200.0 : 60.0
        titleLabel.text = isMenuOpen ? "Select item" : "Packing List"
        
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 10.0, options: .curveEaseIn, animations: { 
            self.view.layoutIfNeeded()
            let angle = self.isMenuOpen ? CGFloat(M_PI_4) : 0.0
            self.buttonMenu.transform = CGAffineTransform(rotationAngle: angle)
            }, completion: nil)
        
        if isMenuOpen {
            slider = SGH0819HorizonalItemList(inView: view)
            slider.didSelectItem = { index in
                print("add \(index)")
                self.items.append(index)
                self.tableView.reloadData()
                self.actionToggleMenu(self)
            }
            self.titleLabel.superview!.addSubview(slider)
        }
        else {
            slider.removeFromSuperview()
        }
        
        
    }
    
    
    func showItem(_ index: Int) {
        print("tapped item \(index)")
        
        let imageView = UIImageView(image: UIImage(named: "summericons_100px_0\(index).png"))
        imageView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        imageView.layer.cornerRadius = 5.0
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        if #available(iOS 9.0, *) {
            let conX = imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            let conBottom = imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: imageView.frame.height)
            let conWidth = imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33, constant: -50.0)
            //imageView高度等于其宽度
            let conHeight = imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
            NSLayoutConstraint.activate([conX, conBottom, conWidth, conHeight])
            
            view.layoutIfNeeded()
            
            
            UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, options: [], animations: { 
                conBottom.constant = -imageView.frame.size.height / 2
                conWidth.constant = 0.0
                self.view.layoutIfNeeded()
                }, completion: nil)
            
            UIView.animate(withDuration: 0.8, delay: 1.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, options: [], animations: { 
                conBottom.constant = imageView.frame.size.height
                conWidth.constant = -50.0
                self.view.layoutIfNeeded()
                }, completion: { (_) in
                    imageView.removeFromSuperview()
            })
            
        }
        
        
        
        
        
        
        
    }

}
#if false
let itemTitles = ["Icecream money",
                  "Great weather",
                  "Beach ball",
                  "Swim suit for him",
                  "Swim suit for her",
                  "Beach games",
                  "Ironing board",
                  "Cocktail mood",
                  "Sunglasses",
                  "Flip flops"]
#endif

extension SGH0819AdvancedAutoLayoutViewController: UITableViewDelegate, UITableViewDataSource {
    //MARK: View Controller methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView?.rowHeight = 54.0
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    //MARK: Table View methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        cell.accessoryType = .none
        cell.textLabel?.text = itemTitles[items[indexPath.row]]
        cell.imageView?.image = UIImage(named: "summericons_100px_0\(items[indexPath.row]).png")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showItem(items[indexPath.row])
    }
    
}
