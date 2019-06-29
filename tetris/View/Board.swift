//
//  Board.swift
//  tetris
//
//  Created by Fidan on 29.06.2019.
//  Copyright © 2019 Fidan. All rights reserved.
//

import Foundation
import UIKit

class GameBoard: UIView {
    
    static let rows = 22
    static let cols = 10
    static let gap = 1
    static let brickSize = Int(UIScreen.main.bounds.size.width*(24/375.0))
    static let smallBrickSize = Int(UIScreen.main.bounds.size.width*(18/375.0))
    static let width  = GameBoard.brickSize * GameBoard.cols + GameBoard.gap * (GameBoard.cols+1)
    static let height = GameBoard.brickSize * GameBoard.rows + GameBoard.gap * (GameBoard.rows+1)
    static let EmptyColor = UIColor.black
    static let strokeColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
    
    var board = [[UIColor]]()
    var currentBrick:Brick?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red:0.21, green:0.21, blue:0.21, alpha:1.0)
        self.clear()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func generateRow() -> [UIColor]! {
        var row = [UIColor]()
        for _ in 0..<GameBoard.cols {
            row.append(GameBoard.EmptyColor)
        }
        return row
    }
    
    override func draw(_ rect: CGRect) {
        // draw game board
        for r in  0..<GameBoard.rows {
            for c in 0..<GameBoard.cols {
                let color = self.board[r][c]
                self.drawAtRow(r, col: c, color:color)
            }
        }
    }
    
    func drawAtRow(_ r:Int, col c:Int, color:UIColor!) {
        let context = UIGraphicsGetCurrentContext()
        let block = CGRect(x: CGFloat((c+1)*GameBoard.gap + c*GameBoard.brickSize),
                           y: CGFloat((r+1)*GameBoard.gap + r*GameBoard.brickSize),
                           width: CGFloat(GameBoard.brickSize),
                           height: CGFloat(GameBoard.brickSize))
        
        if color == GameBoard.EmptyColor {
            GameBoard.strokeColor.set()
            context?.fill(block)
        } else {
            color.set()
            UIBezierPath(roundedRect: block, cornerRadius: 1).fill()
        }
    }
    
    func clear() {
        self.currentBrick = nil
        
        self.board = [[UIColor]]()
        for _ in 0..<GameBoard.rows {
            self.board.append(self.generateRow())
        }
        self.setNeedsDisplay()
    }
    
    var topY:CGFloat {
        return CGFloat(3 * GameBoard.brickSize)
    }
    var bottomY:CGFloat {
        return CGFloat((GameBoard.rows-1) * GameBoard.brickSize)
    }
    var centerX:CGFloat {
        return CGFloat(self.currentBrick!.tx * GameBoard.brickSize)
    }
}
