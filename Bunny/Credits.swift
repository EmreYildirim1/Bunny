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
    
    var backButton: MSButtonNode!
    
    override func didMove(to view: SKView) {
    
        backButton = childNode(withName: "backButton") as! MSButtonNode
        backButton.selectedHandler = {
            let skView = self.view as SKView!
            let scene = MainMenu(fileNamed: "MainMenu")
            scene?.scaleMode = .aspectFit
            skView?.presentScene(scene)
        }
    }
}
