//
//  GameOver.swift
//  Bunny
//
//  Created by Emre Yıldırım on 27/07/2017.
//  Copyright © 2017 Emre Yildirim. All rights reserved.
//

import SpriteKit

class GameOver: SKScene {
    
    var backButton: MSButtonNode!
    var restartButton: MSButtonNode!
    
    override func didMove(to view: SKView) {
        restartButton = childNode(withName: "restartButton") as! MSButtonNode
        restartButton.selectedHandler = {
            let skView = self.view as SKView!
            let scene = GameScene(fileNamed: "GameScene")
            scene?.scaleMode = .aspectFill
            skView?.presentScene(scene)
        }
    
//        backButton = childNode(withName: "backButton") as! MSButtonNode
//        backButton.selectedHandler = {
//            let skView = self.view as SKView!
//            let scene = MainMenu(fileNamed: "MainMenu")
//            scene?.scaleMode = .aspectFill
//            skView?.presentScene(scene)
//        }
    }
}

