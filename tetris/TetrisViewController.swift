//
//  TetrisViewController.swift
//  tetris
//
//  Created by Fidan on 2.07.2019.
//  Copyright © 2019 Fidan. All rights reserved.
//

import UIKit

class TetrisViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    
    var tetris:Tetris!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeGame()
    }
    
    deinit {
        self.tetris.deinitGame()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initializeGame() {
        // after layout pass, ensure GameView to make
        DispatchQueue.main.async {
            let gameView = GameView(self.contentView)
            self.tetris = Tetris(gameView: gameView)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first  {
            self.tetris.touch(touch)
        }
    }
    
    override var prefersStatusBarHidden : Bool {
        return false
    }
}
