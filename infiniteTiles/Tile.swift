//
//  Tile.swift
//  infiniteTiles
//
//  Created by Kacper on 31/10/15.
//  Copyright © 2015 Kacper. All rights reserved.
//

import Foundation

struct Tile: Equatable {
    
    var value: Int
    
}

func == (lhs: Tile, rhs: Tile) -> Bool {
    return lhs.value == rhs.value
}