//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

struct Money: Codable {
    let amount: Decimal
    let currency: String
}
//let json = "{\"currency\": \"EUR\",\"exponent\": -2,\"significand\": 105}"
//let jsonData = json.data(using: .utf8)!
//
//let decoder = JSONDecoder()
//
//let money = try! decoder.decode(Money.self, from: jsonData)
//
//money.amount
//money.currency

class Baby {
    var name = "peter"
    var favoriteActivity: (() -> ())!
    func outsideActivity(activity: () -> ()) {
        activity()
        favoriteActivity = activity
    }
}

