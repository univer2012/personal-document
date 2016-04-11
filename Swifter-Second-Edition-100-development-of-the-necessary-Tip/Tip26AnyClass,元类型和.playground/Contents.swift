//: Playground - noun: a place where people can play

import UIKit

//var str = "Hello, playground"
//“在 Swift 中能够表示 “任意” 这个概念的除了 Any 和 AnyObject 以外，还有一个 AnyClass。AnyClass 在 Swift 中被一个 typealias 所定义：
typealias AnyClass = AnyObject.Type

//“通过 AnyObject.Type 这种方式所得到是一个元类型 (Meta)。在声明时我们总是在类型的名称后面加上 .Type，比如 A.Type 代表的是 A 这个类型的类型。也就是说，我们可以声明一个元类型来存储 A 这个类型本身，而在从 A 中取出其类型时，我们需要使用到 .self：
class A {
    
}
let typeA: A.Type = A.self

//“其实在 Swift 中，.self 可以用在类型后面取得类型本身，也可以用在某个实例后面取得这个实例本身。前一种方法可以用来获得一个表示该类型的值，这在某些时候会很有用；而后者因为拿到的实例本身，所以暂时似乎没有太多需要这么使用的案例。

//“了解了这个基础之后，我们就明白 AnyObject.Type，或者说 AnyClass 所表达的东西其实并没有什么奇怪，就是任意类型本身。所以，上面对于 A 的类型的取值，我们也可以强制让它是一个 AnyClass：
class A1 {
    
}
let typeA1: AnyClass = A1.self

//“这样，要是 A 中有一个类方法时，我们就可以通过 typeA 来对其进行调用了：
class A2 {
    class func method() {
        print("Hello")
    }
}
let typeA2: A2.Type = A2.self
typeA2.method()

//或者
let anyClass: AnyClass = A2.self
(anyClass as! A2.Type).method()


//“也许你会问，这样做有什么意义呢，我们难道不是可以直接使用 A.method() 来调用么？没错，对于单个独立的类型来说我们完全没有必要关心它的元类型，但是元类型或者元编程的概念可以变得非常灵活和强大，这在我们编写某些框架性的代码时会非常方便。比如我们想要传递一些类型的时候，就不需要不断地去改动代码了。在下面的这个例子中虽然我们是用代码声明的方式获取了 MusicViewController 和 AlbumViewController 的元类型，但是其实这一步骤完全可以通过读入配置文件之类的方式来完成的。而在将这些元类型存入数组并且传递给别的方法来进行配置这一点上，元类型编程就很难被替代了：
class MusicViewController: UIViewController {
    
}
class AlbumViewController: UIViewController {
    
}
let usingVCTypes: [AnyClass] = [MusicViewController.self, AlbumViewController.self]
func setupViewControllers(vcTypes: [AnyClass]) {
    for vcType in vcTypes {
        if vcType is UIViewController.Type {
            let vc = (vcType as! UIViewController.Type).init()
            print(vc)
        }
    }
}
setupViewControllers(usingVCTypes)

//“这么一来，我们完全可以搭好框架，然后用 DSL 的方式进行配置，就可以在不触及 Swift 编码的情况下，很简单地完成一系列复杂操作了。



//另外，在 Cocoa API 中我们也常遇到需要一个 AnyClass 的输入，这时候我们也应该使用 .self 的方式来获取所需要的元类型，例如在注册 tableView 的 cell 的类型的时候：

class DemoClass: UIViewController {
    var tableView:UITableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "myCell")
    }
}
//“.Type 表示的是某个类型的元类型，而在 Swift 中，除了 class，struct 和 enum 这三个类型外，我们还可以定义 protocol。对于 protocol 来说，有时候我们也会想取得接口的元类型。这时我们可以在某个 protocol 的名字后面使用 .Protocol 来获取，使用的方法和 .Type 是类似的。
public protocol DemoProtocol {
    func method()
}
let typeProtocol: DemoProtocol.Protocol = DemoProtocol.self
typeProtocol.method


















