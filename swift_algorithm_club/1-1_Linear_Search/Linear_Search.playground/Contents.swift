import UIKit

//var str = "Hello, playground"

func linearSearch<T: Equatable>(_ array: [T], _ object: T) -> Int? {
    for (index, obj) in array.enumerated() where obj == object {
        return index
    }
    return nil
}

//Array<T>.Index 其实就是 Int
func linearSearch1<T: Equatable>(_ array: [T], _ object: T) -> Array<T>.Index? {
    //'index(where:)' is deprecated: renamed to 'firstIndex(where:)'
    //return array.index { $0 == object }
    return array.firstIndex { $0 == object }
}
let array = [5, 2, 4, 7]
//linearSearch(array, 2) // 1
linearSearch1(array, 2) // 1
