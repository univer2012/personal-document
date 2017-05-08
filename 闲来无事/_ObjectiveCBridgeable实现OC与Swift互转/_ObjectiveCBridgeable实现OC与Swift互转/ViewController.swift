//
//  ViewController.swift
//  _ObjectiveCBridgeable实现OC与Swift互转
//
//  Created by huangaengoln on 15/11/4.
//  Copyright © 2015年 huangaengoln. All rights reserved.
//



import UIKit

struct SwiftMobile {
    let brand:String
    let system:String
}
#if true//false
extension SwiftMobile :_ObjectiveCBridgeable {
    typealias _ObjectiveCType=Mobile
    //判断是否能转换成 Objective-C 对象
    static func _isBridgedToObjectiveC() -> Bool {
        return true
    }
    //获取转换的目标类型
    static func _getObjectiveCType() -> Any.Type {
        return _ObjectiveCType.self
    }
    //转化成 Objective-C 对象
    func _bridgeToObjectiveC() -> _ObjectiveCType {
        return Mobile(brand: brand, system: system)
    }
    //强制将 Objective-C 对象转换成Swift结构体类型
    static func _forceBridgeFromObjectiveC(_ source: _ObjectiveCType, result: inout SwiftMobile?) {
        result=SwiftMobile(brand: source.brand, system: source.system)
    }
    //有条讲地将 Objective-C 对象转换成Swift结构体类型
    static func _conditionallyBridgeFromObjectiveC(_ source: _ObjectiveCType, result: inout SwiftMobile?) -> Bool {
        _forceBridgeFromObjectiveC(source, result: &result)
        return true
    }
}
#endif



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        #if false
        let mobile=["iPhone","Nokia","小米Note"]
        let mobile1=(mobile as NSArray).objectAtIndex(1)
        print(mobile1)
        
        let animalArray=NSArray(objects: "lion","tiger","monkey")
        let animalCount=animalArray as Array
        print(animalCount)
        /* 输出 :
        Nokia
        [lion, tiger, monkey]      */
        #elseif false
        
        let mobile=Mobile(brand: "iPhone", system: "iOS 9.0")
        let swiftMobile=mobile as SwiftMobile
        print("\(swiftMobile.brand) : \(swiftMobile.system)")
        let swiftMobile2=SwiftMobile(brand: "Galaxy Note 3 Lite", system: "Android 5.0")
        let mobile2=swiftMobile2 as Mobile
        print("\(mobile2.brand) : \(mobile2.system)")
        /* 输出 :
        iPhone : iOS 9.0
        Galaxy Note 3 Lite : Android 5.0        */
        #elseif false
        
        let sm1=SwiftMobile(brand: "iPhone", system: "iOS 9.0")
        let sm2=SwiftMobile(brand: "Galaxy Note 3", system: "Android 5.0")
        let sm3=SwiftMobile(brand: "小米", system: "Android 4.0")
        let mobiles=[sm1,sm2,sm3]
        let mobileArray=mobiles as NSArray
        print(mobileArray)
        for i in 0..<mobiles.count {
            print("\(mobileArray.objectAtIndex(i).brand) : \(mobileArray.objectAtIndex(i).system)")
            /* 输出 :
            (
            "<Mobile: 0x7f978ad3ba90>",
            "<Mobile: 0x7f978ad3b4a0>",
            "<Mobile: 0x7f978ad3b520>"
            )
            iPhone : iOS 9.0
            Galaxy Note 3 : Android 5.0
            小米 : Android 4.0                */
        }
        #elseif false
        
        let numbers=[1,29,40]
        let numberArray=(numbers as NSArray).objectAtIndex(2)
        print(type(of: numberArray))
        /* 输出 :
        __NSCFNumber        */
        #endif
        
//        var  objects=[NSObject(),NSObject(),NSObject()]
//        var objectArray=objects as NSMutableArray
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

