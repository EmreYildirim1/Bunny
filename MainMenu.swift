//
//  MainMenu.swift
//  Bunny
//
//  Created by Emre Yıldırım on 26/07/2017.
//  Copyright © 2017 Emre Yildirim. All rights reserved.
//

import SpriteKit

class MainMenu: SKScene {
    
    var buttonStart: MSButtonNode!
    
    override func didMove(to view: SKView) {
        buttonStart = childNode(withName: "buttonStart") as! MSButtonNode
        buttonStart.selectedHandler = {
            let skView = self.view as SKView!
            let scene = GameScene(fileNamed: "GameScene")
            scene?.scaleMode = .aspectFill
            skView?.presentScene(scene)
        }
    }
}
