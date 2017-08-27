//
//  Gmail.swift
//  Bunny
//
//  Created by Emre Yıldırım on 18/08/2017.
//  Copyright © 2017 Emre Yildirim. All rights reserved.
//

import Foundation
import SpriteKit

class Gmail: SKScene {
    
    var buttonBack: MSButtonNode!
    var buttonBack2: MSButtonNode!
    
    override func didMove(to view: SKView) {
        buttonBack = childNode(withName: "buttonBack") as! MSButtonNode
        buttonBack.selectedHandler = {
            let skView = self.view as SKView!
            let scene = EndScene(fileNamed: "EndScene")
            scene?.scaleMode = .aspectFit
            skView?.presentScene(scene)
        }
    
        buttonBack2 = childNode(withName: "buttonBack2") as! MSButtonNode
        buttonBack2.selectedHandler = {
            let skView = self.view as SKView!
            let scene = EndScene(fileNamed: "EndScene")
            scene?.scaleMode = .aspectFit
            skView?.presentScene(scene)
        }
    }
}
