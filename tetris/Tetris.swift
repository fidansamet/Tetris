//
//  Tetris.swift
//  tetris
//
//  Created by Fidan on 2.07.2019.
//  Copyright © 2019 Fidan. All rights reserved.
//

import UIKit


class Tetris: NSObject {
    // Notification
    static var LineClearNotification                   = "LineClearNotification"
    static var NewBrickDidGenerateNotification         = "NewBrickDidGenerateNotification"
    
    // font
    static func GameFont(_ fontSize:CGFloat) -> UIFont! {
        return UIFont(name: "ChalkboardSE-Regular", size: fontSize)
    }
    
    var gameView:GameView!
    
    required init(gameView:GameView) {
        super.init()
        self.gameView = gameView
        self.initGame()
    }
    
    deinit {
        debugPrint("deinit Tetris")
    }
    
    fileprivate func initGame() {
        
        self.addLongPressAction(#selector(Tetris.longPressed(_:)), toView:self.gameView.gameBoard)
        
//        self.addRotateAction(#selector(Tetris.rotateBrick), toButton: self.gameView.rotateButton)
    }
    
    func deinitGame() {
        self.gameOver()
        self.gameView = nil
    }
    
    @objc func longPressed(_ longpressGesture:UILongPressGestureRecognizer) {
        if longpressGesture.state == UIGestureRecognizer.State.began {
            self.gameView.gameBoard.dropBrick()
        }
    }
    
    @objc func gameLoop() {
        self.update()
        self.gameView.setNeedsDisplay()
    }
    
    fileprivate func update() {
        
        let game = self.gameView.gameBoard.update()
        if game.isGameOver {
            self.gameOver()
            return
        }
    }
    
    fileprivate func prepare() {
        self.gameView.prepare()
        self.gameView.gameBoard.generateBrick()
    }
    
    fileprivate func gameOver() {
    }
    
    // game interaction
    func touch(_ touch:UITouch) {
        guard let _ = self.gameView.gameBoard.currentBrick else { return }
        
        let p = touch.location(in: self.gameView.gameBoard)
        
        let half = self.gameView.gameBoard.centerX
        
        if p.x > half {
            self.gameView.gameBoard.updateX(1)
        } else if p.x < half {
            self.gameView.gameBoard.updateX(-1)
        }
    }
    
    fileprivate func addLongPressAction(_ action:Selector, toView view:UIView) {
        let longpressGesture = UILongPressGestureRecognizer(target: self, action: action)
        view.addGestureRecognizer(longpressGesture)
    }
}
