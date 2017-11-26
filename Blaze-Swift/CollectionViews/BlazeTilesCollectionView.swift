//
//  BlazeTilesCollectionView.swift
//  Blaze-Swift
//
//  Created by Sebastiaan Seegers on 10-11-17.
//  Copyright © 2017 ZoinksInteractive. All rights reserved.
//

import UIKit

class BlazeTilesCollectionView: UICollectionView {

    var ID: Int = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let bundle: Bundle = Bundle(for: NSClassFromString("BlazeTileCollectionViewCell")!)
        let nib: UINib = UINib(nibName: "BlazeTileCollectionViewCell", bundle: bundle)
        self.register(nib, forCellWithReuseIdentifier: "BlazeTileCollectionViewCell")
    }
}
