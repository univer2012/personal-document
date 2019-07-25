import UIKit

//var str = "Hello, playground"
/*
 来自：
 1. [查找最大／最小值(Select Minimum / Maximum)](https://github.com/andyRon/swift-algorithm-club-cn/tree/master/Select%20Minimum%20Maximum)
 2. [Select Minimum Maximum](https://github.com/andyRon/swift-algorithm-club/tree/master/Select%20Minimum%20Maximum)
 */
//求最小值
func minimum<T: Comparable>(_ array: [T]) -> T? {
    guard var minimum = array.first else { return nil }
    for element in array.dropFirst() {
        minimum = element < minimum ? element : minimum
    }
    return minimum
}
//求最大值
func maximum<T: Comparable>(_ array: [T]) -> T? {
    guard var maximum = array.first else { return nil }
    for element in array.dropFirst() {
        maximum = element > maximum ? element : maximum
    }
    return maximum
}
//e测试
let array = [8, 3, 9, 4, 6]
minimum(array)  // 3
maximum(array)  // 9

//: ## Swift的标准库
let array1 = [8, 3, 9, 4, 6]
array1.min()    // 3
array1.max()    // 9

//: ## 最大值和最小值
func minimunMaximum<T: Comparable>(_ array: [T]) -> (minimum: T, maximum: T)? {
    guard var minimum = array.first else {
        return nil
    }
    var maximum = minimum
    
    let start = array.count % 2
    for i in stride(from: start, to: array.count, by: 2) {
        let pair = (array[i], array[i + 1])
        
        if pair.0 > pair.1 {
            if pair.0 > maximum {
                maximum = pair.0
            }
            if pair.1 < minimum {
                minimum = pair.1
            }
        } else {
            if pair.1 > maximum {
                maximum = pair.1
            }
            if pair.0 < minimum {
                minimum = pair.0
            }
        }
    }
    return (minimum, maximum)
}

//测试
let result = minimunMaximum(array)!
result.minimum  // 3
result.maximum  // 9

