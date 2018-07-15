//
//  GameBoardView.swift
//  infiniteTiles
//
//  Created by Kacper on 02/11/15.
//  Copyright © 2015 Kacper. All rights reserved.
//

import UIKit

class GameBoardView: UIView, GameBoardDelegate {

    var tiles = [TileView?]()
    var rows = 1
    
    override func drawRect(rect: CGRect) {
        tileSize = (bounds.width - (CGFloat(rows-1) * offset)) / CGFloat(rows)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, UIColor(red: 100, green: 100, blue: 100).CGColor)
        for x in 0 ..< rows {
            for y in 0 ..< rows {
                CGContextAddRect(context, CGRectMake(CGFloat(x)*(tileSize+offset), CGFloat(y)*(tileSize+offset), tileSize, tileSize))
            }
        }
        CGContextFillPath(context)
    }
    
    func initialize(board: GameBoard) {
        tiles = Array<TileView?>(count: board.count, repeatedValue: nil)
        rows = board.rows
        board.delegate = self
    }
    
    func gameBoard(gameBoard: GameBoard, didMergeTileAtIndex source: Int, withTileAtIndex destination: Int) {
        let source = tiles[source]
        let destination2 = tiles[destination]
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            source!.frame.origin = self.originForIndex(destination)
            }) { (complited) -> Void in
                destination2!.value++
                source!.removeFromSuperview()
                destination2!.transform = CGAffineTransformMakeScale(1.2, 1.2)
                UIView.animateWithDuration(0.1) { destination2!.transform = CGAffineTransformIdentity }
        }
    }
    
    func gameBoard(gameBoard: GameBoard, didMoveTileAtIndex source: Int, toIndex destination: Int) {
        var source = tiles[source]
        UIView.animateWithDuration(0.1) { source!.frame.origin = self.originForIndex(destination) }
        tiles[destination] = source!
        source = nil
    }
    
    func gameBoard(gameBoard: GameBoard, didSpawnTile tile: Tile, atIndex index: Int) {
        popTileAtIndex(index)
    }
    
    func gameBoardDidRestart(gameBoard: GameBoard) {
        tiles.forEach { (tileView) -> () in
            tileView?.removeFromSuperview()
        }
    }
    
    func popTileAtIndex(index: Int) {
        let tile = TileView.createView()
        tiles[index] = tile
        addSubview(tile)
        tile.frame.size.width = tileSize
        tile.frame.size.height = tileSize
        tile.frame.origin = originForIndex(index)
        tile.transform = CGAffineTransformMakeScale(0, 0)
        UIView.animateWithDuration(0.1, delay: 0.1, options: [], animations: { () -> Void in
            tile.transform = CGAffineTransformIdentity
            }, completion: nil)
    }
    
    func originForIndex(index: Int) -> CGPoint {
        let x = CGFloat(index % rows) * (tileSize + offset)
        let y = CGFloat(index / rows) * (tileSize + offset)
        return CGPoint(x: x, y: y)
    }
    
    var tileSize: CGFloat = 0
    let offset: CGFloat = 10
    
}
