//
//  UIColor+Init.swift
//  infiniteTiles
//
//  Created by Kacper on 07/11/15.
//  Copyright © 2015 Kacper. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(hex: Int) {
        let red = (hex & 0xFF0000) >> 16
        let green = (hex & 0x00FF00) >> 8
        let blue = (hex & 0x0000FF)
        self.init(red: red, green: green, blue: blue)
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: 1)
    }
    
}
