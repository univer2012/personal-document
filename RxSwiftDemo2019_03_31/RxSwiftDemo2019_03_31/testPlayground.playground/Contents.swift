//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

struct Money: Codable {
    let amount: Decimal
    let currency: String
}
let json = "{\"amount\": 9159795.995,\"currency\": \"BHD\"}"
let jsonData = json.data(using: .utf8)!

let decoder = JSONDecoder()

let money = try! decoder.decode(Money.self, from: jsonData)

money.amount
money.currency

