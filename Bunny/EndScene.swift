//
//  EndScene.swift
//  Bunny
//
//  Created by Emre Yıldırım on 10/08/2017.
//  Copyright © 2017 Emre Yildirim. All rights reserved.
//

import SpriteKit

class EndScene: SKScene {
    
    var buttonMenu: MSButtonNode!
    
    override func didMove(to view: SKView) {
        buttonMenu = childNode(withName: "buttonMenu") as! MSButtonNode
        buttonMenu.selectedHandler = {
            let skView = self.view as SKView!
            let scene = MainMenu(fileNamed: "MainMenu")
            scene?.scaleMode = .aspectFill
            skView?.presentScene(scene)
        }
    }
}
