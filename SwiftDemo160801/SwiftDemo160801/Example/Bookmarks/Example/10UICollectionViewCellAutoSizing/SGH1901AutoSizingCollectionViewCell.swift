//
//  SGH1901AutoSizingCollectionViewCell.swift
//  SwiftDemo160801
//
//  Created by sengoln huang on 2019/1/14.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

import UIKit

class SGH1901AutoSizingCollectionViewCell: UICollectionViewCell {
    var text: String? {
        didSet {
            textLabel.text = text
        }
    }
    private lazy var containerView = UIView()
    
    private lazy var textLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        globalSetup()
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        globalSetup()
    }
    private func globalSetup() {
        setupContainerView()
        setupContentLabel()
    }
    
    private func setupContainerView() {
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 95.0).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width).isActive = true
    }
    
    private func setupContentLabel() {
        textLabel.numberOfLines = 0
        containerView.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15.0).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15.0).isActive = true
        textLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10.0).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10.0).isActive = true
        
    }
    
}
