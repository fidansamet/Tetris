//
//  File.swift
//  tetris
//
//  Created by Fidan on 30.06.2019.
//  Copyright © 2019 Fidan. All rights reserved.
//

import UIKit

class GameView: UIView {
    
    var gameBoard = GameBoard(frame:CGRect.zero)
    
    init(_ superView:UIView) {
        super.init(frame: superView.bounds)
        superView.backgroundColor = UIColor(red:0.27, green:0.27, blue:0.27, alpha:1.0)
        superView.addSubview(self)
        
        self.backgroundColor = UIColor(red:0.27, green:0.27, blue:0.27, alpha:1.0)
        self.gameBoard.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.gameBoard)
        
        let metrics = ["width":GameBoard.width, "height":GameBoard.height]
        let views   = ["gameBoard":self.gameBoard] as [String : Any]
        
        self.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-[gameBoard(width)]",
                options: [],
                metrics:metrics ,
                views:views)
        )
        
        self.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:[gameBoard(height)]-|",
                options: [],
                metrics:metrics ,
                views:views)
        )
        
        self.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-[gameScore]-|",
                options: [],
                metrics:nil ,
                views:views)
        )
        
        self.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-[gameScore]-[gameBoard]",
                options: [],
                metrics:metrics ,
                views:views)
        )
        
        self.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:[gameBoard]-[nextBrick]-|",
                options: NSLayoutConstraint.FormatOptions.alignAllTop,
                metrics:nil ,
                views:views))
        
        self.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:[nextBrick]-|",
                options: [],
                metrics:nil ,
                views:views)
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        debugPrint("deinit GameView")
    }
}
