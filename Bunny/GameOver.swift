//
//  GameOver.swift
//  Bunny
//
//  Created by Emre Yıldırım on 27/07/2017.
//  Copyright © 2017 Emre Yildirim. All rights reserved.
//

import SpriteKit

let defaults = UserDefaults.standard // allows us to access and store data on the phone

class GameOver: SKScene {
    
    var backButton: MSButtonNode!
    var restartButton: MSButtonNode!
    var restartButton2: MSButtonNode!
    var highScoreLabel: SKLabelNode!
    
    override func didMove(to view: SKView) {
        restartButton = childNode(withName: "restartButton") as! MSButtonNode!
        highScoreLabel = childNode(withName: "highScoreLabel") as! SKLabelNode!
        restartButton.selectedHandler = {
            let skView = self.view as SKView!
            let scene = GameScene(fileNamed: "GameScene")
            scene?.scaleMode = .aspectFit
            skView?.presentScene(scene)
        }
    
        restartButton2 = childNode(withName: "restartButton2") as! MSButtonNode
        restartButton2.selectedHandler = {
            let skView = self.view as SKView!
            let scene = GameScene(fileNamed: "GameScene")
            scene?.scaleMode = .aspectFit
            skView?.presentScene(scene)
        }
        
         highScoreLabel.text = String(defaults.integer(forKey: "highScore"))
        
    }
}
