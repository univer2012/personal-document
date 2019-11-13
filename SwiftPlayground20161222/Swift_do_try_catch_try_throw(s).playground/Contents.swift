import UIKit


enum VendingMachineError: Error {
    case invalidSelection                   //选择无效
    case insufficientFunds(coinsNeeded: Int)//金额不足
    case outOfStock                         //缺货
}

//商品结构体
struct Item {
    var price: Int
    var count: Int
}

//自动贩卖机
class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 4)
    ]
    
    var coinsDesposited = 2
    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= coinsDesposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDesposited)
        }
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("dispensing\(name)")
    }
}



