//
//  SGH1213TrackProgramViewController.swift
//  SwiftDemo160801
//
//  Created by huangaengoln on 2016/12/13.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

/*
 例子来自：http://blog.callmewhy.com/2015/04/20/error-handling-in-swift/
 标题：面向轨道编程 - Swift 中的异常处理
 */

import UIKit
//传统写法
#if false
let errorStr = "输入错误，我很抱歉"
func cal(_ value: Float) {
    if value == 0 {
        print(errorStr)
    }
    else {
        let value1 = 2 / value
        let value2 = value1 - 1
        if value2 == 0 {
            print(errorStr)
        }
        else {
            let value3 = 4 / value2
            print(value3)
        }
    }
}
#endif
//那么用面向轨道的思想怎么去解决这个问题呢？

//大概是这个样子的：
final class Box<T> {
    let value: T
    init(value: T) {
        self.value = value
    }
}

#if false
enum Result<T> {
    case Success(Box<T>)
    case Failure(String)
}
let errorStr1 = "输入错误，我很抱歉"
func cal1(_ value: Float) {
    func calOne(_ value: Float) -> Result<Float> {
        if value == 0 {
            return .Failure(errorStr1)
        }
        else {
            return .Success(Box(value: 2 / value))
        }
    }
    
    func calTwo(value: Result<Float>) -> Result<Float> {
        switch value {
        case .Success(let v):
            return .Success(Box(value: v.value - 1))
        case .Failure(let str):
            return .Failure(str)
        }
    }
    
    func calThree(value: Result<Float>) -> Result<Float> {
        switch value {
        case .Success(let v):
            if v.value == 0 {
                return .Failure(errorStr1)
            }
            else {
                return .Success(Box(value: 4 / v.value))
            }
            
        case .Failure(let str):
            return .Failure(str)
        }
    }
    
    let r = calThree(value: calTwo(value: calOne(value)))
    switch r {
    case .Success(let v):
        print(v.value)
    case .Failure(let s):
        print(s)
    }
}
#endif
//同学，放下手里的键盘，冷静下来，有话好好说。

// ==== 反思

//面向轨道之后，代码量翻了两倍多，而且似乎变得更难读了。浪费了大家这么多时间结果就带来这么个玩意儿，实在是对不起观众们热情的掌声。

//仔细看下上面的代码， switch 的操作重复而多余，都在重复着把 Success 和 Failure 分开的逻辑，实际上每个函数只需要处理 Success 的情况。我们在 Result 中加入 funnel 提前处理掉 Failure 的情况：
enum Result<T> {
    case Success(Box<T>)
    case Failure(String)
    
    func funnel<U>(_ f:(T) -> Result<U>) -> Result<U> {
        switch self {
        case .Success(let value):
            return f(value.value)
        case .Failure(let errString):
            return Result<U>.Failure(errString)
            
        }
    }
}
//funnel 帮我们把上次的结果进行分流，只将 Success 的轨道对接到了下个业务上，而将 Failure 引到了下一个 Failure 轨道上。

//接下来再回到栗子里，此时我们已经不再需要传入 Result 值了，只需要传入 value 即可：
let errorStr = "输入错误，我很抱歉"
func cal(_ value: Float) {
    //构造计算的函数
    func cal1(_ v: Float) -> Result<Float> {
        if v == 0 {
            return .Failure(errorStr)
        }
        else {
            return .Success(Box(value: 2 / v))
        }
    }
    
    func cal2(_ v: Float) -> Result<Float> {
        return .Success(Box(value: v - 1))
    }
    
    func cal3(_ v: Float) -> Result<Float> {
        if  v == 0 {
            return .Failure(errorStr)
        }
        else {
            return .Success(Box(value: 4 / v))
        }
    }
    //开始计算并处理结果
    let r = cal1(value).funnel(cal2).funnel(cal3)
    switch r {
    case .Success(let v):
        print(v.value)
    case .Failure(let s):
        print(s)
    }
    
}
//看起来简洁了一些。我们可以通过 cal1(value).funnel(cal2).funnel(cal3) 这样的链式调用来获取计算结果。

//“面向轨道”编程确实给我们提供了一个很有趣的思路。本文只是一个简单地讨论，进一步学习可以仔细阅读后面的参考文献。比如 ValueTransformation.swift 这个真实的完整案例，以及 antitypical/Result 这个封装完整的 Result 库。文中的实现方案只是一个比较简单的方法，和前两种实现略有差异。



class SGH1213TrackProgramViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        #if false
        cal(2)
        cal(1)
        cal(0)
        #endif
        
        #if false
        cal1(2)
        cal1(1)
        cal1(0)
        #endif
        
        cal(2)
        cal(1)
        cal(0)
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
