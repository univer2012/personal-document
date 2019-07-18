//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

struct Money: Codable {
    let amount: Double
    let currency: String
}
let json = "{\"amount\": 128.8,\"currency\": \"EUR\"}"
let jsonData = json.data(using: .utf8)!

let decoder = JSONDecoder()

let money = try! decoder.decode(Money.self, from: jsonData)

money.amount
money.currency

