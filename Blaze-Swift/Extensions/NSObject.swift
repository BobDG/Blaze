//
//  NSObject.swift
//  Blaze-Swift
//
//  Created by Sebastiaan Seegers on 10-11-17.
//  Copyright © 2017 ZoinksInteractive. All rights reserved.
//

import Foundation

extension NSObject {
    func stringForPropertyName(propertyName: Selector) -> String {
        return NSStringFromSelector(propertyName)
    }
}
