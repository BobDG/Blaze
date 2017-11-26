//
//  BlazeTileCollectionViewCell.swift
//  Blaze-Swift
//
//  Created by Sebastiaan Seegers on 10-11-17.
//  Copyright © 2017 ZoinksInteractive. All rights reserved.
//

import UIKit

class BlazeTileCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    private var active: Bool = false
    private var inputTile: BlazeInputTile?
    private var bundle: Bundle?
    
    func setHighlighted(Highlighted highlighted: Bool) {
        active = highlighted
    }
    
    func setSelected(Selected selected: Bool) {
        active = selected
    }
    
    func setInputTile(inputTile: BlazeInputTile) {
        if self.inputTile == inputTile {
            return
        }
        
        self.inputTile = inputTile
        
        self.titleLabel.text = self.inputTile!.text
        
        if let bundle = bundle {
            self.imageView.image = UIImage(named: self.inputTile!.imageName!, in: bundle, compatibleWith: nil)!.withRenderingMode(.alwaysTemplate)
        } else {
            self.imageView.image = UIImage(named: self.inputTile!.imageName!)!.withRenderingMode(.alwaysTemplate)
        }
    }
    
    func setActive(Active active: Bool) {
        self.active = active
        
        if active {
            self.imageView.tintColor = self.inputTile?.baseColor
            self.titleLabel.textColor = self.inputTile?.baseColor
            self.containerView.backgroundColor = self.inputTile?.tintColor
        } else {
            self.imageView.tintColor = self.inputTile?.tintColor
            self.titleLabel.textColor = self.inputTile?.tintColor
            self.containerView.backgroundColor = .clear
        }
    }
    
}
