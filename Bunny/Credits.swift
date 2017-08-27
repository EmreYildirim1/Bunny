//
//  Credits.swift
//  Bunny
//
//  Created by Emre Yıldırım on 21/08/2017.
//  Copyright © 2017 Emre Yildirim. All rights reserved.
//

import Foundation
import SpriteKit

class Credits: SKScene {
    
    var buttonMenu: MSButtonNode!
    var buttonMenu2: MSButtonNode!
    
    override func didMove(to view: SKView) {
        buttonMenu = childNode(withName: "buttonMenu") as! MSButtonNode
        buttonMenu.selectedHandler = {
            let skView = self.view as SKView!
            let scene = MainMenu(fileNamed: "MainMenu")
            scene?.scaleMode = .aspectFit
            skView?.presentScene(scene)
        }
    
        buttonMenu2 = childNode(withName: "buttonMenu2") as! MSButtonNode
        buttonMenu2.selectedHandler = {
            let skView = self.view as SKView!
            let scene = MainMenu(fileNamed: "MainMenu")
            scene?.scaleMode = .aspectFit
            skView?.presentScene(scene)
        }
    }
}
