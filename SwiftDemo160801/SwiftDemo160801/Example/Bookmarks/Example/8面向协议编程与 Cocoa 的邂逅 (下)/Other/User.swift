//
//  User.swift
//  SwiftDemo160801
//
//  Created by huangaengoln on 2016/12/22.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

import Foundation

struct User {
    let name: String
    let message: String
    
    init?(data: Data) {
        guard let obj = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            return nil
        }
        
        guard let name = obj["name"] as? String else {
            return nil
        }
        
        guard let message = obj["message"] as? String else {
            return nil
        }
        self.name = name
        self.message = message
    }
}

enum HTPMethod: String {
    case GET
    case POST
}

protocol Request {
//    var host: String { get }
    var path: String { get }
    
    var method: HTPMethod { get }
    var parameter: [String: Any] {get}
    
//    associatedtype Response
//    func parse(data: Data) -> Response?
    associatedtype Response: Decodable
}

struct UserRequest: Request {
    let name: String
//    let host = "https://api.onevcat.com"
    var path: String {
        return "/users/\(name)"
    }
    let method: HTPMethod = .GET
    let parameter: [String : Any] = [:]
    
    typealias Response = User
//    func parse(data: Data) -> User? {
//        return User(data: data)
//    }
}


//extension Request {
//    func send(handler: @escaping (Response?) -> Void) {
//        //...send的实现
//        let url = URL(string: host.appending(path))!
//        var request = URLRequest(url: url)
//        request.httpMethod = method.rawValue
//        
//        let task = URLSession.shared.dataTask(with: request) {
//            data, _, error in
//            //处理结果
//            //print(data)
//            if let data = data, let res = self.parse(data: data) {
//                DispatchQueue.main.async {
//                    handler(res)
//                }
//            } else {
//                DispatchQueue.main.async {
//                    handler(nil)
//                }
//            }
//        }
//        task.resume()
//    }
//}
//MARK:开始重构
// 定义一个可以发送请求的协议
protocol Client {
    //func send(_ r: Request, handler: @escaping (Request.Response?) -> Void)
    //从上面的声明从语义上来说是挺明确的，但是因为 Request 是含有关联类型的协议，所以它并不能作为独立的类型来使用，我们只能够将它作为类型约束，来限制输入参数 request
    
    func send<T: Request>(_ r: T, handler: @escaping (T.Response?) -> Void)
    var host: String { get }
}
struct URLSessionClient: Client {
    let host = "https://api.onevcat.com"
    
    func send<T : Request>(_ r: T, handler: @escaping (T.Response?) -> Void) {
        let url = URL(string: host.appending(r.path))!
        var request = URLRequest(url: url)
        request.httpMethod = r.method.rawValue
        
        let task = URLSession.shared.dataTask(with: request) {
            data, _, error in
            //处理结果
            //print(data)
//            if let data = data, let res = r.parse(data: data) {
            if let data = data, let res = T.Response.parse(data: data) {
                DispatchQueue.main.async {
                    handler(res)
                }
            } else {
                DispatchQueue.main.async {
                    handler(nil)
                }
            }
        }
        task.resume()
    }
}
//响应
protocol Decodable {
    static func parse(data: Data) -> Self?
}

extension User: Decodable {
    static func parse(data: Data) -> User? {
        return User(data: data)
    }
}














