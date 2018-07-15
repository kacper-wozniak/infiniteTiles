//
//  GameBoardViewController.swift
//  infiniteTiles
//
//  Created by Kacper on 31/10/15.
//  Copyright © 2015 Kacper. All rights reserved.
//

import UIKit

class GameBoardViewController: UIViewController {

    @IBOutlet weak var gameBoardView: GameBoardView!
    @IBOutlet weak var bestScoreLabel: UILabel!
    @IBOutlet weak var currentScoreLabel: UILabel!
    
    let gameBoard = GameBoard(rows: 4, columns: 4)
    
    var bestScore: Int = 0 {
        didSet {
            bestScoreLabel.text = "Best score: \(bestScore)"
            NSUserDefaults.standardUserDefaults().setInteger(bestScore, forKey: "bestScore")
        }
    }
    
    var currentScore: Int = 0 {
        didSet {
            currentScoreLabel.text = "Your score: \(currentScore)"
            if currentScore > bestScore {
                bestScore = currentScore
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        gameBoard.linkSlots()
        gameBoard.updateScore = { (score: Int) -> () in
            self.currentScore = score
        }
        bestScore = NSUserDefaults.standardUserDefaults().integerForKey("bestScore")
        gameBoardView.initialize(gameBoard)
    }
    
    override func viewDidAppear(animated: Bool) {
        gameBoard.spawnTile()
    }

    @IBAction func swipeGestureRecognized(sender: UISwipeGestureRecognizer) {
        var slid = false
        switch sender.direction {
            case UISwipeGestureRecognizerDirection.Left: slid = gameBoard.slide(.Left)
            case UISwipeGestureRecognizerDirection.Right: slid = gameBoard.slide(.Right)
            case UISwipeGestureRecognizerDirection.Up: slid = gameBoard.slide(.Up)
            case UISwipeGestureRecognizerDirection.Down: slid = gameBoard.slide(.Down)
            default: break
        }
        if slid {
            gameBoard.spawnTile()
            if gameBoard.isGameOver() {
                gameOver()
            }
        }
    }
    
    func restart() {
        gameBoard.restart()
        currentScore = 0
    }
    
    func gameOver() {
        let alert = UIAlertController(title: "Game over", message: nil, preferredStyle: .Alert)
        let restartAction = UIAlertAction(title: "Play again", style: .Default) { (action) -> Void in
            self.restart()
        }
        let menuAction = UIAlertAction(title: "Menu", style: .Cancel) { (action) -> Void in
            self.navigationController?.popViewControllerAnimated(true)
        }
        alert.addAction(restartAction)
        alert.addAction(menuAction)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func restartButtonTapped(sender: UIButton) {
        restart()
    }
    
    @IBAction func backButtonTapped(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }
    
}

