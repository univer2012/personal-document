//
//  ViewController.swift
//  Tip1柯里化Currying
//
//  Created by huangaengoln on 16/4/2.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

import UIKit

//import SGHDemo

protocol TargetAction {
    func performAction()
}

struct TargetActionWrapper<T: AnyObject> : TargetAction {
    weak var target: T?
    let action: (T) -> () -> ()
    func performAction() {
        if let t = target {
            action(t)()
        }
    }
}

enum ControlEvent {
    case TouchUpInside
    case ValueChanged
    // ...
}
class Control:UIButton {
    var actions = [ControlEvent: TargetAction]()
    func setTarget<T: AnyObject>(target: T, action: (T) -> () -> (), controlEvent: ControlEvent) {
        actions[controlEvent] = TargetActionWrapper(target: target, action: action)
    }
    
    func removeTargetForControlEvent(controlEvent: ControlEvent) {
        actions[controlEvent] = nil
    }
    
    func performActionForControlEvent(controlEvent: ControlEvent)  {
        actions[controlEvent]?.performAction()
    }
    
}
//使用

class ViewController: UIViewController {
    let button = Control()
    override func viewDidLoad() {
        super.viewDidLoad()
        button.frame = CGRectMake(20, 80, CGRectGetWidth(self.view.frame) - 20 * 2, 40)
        button.backgroundColor = UIColor.blueColor();
        button.setTarget(self, action: ViewController.onButtonTap, controlEvent: .TouchUpInside)
        self.view.addSubview(button)
        
        //例子1
        let addTwoFour = addTwoNumbers(4)
        let result = addTwoFour(num: 6)
        print(result)
        
        // 例子2
        let greaterThan10 = greaterThan(10)
        print(greaterThan10(input: 13))
        print(greaterThan10(input: 9))
        
        
    }
    
    
    func onButtonTap() {
        print("Button was tapped")
    }
    //例子1
    func addTwoNumbers(a: Int)(num: Int) -> Int {
        return a + num
    }
    //例子2
    func greaterThan(comparor: Int)(input: Int) -> Bool {
        return input > comparor
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

