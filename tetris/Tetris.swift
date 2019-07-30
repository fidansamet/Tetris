import UIKit


enum GameState:Int {
    case stop = 0
    case play
    case pause
}

class Tetris: NSObject {
    // Notification
    static var LineClearNotification                   = "LineClearNotification"
    static var NewBrickDidGenerateNotification         = "NewBrickDidGenerateNotification"
    static var GameStateChangeNotification             = "GameStateChangeNotification"
    
    // font
    static func GameFont(_ fontSize:CGFloat) -> UIFont! {
        return UIFont(name: "ChalkboardSE-Regular", size: fontSize)
    }
    
    var gameView:GameView!
    
    var gameState = GameState.stop
    
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
        
        self.addGameStateChangeNotificationAction(#selector(Tetris.gameStateChange(_:)))
    }
    
    func deinitGame() {
        self.stop()
        self.removeGameStateChangeNotificationAction()
        
        self.gameView = nil
    }
    
    @objc func gameStateChange(_ noti:Notification) {
        guard let userInfo = noti.userInfo as? [String:NSNumber] else { return }
        guard let rawValue = userInfo["gameState"] else { return }
        guard let toState = GameState(rawValue: rawValue.intValue) else { return }
        
        switch self.gameState {
        case .play:
            // pause
            if toState == GameState.pause {
                self.pause()
            }
            // stop
            if toState == GameState.stop {
                self.stop()
            }
        case .pause:
            // resume game
            if toState == GameState.play {
                self.play()
            }
            // stop
            if toState == GameState.stop {
                self.stop()
            }
        case .stop:
            // start game
            if toState == GameState.play {
                self.prepare()
                self.play()
            }
        }
    }
    
    
    @objc func longPressed(_ longpressGesture:UILongPressGestureRecognizer) {
        if self.gameState == GameState.play {
            if longpressGesture.state == UIGestureRecognizer.State.began {
                self.gameView.gameBoard.dropBrick()
            }
        }
    }
    
    @objc func gameLoop() {
        self.update()
        self.gameView.setNeedsDisplay()
    }
    fileprivate func update() {
    
    }
    
    fileprivate func prepare() {
        self.gameView.prepare()
        self.gameView.gameBoard.generateBrick()
    }
    fileprivate func play() {
        self.gameState = GameState.play
    }
    fileprivate func pause() {
        self.gameState = GameState.pause
    }
    fileprivate func stop() {
        self.gameState = GameState.stop
        self.gameView.clear()
    }
    
    fileprivate func gameOver() {
        self.gameState = GameState.stop
    }
    
    // game interaction
    func touch(_ touch:UITouch) {
        guard self.gameState == GameState.play else { return }
        guard let _ = self.gameView.gameBoard.currentBrick else { return }
        
        let p = touch.location(in: self.gameView.gameBoard)
        
        let half = self.gameView.gameBoard.centerX
        
        if p.x > half {
            self.gameView.gameBoard.updateX(1)
        } else if p.x < half {
            self.gameView.gameBoard.updateX(-1)
        }
    }
    
    @objc func rotateBrick() {
        guard self.gameState == GameState.play else { return }
        guard let _ = self.gameView.gameBoard.currentBrick else { return }
        
        self.gameView.gameBoard.rotateBrick()
    }
    
    fileprivate func addLongPressAction(_ action:Selector, toView view:UIView) {
        let longpressGesture = UILongPressGestureRecognizer(target: self, action: action)
        view.addGestureRecognizer(longpressGesture)
    }
    
    fileprivate func addGameStateChangeNotificationAction(_ action:Selector) {
        NotificationCenter.default.addObserver(self,
                                               selector: action,
                                               name: NSNotification.Name(rawValue: Tetris.GameStateChangeNotification),
                                               object: nil)
    }
    fileprivate func removeGameStateChangeNotificationAction() {
        NotificationCenter.default.removeObserver(self)
    }
    
}
