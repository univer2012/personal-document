//: Playground - noun: a place where people can play

import UIKit

//: ### Build your own type
//: Int String

/*
 location (Double, Double)
 name (String, String)
 在程序里，如果我们真的能使用一个名字叫做location或者name的类型，我们的代码可读性就会提高很多。于是Swift允许我们根据需要来构建自己的类型系统。swift管我们叫做named types
 */
//：named types
//根据使用的不同，swift为我们提供了4中类型，它们分别是struct、class、enum、protocol
//: #### 用来表达值类型的 struct
let centerX = 100.0
let centerY = 100.0
let distance = 200.0
func inRange(x: Double, y: Double)->Bool {
    //sqrt()  pow(x, n)
    let distX = x - centerX
    let distY = y - centerY
    let dist = sqrt(pow(distX, 2) + pow(distY, 2))
    return dist < distance
}
//可以这样调用：
inRange(x: 100, y: 500)
inRange(x: 100, y: 800)
//如果我们的代码有很多这样的inRange(x:y:)的比较，那么这里的问题就是我们并不能很好的通过数字来理解某一个位置的具体含义，甚至都不知道这2个数字放在一起代表一个位置信息，如果我们像类似这样来调用inRange：
// inRange(location1)
// inRange(myHome)
//这样的方式则会比我们直接传递2个数字要直观得多。而这就是我们要定义自己struct类型的一个原因。
//: #### Define and init struct
struct Location {
    //设置默认值
    var x: Double = 100.0
    var y: Double = 100.0
    //Initializer
    //只针对每个member都有初始值的情况才可以，如果其中的一个member没有初始值，编译器会告诉我们发生了错误。
    init() {}
    
    init(stringPoint: String) {
        //"100,200"
        //String类型提供了一个分割字符串的方法：
        let xy = stringPoint.characters.split(separator: ",")
        //xy:[[Character], [Character]]
        //这里，atof是swift的库函数，可以把一个字符串转换为一个Double：
        x = atof(String(xy.first!))
        y = atof(String(xy.last!))
    }
    //当我们的struct没有自定义任何init方法时，swift编译器就会为我们自动创建一个init，用来执行`Memberwiase initialization`,但是，当我们自定义了init方法后，swift就会认为我们会用自己的方式来定义Location，于是就不会再为我们生成默认的`Memberwiase initialization`了。如果还想Location(x:, y:)这样来定义Point，我们就需要自己实现一个init：
    //init作为一个特殊的函数，它的第一个参数的outername是不能够被忽略的，因此在定义pointA时，必须明确地使用每一个参数的outername。(Swift3中已经不用注意这个了)
    init(_ x: Double, y:Double) {
        self.x = x
        self.y = y
    }
    //作为一个值类型，struct并不能在它方法里面直接修改它的member，如果我们的方法要去修改一个struct member，那么我们必须要在方法前面加上`mutating`关键字。
    mutating func moveHorizental(_ dist: Double) {
        self.x += dist  //会报错：
    }
}
//把下面的定义方式叫做`Memberwiase initialization`。
//var pointA = Location(x: 100, y: 200)
var pointA = Location(100, y: 200)
pointA.x
pointA.y = 500.0

func inPointRange(_ point: Location)->Bool {
    //sqrt()  pow(x, n)
    let distX = point.x - centerX
    let distY = point.y - centerY
    let dist = sqrt(pow(distX, 2) + pow(distY, 2))
    return dist < distance
}
inPointRange(pointA)
//使用默认的方式定义struct之外，还可以用另外一种我们期望的方式来定义Location，比如：
var pointB = Location(stringPoint: "100,200")
var center = Location()





//: #### Methods in struct    在struct中定义方法
//水平移动一段距离：
func moveHorizental(dist: Double, point: inout Location) {
    point.x += dist
}
moveHorizental(dist: 100, point: &pointA)
pointA
//尽管达到了目的，但是这样做有很多问题：首先这个x是一个Location内部的成员，这个代表水平坐标的名字无需被Location的使用者关心；其次，移动坐标点本身就是和Location自身计算相关的行为，从直觉上说，我们甚至希望使用类似
pointA.moveHorizental(100.0)
//这样的方式来移动一个坐标点。而这就是我们要为struct定义method的原因，它让类型相关的计算表现的更加自然。




//如果struct不是我们自己定义的，但是项目中需要向Location中添加更多的方法，
//: #### Struct extentions
extension Location {
    mutating func moveVertical(dist: Double) {
        self.y += y
    }
}
pointA.moveVertical(dist: 100)

//例子2：
//String
extension String {
    func isEven() -> Bool {
        return self.characters.count % 2 == 0 ? true : false
    }
}
"An even string".isEven()
//其实swift里，我们已经是用了很多struct，甚至管它叫做基础类型的Int、String、或者Double，按住command键，点击`Double`,进去就可以发现，在Swift实现里面，Double被定义为了struct。


//: #### Struct is a value type  struct是一个值类型
var copyPointA = pointA
copyPointA.y = 10000.0
pointA



