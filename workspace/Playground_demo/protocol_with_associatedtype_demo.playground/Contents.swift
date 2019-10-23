import UIKit



///=====================================================================
///文章1的demo
///来自：[associatedtype](https://www.jianshu.com/p/2e17af7858e0)

#if false
protocol Food { }

protocol Animal {
    associatedtype F: Food  //
    func eat(_ food: F)
}

struct Meat: Food { }

struct Lion: Animal {
    func eat(_ food: Meat) { //编译时确定类型，不需要判断类型
        print("eat \(food)")
    }
}

let meat = Meat()
Lion().eat(meat)

//func isDangerous(animal: Animal) -> Bool {
//
//}

func isDangerous<T: Animal>(animal: T) -> Bool {
    if animal is Lion {
        return true
    } else {
        return false
    }
}

#endif

///=====================================================================
///文章2的demo
///来自：[Swift Associated Type Design Patterns](https://medium.com/@bobgodwinx/swift-associated-type-design-patterns-6c56c5b0a73a)

#if false //原来的
/// Rows `Interface`
protocol Row {
    /// PAT Placeholder for unknown Concrete Type `Model`
    associatedtype Model
    /// Recieves a parameter of Concrete Type `Model`
    func configure(with model: Model)
}
#else
//MARK: - `Shadowed` Protocol Based Type Erasure

/// `shadow` protocol
protocol TableRow {
    /// - Recieves a parameter of Concrete Type `Any`
    func configure(with model: Any)
}
/// `Row` To be shadowed.
protocol Row: TableRow {
    associatedtype Model
    /// - Recieves a parameter of Concrete Type `Model`
    func configure(with model: Model)
}
//============================
/// Default `extension` to conform to `TableRow`
extension TableRow {
    /// TableRow - conformation
    func configure(with model: Any) {
        /// Just throw a fatalError
        /// because we don't need it.
        fatalError()
    }
}
#endif

/// Concrete Type `Product`
struct Product { }
/// Concrete Type `Item`
struct Item { }

//MARK: - Constrained Type Erasure

/// Wrapper `AnyRow`
struct AnyRow<I>: Row {
    private let configureClosure: (I) -> Void
    /// Initialiser guaratees that `Model`
    /// should be a `Type` of `I`
    init<T: Row>(_ row: T) where T.Model == I {
        /// Matches the row `configure` func
        /// to the private the `configureClosure`
        configureClosure = row.configure
    }
    /// Conforming to `Row` protocol
    func configure(with model: I) {
        configureClosure(model)
    }
}
/// `ProductCell`
class ProductCell: Row {
    
    typealias Model = Product
    let name: String
    
    init(name: String) {
        self.name = name
    }
    /// Conforming to `Row` protocol
    func configure(with model: Model) {
        print("PATs PlaceHolder is now `Product` Concrete Type")
        print("This will now be configured based on \(type(of: self))")
    }
}
/// `ProductDetailsCell`
class ProductDetailsCell: Row {
    typealias Model = Product
    let name: String
    let category: String
    
    init(name: String, category: String) {
        self.name = name
        self.category = category
    }
    /// Conforming to `Row` protocol
    func configure(with model: Model) {
        print("PATs PlaceHolder is now `Product` Concrete Type")
        print("This will now be configured based on \(type(of: self))")
    }
    
}
/// Usage of PAT for Homogeneous Requirement
let productCell = ProductCell(name: "product-name")
let productDetailsCell = ProductDetailsCell(name: "product-name", category: "ABC-HT")
/// We get only a `Homogeneous` Collection Type
let cells: [AnyRow<Product>] = [AnyRow(productCell), AnyRow(productDetailsCell)]
let product = Product()
cells.forEach { (cell) in
    cell.configure(with: product)
}




//==============================
//MARK: - Unconstrained Type Erasure
/// Heterogeneous Requirement and Dynamic dispatch availability
/// Generic Wrapper `AnyCellRow` to match Heterogeneous Types + Dynamic Dispatch 通用包装器‘AnyCellRow’匹配异构类型+动态分派
struct AnyCellRow: Row {
    private let configureClosure: (Any) -> Void
    
    init<T: Row>(_ row: T) {
        configureClosure = { object in
            /// Asserting that `object` received is `type` of `T.Model`
            guard let model = object as? T.Model else { return }
            /// call the `T.configure` function on success
            row.configure(with: model)
        }
    }
    /// Conforming to `Row` protocol
    func configure(with model: Any) {
        configureClosure(model)
    }
}
/// `ItemCell`
class ItemCell: Row {
    typealias Model = Item
    let id: String
    
    init(id: String) {
        self.id = id
    }
    /// Conforming to `Row` protocol
    func configure(with model: Item) {
        print("PATs PlaceHolder is now `Item` Concrete Type)")
        print("This will now be configured based on \(type(of: self))")
    }
}
/// Usage of PAT for Heterogenous Requirement + Dynamic dispatch
let item = Item()
let itemCell = ItemCell(id: "an-itemCell")
/// We get a `Heterogenous`collection Type
let allCells = [AnyCellRow(productCell),
                AnyCellRow(productDetailsCell),
                AnyCellRow(itemCell)]

for (index, cell) in allCells.enumerated() {
    index <= 1 ? cell.configure(with: product) : cell.configure(with: item)
}



//============================




//============================
/// Usage of shadowed protocol styled type erasure
let rows: [TableRow] = [ProductCell(name: "Hello"), ItemCell(id: "123456")]

for row in rows {
    if let cell = row as? ProductCell {
        cell.configure(with: Product())
    }
    
    if let cell = row as? ItemCell {
        cell.configure(with: Item())
    }
}
