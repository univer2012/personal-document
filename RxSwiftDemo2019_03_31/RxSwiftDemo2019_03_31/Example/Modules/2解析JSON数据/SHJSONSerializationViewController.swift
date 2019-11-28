//
//  SHJSONSerializationViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by Mac on 2019/11/28.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit

import SwiftyJSON
import Alamofire

class SHJSONSerializationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let label = UILabel(frame: CGRect(x: 100, y: 100, width: 300, height: 100))
        label.text = "输出结果在控制台"
        self.view.addSubview(label)
        
        //testJson()
        //testJson2()
        //serialization()
        //swiftyJSON()
        
        //networkRequest()
        requestAlamofire()
    }
    

}

extension SHJSONSerializationViewController {
    
    func requestAlamofire() {
        //创建URL对象
        //原地址无效：http://www.hangge.com/getJsonData.php
        let url = URL(string: "https://www.douban.com/j/app/radio/channels")!
        
        Alamofire.request(url).validate().responseJSON { (response) in
            switch response.result.isSuccess {
            case true:
                if let value = response.result.value {
                    let json = JSON(value)
                    if let name  = json["channels"][0]["name"].string {
                        //找到频道的名字
                        print("第一个频道的名字：",name)
                    }
                }
            case false:
                print(response.result.error)
            }
        }
    }
    
    
    
    
    func networkRequest() {
        //创建URL对象
        //原地址无效：http://www.hangge.com/getJsonData.php
        let url = URL(string: "https://www.douban.com/j/app/radio/channels")
        //创建请求对象
        let request = URLRequest(url: url!)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error)
            } else {
                
                if let tempData = data,
                    let json = try? JSON(data: tempData),
                    let name  = json["channels"][0]["name"].string {
                    //找到频道的名字
                    print("第一个频道的名字：",name)
                }
            }
        } as URLSessionTask
        
        //使用resume方法启动任务
        dataTask.resume()
    }
    
    
    
    func swiftyJSON() {
        let jsonStr = "[{\"name\": \"hangge\", \"age\": 100, \"phones\": [{\"name\": \"公司\",\"number\": \"123456\"}, {\"name\": \"家庭\",\"number\": \"001\"}]}, {\"name\": \"big boss\",\"age\": 1,\"phones\": [{ \"name\": \"公司\",\"number\": \"111111\"}]}]"
        
        if let jsonData = jsonStr.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            
            let json = try! JSON(data: jsonData)
            if let number = json[0]["phones"][0]["number"].string {
                //找到电话号码
                print("第一个联系人的第一个电话号码：",number)
            } else {
                //打印错误信息
                print(json[0]["phones"][0]["number"])
            }
        }
    }
    
    
    
    func serialization() {
        let jsonStr = "[{\"name\": \"hangge\", \"age\": 100, \"phones\": [{\"name\": \"公司\",\"number\": \"123456\"}, {\"name\": \"家庭\",\"number\": \"001\"}]}, {\"name\": \"big boss\",\"age\": 1,\"phones\": [{ \"name\": \"公司\",\"number\": \"111111\"}]}]"
        
        if let jsonData = jsonStr.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            //... ...
            if let userArray = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [[String: AnyObject]],
                let number = (userArray?[0]["phones"] as? [[String: AnyObject]])?[0]["number"] as? String {
                
                //找到电话号码
                print("第一个联系人的第一个电话号码：",number)
            }
            
            
            
//            if let userArray = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [[String: AnyObject]],
//                let phones = userArray?[0]["phones"] as? [[String: AnyObject]],
//                let number = phones[0]["number"] as? String {
//
//                //找到电话号码
//                print("第一个联系人的第一个电话号码：",number)
//            }
        }
    }
}


extension SHJSONSerializationViewController {
    func testJson() {
        //Swift对象
        let user: [String: Any] = [
            "uname":"张三",
            "tel":["mobile":"138", "home":"010"]
        ]
        
        //首先判断能不能转换
        if !JSONSerialization.isValidJSONObject(user) {
            print("is not a valid json object")
            return
        }
        
        //利用自带的json库转换成Data
        //如果设置options为JSONSerialization.WritingOptions.prettyPrinted，则打印格式更好阅读
        let data = try? JSONSerialization.data(withJSONObject: user, options: [])
        //Data转换成String打印输出
        let str = String(data: data!, encoding: String.Encoding.utf8)
        //输出json字符串
        print("Json Str:")
        print(str ?? "")
        
        //MARK: 把Data对象转换回JSON对象
        let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: Any]
        print("Json Object:",json ?? [:])
        //验证JSON对象可用性
        let uname = json?["uname"]
        let mobile = (json?["tel"] as! [String: Any]) ["mobile"]
        print("get Json Object:", "uname:\(String(describing: uname)), mobile: \(String(describing: mobile))")
        
    }
    
    func testJson2() {
        let string = "[{\"ID\":1,\"Name\":\"元台禅寺\",\"LineID\":1},{\"ID\":2,\"Name\":\"田坞里山塘\",\"LineID\":1},{\"ID\":3,\"Name\":\"滴水石\",\"LineID\":1}]"
        let data = string.data(using: String.Encoding.utf8)
        
        let jsonArr = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String: Any]]
        
        print("记录数： \(jsonArr.count)")
        for json in jsonArr {
            print("ID: ",json["ID"]!, "      Name: ",json["Name"]!)
        }
    }
}
