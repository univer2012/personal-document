//
//  SGH1901AutoSizingViewController.swift
//  SwiftDemo160801
//
//  Created by sengoln huang on 2019/1/14.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

import UIKit

class SGH1901AutoSizingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.size.width, height: 95.0)
        if #available(iOS 10.0, *) {
            layout.itemSize = UICollectionViewFlowLayout.automaticSize
        }
        
        return layout
    }()
    private lazy var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.layout)
    
    private lazy var resourceData = ["Do any additional setup after loading the view, typically from a nib.",
    "Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib.",
    "Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib.",
    "Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib.",
    "Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib.",
    "Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib."]

    override func loadView() {
        view = collectionView
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SGH1901AutoSizingCollectionViewCell.self, forCellWithReuseIdentifier: "SGH1901AutoSizingCollectionViewCell")
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resourceData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SGH1901AutoSizingCollectionViewCell", for: indexPath) as? SGH1901AutoSizingCollectionViewCell  else {
            fatalError("Can't convert this cell")
        }
        cell.text = resourceData[indexPath.item]
        cell.backgroundColor = (indexPath.row % 2 == 0) ? .orange : .yellow
        return cell
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
