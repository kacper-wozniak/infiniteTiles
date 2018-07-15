//
//  GameBoard.swift
//  infiniteTiles
//
//  Created by Kacper on 31/10/15.
//  Copyright © 2015 Kacper. All rights reserved.
//

import Foundation

protocol GameBoardDelegate {
    
    func gameBoard(gameBoard: GameBoard, didMergeTileAtIndex: Int, withTileAtIndex: Int)
    func gameBoard(gameBoard: GameBoard, didMoveTileAtIndex: Int, toIndex: Int)
    func gameBoard(gameBoard: GameBoard, didSpawnTile: Tile, atIndex: Int)
    func gameBoardDidRestart(gameBoard: GameBoard)
    
}

class GameBoard {
    
    let slots: [TileSlot]
    
    var delegate: GameBoardDelegate?
    
    let rows, columns: Int
    lazy var count: Int = {
        return self.slots.count
    }()
    
    var merged = [TileSlot]()
    
    init(rows: Int, columns: Int) {
        var slots = [TileSlot]()
        for i in 0 ..< rows * columns {
            slots.append(TileSlot(index: i))
        }
        self.slots = slots
        self.rows = rows
        self.columns = columns
    }
    
    var score: Int = 0 {
        didSet {
            updateScore?(score: score)
        }
    }
    
    var updateScore: ((score: Int) -> ())?
    
    func linkSlots() {
        for i in 0 ..< slots.count where i % rows < rows-1 {
            slots[i].right = slots[i+1]
            slots[i+1].left = slots[i]
        }
        for i in 0 ..< slots.count-rows {
            slots[i].down = slots[i+rows]
            slots[i+rows].up = slots[i]
        }
    }
    
    func slide(direction: Direction) -> Bool {
        var slotsToSlide = slots.filled
        if direction == .Right || direction == .Down {
            slotsToSlide = slotsToSlide.reverse()
        }
        var slid = false
        for slot in slotsToSlide {
            let destination = slot.findFurthestEmptySlotInDirection(direction)
            if let next = destination.next(direction) where canMerge(slot, to: next) {
                merge(slot, to: next)
                slid = true
            } else if canMove(slot, to: destination) {
                move(slot, to: destination)
                slid = true
            }
        }
        merged.removeAll()
        return slid
    }
    
    func canMerge(source: TileSlot, to destination: TileSlot) -> Bool {
        return !merged.contains({ $0 === destination }) && source.tile == destination.tile
    }
    
    func merge(source: TileSlot, to destination: TileSlot) {
        destination.tile?.value++
        score += Int(pow(2, Double((destination.tile?.value)!)))
        source.tile = nil
        merged.append(destination)
        delegate?.gameBoard(self, didMergeTileAtIndex: source.index, withTileAtIndex: destination.index)
    }
    
    func canMove(source: TileSlot, to destination: TileSlot) -> Bool {
        return source !== destination
    }
    
    func move(source: TileSlot, to destination: TileSlot) {
        destination.tile = source.tile
        source.tile = nil
        delegate?.gameBoard(self, didMoveTileAtIndex: source.index, toIndex: destination.index)
    }
    
    func spawnTile() {
        if let random = slots.empty.random {
            random.tile = Tile(value: 1)
            delegate?.gameBoard(self, didSpawnTile: random.tile!, atIndex: random.index)
        }
    }
    
    func restart() {
        slots.filled.forEach { (slot) -> () in
            slot.tile = nil
        }
        delegate?.gameBoardDidRestart(self)
        spawnTile()
    }
    
    func isGameOver() -> Bool {
        if slots.empty.isEmpty {
            let directions: [Direction] = [.Left, .Right, .Up, .Down]
            for direction in directions {
                if canSlide(direction) {
                    return false
                }
            }
            return true
        }
        return false
    }
    
    func canSlide(direction: Direction) -> Bool {
        var slotsToSlide = slots.filled
        if direction == .Right || direction == .Down {
            slotsToSlide = slotsToSlide.reverse()
        }
        for slot in slotsToSlide {
            let destination = slot.findFurthestEmptySlotInDirection(direction)
            if let next = destination.next(direction) where canMerge(slot, to: next) {
                return true
            }
        }
        return false
    }
    
}