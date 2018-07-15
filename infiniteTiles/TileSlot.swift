//
//  TileSlot.swift
//  infiniteTiles
//
//  Created by Kacper on 31/10/15.
//  Copyright © 2015 Kacper. All rights reserved.
//

import Foundation

enum Direction {
    case Left, Right, Up, Down
}

class TileSlot {
    
    let index: Int
    var left, right, up, down: TileSlot?
    var tile: Tile?
    
    var isEmpty: Bool {
        return tile == nil
    }
    
    init(index: Int) {
        self.index = index
    }
    
    func next(direction: Direction) -> TileSlot? {
        switch direction {
            case .Left: return left
            case .Right: return right
            case .Up: return up
            case .Down: return down
        }
    }
    
    func findFurthestEmptySlotInDirection(direction: Direction) -> TileSlot {
        var destination = self
        while let next = destination.next(direction) where next.isEmpty {
            destination = next
        }
        return destination
    }
    
}

extension Array where Element: TileSlot {
    
    var empty: [TileSlot] {
        return filter { $0.tile == nil }
    }
    
    var filled: [TileSlot] {
        return filter { $0.tile != nil }
    }
    
    var random: TileSlot? {
        return self[RandomGenerator.int%count]
    }
    
}