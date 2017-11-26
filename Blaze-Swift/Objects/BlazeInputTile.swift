//
//  BlazeInputTile.swift
//  Blaze-Swift
//
//  Created by Sebastiaan Seegers on 10-11-17.
//  Copyright © 2017 ZoinksInteractive. All rights reserved.
//

import UIKit

class BlazeInputTile: NSObject {
    
    var ID: Int = 0
    var name: String?
    var text: String?
    var tintColor: UIColor?
    var baseColor: UIColor?
    var imageName: String?
    
    convenience init(withID ID: Int, Text text: String, TintColor tintColor: UIColor, BaseColor baseColor: UIColor, ImageName imageName: String) {
        self.init(withID: ID, Text: text, TintColor: tintColor, BaseColor: baseColor, ImageName: imageName)
    }
    
    convenience init(withID ID: Int, Name name: String, Text text: String, TintColor tintColor: UIColor, BaseColor baseColor: UIColor, ImageName imageName: String) {
        
        self.init()
        
        self.ID = ID
        self.text = text
        self.name = name
        self.tintColor = tintColor
        self.baseColor = baseColor
        self.imageName = imageName
    }
}
