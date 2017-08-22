//
//  EndScene.swift
//  Bunny
//
//  Created by Emre Yıldırım on 10/08/2017.
//  Copyright © 2017 Emre Yildirim. All rights reserved.
//

import SpriteKit

class EndScene: SKScene {
    
    var buttonNext: MSButtonNode!
    var buttonNext2: MSButtonNode!
    
    override func didMove(to view: SKView) {
        buttonNext = childNode(withName: "buttonNext") as! MSButtonNode
        buttonNext.selectedHandler = {
            let skView = self.view as SKView!
            let scene = Gmail(fileNamed: "Gmail")
            scene?.scaleMode = .aspectFill
            skView?.presentScene(scene)
        }
    
        buttonNext2 = childNode(withName: "buttonNext2") as! MSButtonNode
        buttonNext2.selectedHandler = {
            let skView = self.view as SKView!
            let scene = Gmail(fileNamed: "Gmail")
            scene?.scaleMode = .aspectFill
            skView?.presentScene(scene)
        }
    }
}
