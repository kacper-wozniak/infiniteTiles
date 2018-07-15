//
//  AppColorPalette.swift
//  infiniteTiles
//
//  Created by Kacper on 05/11/15.
//  Copyright © 2015 Kacper. All rights reserved.
//

import UIKit

class AppColorPalette {
    
    static let instance = AppColorPalette()
    
    let tile: [UIColor] = [
        UIColor(hex: 0xc80000),
        UIColor(hex: 0xc86400),
        UIColor(hex: 0xc8c800),
        UIColor(hex: 0x64c800),
        UIColor(hex: 0x00c800),
        UIColor(hex: 0x00c864),
        UIColor(hex: 0x00c8c8),
        UIColor(hex: 0x0064c8),
        UIColor(hex: 0x0000c8),
        UIColor(hex: 0x6400c8),
        UIColor(hex: 0xc800c8),
        UIColor(hex: 0xc80064)
    ]
    
    private init() { }
    
}