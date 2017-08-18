//
//  GameOver2.swift
//  Bunny
//
//  Created by Emre Yıldırım on 11/08/2017.
//  Copyright © 2017 Emre Yildirim. All rights reserved.
//

import Foundation

import SpriteKit

class GameOver2: SKScene {
    
    var backButton: MSButtonNode!
    var buttonRestart: MSButtonNode!
    var buttonMenu: MSButtonNode!
    
    override func didMove(to view: SKView) {
        buttonRestart = childNode(withName: "buttonRestart") as! MSButtonNode
        buttonRestart.selectedHandler = {
            let skView = self.view as SKView!
            let scene = FinishScene(fileNamed: "FinishScene")
            scene?.scaleMode = .aspectFill
            skView?.presentScene(scene)
        }
    }
}

