//: Playground - noun: a place where people can play

import UIKit

/*:
 ### Tuple - Pack multiple values together
 + (200, "HTTP OK")
 + (404, "File not found")
 + ("Mars", 11, "11@boxue.io")
 
 */

//: #### Define a tuple 定义一个tuple
let success = (200, "HTTP OK")
let fileNotFound = (404, "File not found")
//可以给tuple中的每一个数据成员加上一个名字：
let me = (name: "Mars", no:11, email: "11@boxue.io")

//: #### Access tuple content 访问tuple中的数据成员
//使用tuple成员中的索引来访问它们：
success.0
success.1
fileNotFound.0
fileNotFound.1
//有名字时，可以使用tuple中成员的名字来访问它们：
me.name
me.no
me.email
//说明：通常不要使用`success.0`、`success.1`的方式来访问数据成员，因为时间久了之后，我们不记得0代表code，1代表message

//: Tuple decomposition  ---- tuple分解
var (successsCode, successMessage) = success
print(successsCode)
print(successMessage)
//修改 successsCode 的值，并不会影响 `success` tuple：
successsCode = 201
success

//当我们只想访问tuple中特定数据成员时，我们可以在不需要的数据成员的位置填写`_`：
let (_, errorMessage) = fileNotFound
print(errorMessage)


//: Type ----tuple变量的类型
/*
 success - (Int, String)
 me - (String, Int, String)
 */





