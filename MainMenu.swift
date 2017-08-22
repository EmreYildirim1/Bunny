//
//  MainMenu.swift
//  Bunny
//
//  Created by Emre Yıldırım on 26/07/2017.
//  Copyright © 2017 Emre Yildirim. All rights reserved.
//
import AVFoundation
import SpriteKit

var bombSoundEffect: AVAudioPlayer!
let path = Bundle.main.path(forResource: "Cyborg Ninja.mp3", ofType: nil)

class MainMenu: SKScene {
    
    var buttonPlay: MSButtonNode!
    var buttonPlay2: MSButtonNode!
    var creditsButton: MSButtonNode!
    var creditsButton2: MSButtonNode!

    

    
    override func didMove(to view: SKView) {
        let url = URL(fileURLWithPath: path!)
        do {
            let sound = try AVAudioPlayer(contentsOf: url)
            bombSoundEffect = sound
            bombSoundEffect.numberOfLoops = -1
            sound.play()
        } catch {
            //could not load the file
        }
        buttonPlay = childNode(withName: "buttonPlay") as! MSButtonNode
        buttonPlay.selectedHandler = {
            let skView = self.view as SKView!
            let scene = GameScene(fileNamed: "GameScene")
            scene?.scaleMode = .aspectFill
            skView?.presentScene(scene)
        }
        
        buttonPlay2 = childNode(withName: "buttonPlay2") as! MSButtonNode
        buttonPlay2.selectedHandler = {
            let skView = self.view as SKView!
            let scene = GameScene(fileNamed: "GameScene")
            scene?.scaleMode = .aspectFill
            skView?.presentScene(scene)
        }
        
        creditsButton = childNode(withName: "creditsButton") as! MSButtonNode
        creditsButton.selectedHandler = {
            let skView = self.view as SKView!
            let scene = Credits(fileNamed: "Credits")
            scene?.scaleMode = .aspectFill
            skView?.presentScene(scene)
            
        }
    
        creditsButton2 = childNode(withName: "creditsButton2") as! MSButtonNode
        creditsButton2.selectedHandler = {
            let skView = self.view as SKView!
            let scene = Credits(fileNamed: "Credits")
            scene?.scaleMode = .aspectFill
            skView?.presentScene(scene)

        }
    }
}
