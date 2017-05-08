//
//  DreamGenericViewController.swift
//  SwiftDemo160801
//
//  Created by huangaengoln on 2017/4/24.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

import UIKit

class DreamGenericViewController: UIViewController {

    
    
    
    //正常写法(Int类型)
    func add(a: Int, b: Int) -> Int {
        return a + b
    }
    //正常写法(Double类型)
    func add(c: Double, d: Double) -> Double {
        return c + d
    }
    //正常写法(Float类型)
    func add(e: Float, f: Float) -> Float {
        return e + f
    }
    
    //分析：存在什么问题吗？
    //加上我孟津县开发项目：保存数据到数据库？
    //很多模块？ 实体类(User/Student/Teacher/Order等等...)
    //问题在于：代码的冗余(编写了很多重复的代码),项目的扩展性越差
    //为了解决这个问题？
    //定义泛型来实现
    //func save(obj: NSObject) {
    //}
//    func save<T>(i: T, j: T) ->T {
//        return i + j
//    }

    //定义集合：Array集合 （保存任意对象，这个时候你该如何实现）
    override func viewDidLoad() {
        super.viewDidLoad()
        //OC开发
        //传统写法
        let array = NSMutableArray()
        let user = DreamUser()
        array.addObjects(from: [user])
        
        
        //现在获取这个数据，需要进行类型转换
        //并不知道具体的类型
        array.object(at: 0)
        //客户端在使用的时候就法案很坑爹
        //我们自己来定义一个数组，通过泛型实现，规定数据类型
        
        
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
