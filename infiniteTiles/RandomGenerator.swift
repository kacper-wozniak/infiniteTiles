//
//  RandomGenerator.swift
//  infiniteTiles
//
//  Created by Kacper on 01/11/15.
//  Copyright © 2015 Kacper. All rights reserved.
//

import Foundation

class RandomGenerator {
    
    class var int: Int {
        return Int(arc4random())
    }
    
}