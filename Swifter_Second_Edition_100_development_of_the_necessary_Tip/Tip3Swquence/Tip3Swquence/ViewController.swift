//
//  ViewController.swift
//  Tip3Swquence
//
//  Created by huangaengoln on 16/4/2.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var arr = [0, 1, 2, 3, 4]
        for i in ReverseSequence(array: arr) {
            print("Index \(i) is \(arr[i])");
        }
        
        var g = arr.generate()
        while let obj = g.next() {
            print(obj)
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
class ReverseGenerator: GeneratorType {
    typealias Element = Int
    var counter: Element
    init<T>(array: [T]) {
        self.counter = array.count - 1
    }
    init(start: Int) {
        self.counter = start
    }
    func next() -> Element? {
        return self.counter < 0 ? nil : counter--
    }
}
struct ReverseSequence<T>: SequenceType {
    var array: [T]
    init(array: [T]) {
        self.array = array
    }
    typealias Generator = ReverseGenerator
    func generate() -> Generator {
        return ReverseGenerator(array: array)
    }
}
