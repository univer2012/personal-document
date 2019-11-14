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
    
    var buyerName: String = ""
    
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
    
    
    func vend(itemNamed name: String, buyerName:String) throws {
        self.buyerName = buyerName
        try vend(itemNamed: name)
    }
}


var test = VendingMachine()
do {
    try test.vend(itemNamed: "Chips")
} catch VendingMachineError.invalidSelection {
    print("invalidSelection")
} catch VendingMachineError.outOfStock {
    print("outOfStock")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("insufficientFunds \(coinsNeeded)")
}



//let x = try! test.vend(itemNamed: "Chips")
//print(x)
/////崩溃，信息如下：
/////Fatal error: 'try!' expression unexpectedly raised an error: __lldb_expr_5.VendingMachineError.insufficientFunds(coinsNeeded: 8): file Swift_do_try_catch_try_throw(s).playground, line 69


//let x = try? test.vend(itemNamed: "Chips")
//print(x)
/////打印：
/////nil



struct XMLParsingError: Error {
    enum ErrorKind {
        case invalidCharacter
        case mismatchedTag
        case internalError
    }
    
    let line: Int
    let column: Int
    let kind: ErrorKind
}


//do {
//    let xmlDoc = try parse(myXMLData)
//} catch let e as XMLParsingError {
//    print("Parsing error: \(e.kind) [\(e.line):\(e.column)]")
//} catch {
//    print("Other error: \(error)")
//}
