//
//  main.swift
//  Tip25...和..<
//
//  Created by huangaengoln on 16/4/11.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

import Foundation

//print("Hello, World!")

/*
 “在很多脚本语言中 (比如 Perl 和 Ruby)，都有类似 0..3 或者 0...3 这样的 Range 操作符，用来简单地指定一个从 X 开始连续计数到 Y 的范围。这个特性不论在哪个社区，都是令人爱不释手的写法，Swift 中将其光明正大地 "借用" 过来，也就不足为奇了。
 
 “最基础的用法当然还是在两边指定数字，0...3 就表示从 0 开始到 3 为止并包含 3 这个数字的范围，我们将其称为全闭合的范围操作；而在某些时候 (比如操作数组的 index 时)，我们更常用的是不包括最后一个数字的范围。这在 Swift 中被用一个看起来有些奇怪，但是表达的意义很清晰的操作符来定义，写作 0..<3 -- 都写了小于号了，自然是不包含最后的 3 的意思咯。
 
 “对于这样得到的数字的范围，我们可以对它进行 for...in 的访问：
 */
for i in 0...3 {
    print(i, terminator: "")
}
// 输出 0123

//“如果你认为 ... 和 ..< 只有这点内容的话，就大错特错了。我们可以仔细看看 Swift 中对着两个操作符的定义 (为了清晰，我稍微更改了一下它们的次序)：
#if false
    /// Forms a closed range that contains both `minimum` and `maximum`.
    public func ...<Pos : ForwardIndexType>(minimum: Pos, maximum: Pos) -> Range<Pos>
    
    /// Returns a closed interval from `start` through `end`.
    public func ...<Bound : Comparable>(start: Bound, end: Bound) -> ClosedInterval<Bound>
    
    
    
    /// Forms a half-open range that contains `minimum`, but not
    /// `maximum`.
    public func ..<<Pos : ForwardIndexType>(minimum: Pos, maximum: Pos) -> Range<Pos>
    
    /// Forms a half-open range that contains `start`, but not `end`.
    ///
    /// - Requires: `start <= end`.
    public func ..<<Pos : ForwardIndexType where Pos : Comparable>(start: Pos, end: Pos) -> Range<Pos>
    
    
    
    /// Returns a closed interval from `start` through `end`.
    public func ...<Bound : Comparable>(start: Bound, end: Bound) -> ClosedInterval<Bound>
    
    /// Returns a half-open interval from `start` to `end`.
    public func ..<<Bound : Comparable>(start: Bound, end: Bound) -> HalfOpenInterval<Bound>
#endif

//“不难发现，其实这几个方法都是支持泛型的。除了我们常用的输入 Int 或者 Double，返回一个 Range 以外，这个操作符还有一个接受 Comparable 的输入，并返回 ClosedInterval 或 HalfOpenInterval 的重载。在 Swift 中，除了数字以外另一个实现了 Comparable 的基本类型就是 String。也就是说，我们可以通过 ... 或者 ..< 来连接两个字符串。一个常见的使用场景就是检查某个字符是否是合法的字符。比如想确认一个单词里的全部字符都是小写英文字母的话，可以这么做：
let test = "helLo"
let interval = "a"..."z"
for c in test.characters {
    if !interval.contains(String(c)) {
        print("\(c)不是小写字母")
    }
}
//输出
// L不是小写字母

//“在日常开发中，我们可能会需要确定某个字符是不是有效的 ASCII 字符，和上面的例子很相似，我们可以使用 \0...~ 这样的 ClosedInterval 来进行 (\0 和 ~ 分别是 ASCII 的第一个和最后一个字符)。

let test1 = "adAD12~!@#$%^&*()_+-=\\/><,.[{å∂ß∂ƒ®∑"
let closedInterval = "\0"..."~"

for c in test1.characters {
    if !closedInterval.contains(String(c)) {
        print("\(c)不是ASCII字符")
    }
}























