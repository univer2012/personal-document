//
//  SHDataSource.swift
//  SwiftDemo160801
//
//  Created by rrd on 2019/7/10.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

import UIKit
import CoreSpotlight

class Person: NSObject {
    
    var name: String = ""
    var id: String = ""
    var image: UIImage = UIImage()
}

class SHDataSource: NSObject {
    var people: [Person]
    
    override init () {
        let becky = Person()
        becky.name = "Becky"
        becky.id = "1"
        becky.image = UIImage(named: "becky")!
        
        let ben = Person()
        ben.name = "Ben"
        ben.id = "2"
        ben.image = UIImage(named: "ben")!
        
        let jane = Person()
        jane.name = "Jane"
        jane.id = "3"
        jane.image = UIImage(named: "jane")!
        
        let pete = Person()
        pete.name = "Pete"
        pete.id = "4"
        pete.image = UIImage(named: "pete")!
        
        let ray = Person()
        ray.name = "Ray"
        ray.id = "5"
        ray.image = UIImage(named: "ray")!
        
        let tom = Person()
        tom.name = "Tom"
        tom.id = "6"
        tom.image = UIImage(named: "tom")!
        
        people = [becky, ben, jane, pete, ray, tom]
    }
    
    func friendFrom(_ id: String) -> Person? {
        for person in people {
            if person.id == id {
                return person
            }
        }
        return nil
    }
    
    func savePeopleToIndex() {
        
        var searchableItems = [CSSearchableItem]()
        
        for person in people {
            let attributeSet = CSSearchableItemAttributeSet(itemContentType: "image" as String)
            attributeSet.title = person.name
            attributeSet.contentDescription = "This is an entry all about the interesting person called \(person.name)"
            attributeSet.thumbnailData = person.image.pngData() // Doesn't work in beta 1. Known issue.
            let item = CSSearchableItem(uniqueIdentifier: person.id, domainIdentifier: "com.ios9daybyday.SearchAPIs.people", attributeSet: attributeSet)
            searchableItems.append(item)
        }
        
        CSSearchableIndex.default().indexSearchableItems(searchableItems, completionHandler: { error -> Void in
            if error != nil {
                print(error?.localizedDescription as Any)
            }
        })
    }
}
