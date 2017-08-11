//
//  Congratulations.swift
//  Bunny
//
//  Created by Emre Yıldırım on 10/08/2017.
//  Copyright © 2017 Emre Yildirim. All rights reserved.
//

import SpriteKit

class Congratulations: SKScene {
    
    var buttonPlay: MSButtonNode!
    
    override func didMove(to view: SKView) {
        buttonPlay = childNode(withName: "buttonPlay") as! MSButtonNode
        buttonPlay.selectedHandler = {
            let skView = self.view as SKView!
            let scene = FinishScene(fileNamed: "FinishScene")
            scene?.scaleMode = .aspectFill
            skView?.presentScene(scene)
        }
    }
}
