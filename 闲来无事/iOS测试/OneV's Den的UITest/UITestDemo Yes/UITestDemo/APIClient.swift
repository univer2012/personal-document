//
//  APIClient.swift
//  UITestDemo
//
//  Created by Wei Wang on 15/9/9.
//  Copyright © 2015年 OneV's Den. All rights reserved.
//

import Foundation

let userInfo = ["onevcat": "123"]

struct APIClient {
    
    enum APIError {
        case EmptyUserName, EmptyPassword, UserNotFound, WrongPassword
    }
    
    static func login(userName: String, password: String, completionHandler: ((Bool, APIError?) -> ())?) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            if userName.count == 0 {
                completionHandler?(false, .EmptyUserName)
                return
            }
            
            if password.count == 0 {
                completionHandler?(false, .EmptyPassword)
                return
            }
            
            if !userInfo.keys.contains(userName) {
                completionHandler?(false, .UserNotFound)
                return
            }
            
            if userInfo[userName] != password {
                completionHandler?(false, .WrongPassword)
                return
            }
                        
            completionHandler?(true, nil)
        }
        
    }
}
