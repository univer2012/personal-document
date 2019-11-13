import UIKit



let initialResult = 0
func combine(_ tempResult: Int, element: Int) -> Int {
    return tempResult + element
}
let reduceResult = combine(combine(combine(initialResult, element: 1), element: 3), element: 5)
print(reduceResult)
///打印：
///9




//var values = [1,3,5]
//let initialResult = 0
//let reduceResults = values.reduce(initialResult) { (tempResult, element) -> Int in
//    return tempResult + element
//}
//print(reduceResults)
/////打印：
/////9



//var values = [1,3,5,7,9]
//let flattenResults = values.filter{$0 % 3 == 0}
//print(flattenResults)
/////打印：
/////[3, 9]


//var values: [Int?] = [1,3,5,7,9,nil,10]
//let flattenResults = values.compactMap{ $0 }
//print(flattenResults)
/////打印：
/////[1, 3, 5, 7, 9, 10]


//var values = [[1,3,5,7],[9]]
//let flattenResults = values.flatMap{ $0 }
//print(flattenResults)
/////打印：
/////[1, 3, 5, 7, 9]



//var value: String? = "1"
//var result = value.flatMap{ Int($0)}.map { $0 * 2 }
//print(result)
/////打印：
/////Optional(2)


//var value: String? = "1"
//var result = value.flatMap{ Int($0)}
//print(result)
/////打印：
/////Optional(1)



//var value: String? = "1"
//var result = value.map{ Int($0)}
//print(result)
/////打印：
/////Optional(Optional(1))





#if false
var values = [1,3,5,7]
let results = values.map{ $0 * 2 }
print(results)
///打印：
///[2, 6, 10, 14]
#endif


#if false
var values = [1,3,5,7]
let results = values.map(){ $0 * 2 }
print(results)
///打印：
///[2, 6, 10, 14]
#endif


#if false
var values = [1,3,5,7]
let results = values.map ({ $0 * 2 })
print(results)
///打印：
///[2, 6, 10, 14]
#endif




#if false//true
var values = [1,3,5,7]
let results = values.map ({ element in element * 2 })
print(results)
///打印：
///[2, 6, 10, 14]
#endif





#if false
var values = [1,3,5,7]
let results = values.map ({ element in return element * 2 })
print(results)
///打印：
///[2, 6, 10, 14]
#endif



#if false
var values = [1,3,5,7]
let results = values.map ({ (element) -> Int in return element * 2 })
print(results)
///打印：
///[2, 6, 10, 14]
#endif





#if false
var values = [1,3,5,7]
let results = values.map { $0 * 2 }
print(results)
///打印：
///[2, 6, 10, 14]
#endif




#if false
var values = [1,3,5,7]
let results = values.map { (element) -> Int in
    return element * 2
}
print(results)
///打印：
///[2, 6, 10, 14]
#endif





#if false
var values = [1,3,5,7]
var results = [Int]()
for var value in values {
    value *= 2
    results.append(value)
}
print(results)
///打印：
///[2, 6, 10, 14]
#endif


#if false
///原来类型： Int?,返回值类型：String?
var value:Int? = nil
var result = value.map { String("result = \($0)") }
print(result)
///打印：
///nil
#endif

#if false
///原来类型： Int?,返回值类型：String?
var value:Int? = 1
var result = value.map { String("result = \($0)") }
print(result)
///打印：
///Optional("result = 1")
#endif

