import UIKit

protocol SortType {
    func sort(items: Array<Int>) -> Array<Int>
}
//冒泡排序
class BubbleSort: SortType {
    func sort(items: Array<Int>) -> Array<Int> {
        print("冒泡排序：")
        var list = items
        for i in 0..<list.count {
            print("第\(i+1)轮冒泡：")
            var j = list.count - 1
            while j > i {
                if list[j - 1] > list[j] {
                    print("\(list[j - 1]) >\(list[j]):进行交换")
                    let temp = list[j]
                    list[j] = list[j - 1]
                    list[j - 1] = temp
                } else {
                    print("\(list[j - 1]) <= \(list[j]):不进行交换")
                }
                j = j - 1
            }
            print("第\(i + 1)轮冒泡结束")
            print("当前结果为：\n\(list)\n")
        }
        return list
    }
}
//插入排序
class InsertSort: SortType {
    func sort(items: Array<Int>) -> Array<Int> {
        print("插入排序")
        var list = items
        for i in 1..<list.count {
            print("第\(i)轮插入：")
            print("要选择插入的值为：\(list[i])")
            let j = i
            while j > 0 {
                if list[j] < list[j - 1] {
                    let temp = list[j]
                    list[j] = list[j - 1]
                    list[j - 1] = temp
                } else {
                    break
                }
            }
            print("插入的位置为：\(j)")
            print("本轮插入完毕，插入结果为：\n\(list)\n")
        }
        return list
    }
}

//希尔排序
class ShellSort: SortType {
    func sort(items: Array<Int>) -> Array<Int> {
        print("希尔排序")
        var list = items
        var step: Int = list.count / 2
        while step > 0 {
            print("步长为\(step)的插入排序开始：")
            for i in 0..<list.count {
                var j = i + step
                while j >= step && j < list.count {
                    if list[j] < list[j - step] {
                        let temp = list[j]
                        list[j] = list[j - step]
                        list[j - step] = temp
                    } else {
                        break
                    }
                }
            }
            print("步长为\(step)的插入排序结束")
            print("本轮排序结果为：\(list)\n")
            step = step / 2
        }
        return list
    }
}


//简单选择排序
class SimpleSelectionSort: SortType {
    func sort(items: Array<Int>) -> Array<Int> {
        print("简单选择排序")
        var list = items
        for i in 0..<list.count {
            print("第\(i+1)轮选择，选择下标的范围为\(i)----\(list.count)")
            var j = i + 1
            var minValue = list[i]
            var minIndex = i
            //寻找无序部分中的最小值
            while j < list.count {
                if minValue > list[j] {
                    minValue = list[j]
                    minIndex = j
                }
                j = j + 1
            }
            print("在后半部分乱序数列中，最小值为：\(minValue)，下标为：\(minIndex)")
            //与无序表中的第一个值交换，让其成为有序表中的最后一个值
            if minIndex != i {
                print("\(minValue)与\(list[i])交换")
                let temp = list[i]
                list[i] = list[minIndex]
                list[minIndex] = temp
            }
            print("本轮结果为：\(list)\n")
        }
        return list
    }
}




