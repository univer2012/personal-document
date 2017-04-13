//: Playground - noun: a place where people can play

import UIKit

//Instance methods

class BankCard {
    var balance: Double = 0
    func deposit(amount: Double) {
        self.balance += amount
        print("Current balance: \(self.balance)")
    }
}
//用法1
let card = BankCard()
card.deposit(amount: 100)
//用法2
let atm = BankCard.deposit
let depositor = atm(card)
depositor(100)
/*
 如何理解第2种用法呢？
 当我们定义atm时，就得到了一个clear function,在playground可以看到，它是一个可以接受BankCard参数，返回一个closure类型，这个closure类型和deposit Instance method 是一样的。
 接下来绑定deposit的第一个参数，得到一个`depositor`，此时`depositor`就是`deposit`的Instance method。因此这样的调用和`card.deposit`是一样的。
 */
depositor(100)
depositor(100)
depositor(100)
depositor(100)



