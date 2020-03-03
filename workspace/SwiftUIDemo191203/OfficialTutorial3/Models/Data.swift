//
//  Data.swift
//  SwiftUIDemo191203
//
//  Created by Mac on 2019/12/6.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import SwiftUI
import CoreLocation

let landmarkData: [Landmark] = load("landmarkData.json")

func load<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

final class ImageStore {
    typealias _ImageDictionary = [String: CGImage]
    fileprivate var images: _ImageDictionary = [:]

    fileprivate static var scale = 2
    
    static var shared = ImageStore()
    
    func image(name: String) -> Image {
        let index = _guaranteeImage(name: name)
        
        return Image(images.values[index], scale: CGFloat(ImageStore.scale), label: Text(verbatim: name))
    }
    
    

    static func loadImage(name: String) -> CGImage {
        guard
            let url = Bundle.main.url(forResource: name, withExtension: "jpg"),
            let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil),
            let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil)
        else {
            fatalError("Couldn't load image \(name).jpg from main bundle.")
        }
        return image
    }
    
    fileprivate func _guaranteeImage(name: String) -> _ImageDictionary.Index {
        if let index = images.index(forKey: name) { return index }
        
        images[name] = ImageStore.loadImage(name: name)
        return images.index(forKey: name)!
    }
}

//extension Image {
//    func reSizeImage(reSize: CGSize)->Image {
//        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale)
//        self.
//    }
//}

// extension UIImage {
//    /**
//     *  重设图片大小
//     */
//    func reSizeImage(reSize:CGSize)->UIImage {
//        //UIGraphicsBeginImageContext(reSize);
//        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.mainScreen().scale);
//        self.drawInRect(CGRectMake(0, 0, reSize.width, reSize.height));
//        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        return reSizeImage;
//    }
//
//    /**
//     *  等比率缩放
//     */
//    func scaleImage(scaleSize:CGFloat)->UIImage {
//        let reSize = CGSizeMake(self.size.width * scaleSize, self.size.height * scaleSize)
//        return reSizeImage(reSize)
//    }
//}
