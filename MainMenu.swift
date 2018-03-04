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
var isVolumeOn = true

class MainMenu: SKScene {
    
    var buttonPlay: MSButtonNode!
    var buttonPlay2: MSButtonNode!
    var creditsButton: MSButtonNode!
    var creditsButton2: MSButtonNode!
    var vb: SKSpriteNode!
    
    
    override func didMove(to view: SKView) {
        vb = self.childNode(withName: "volumeButton") as! SKSpriteNode
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
            scene?.scaleMode = .aspectFit
            skView?.presentScene(scene)
        }
        
        creditsButton = childNode(withName: "creditsButton") as! MSButtonNode
        creditsButton.selectedHandler = {
            let skView = self.view as SKView!
            let scene = Credits(fileNamed: "Credits")
            scene?.scaleMode = .aspectFit
            skView?.presentScene(scene)
            
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let position = t.location(in: self)
            let node = atPoint(position)
            
            if node.name == "volumeButton" {
                if isVolumeOn == true {
                    isVolumeOn = false
                    let url = URL(fileURLWithPath: path!)
                    do {
                        let sound = try AVAudioPlayer(contentsOf: url)
                        bombSoundEffect = sound
                        sound.stop()
                    } catch {
                        //could not load the file
                    }
                    vb.texture = SKTexture(imageNamed: "tex1")
                }
                else {
                    isVolumeOn = true
                    let url = URL(fileURLWithPath: path!)
                    do {
                        let sound = try AVAudioPlayer(contentsOf: url)
                        bombSoundEffect = sound
                        bombSoundEffect.numberOfLoops = -1
                        sound.play()
                    } catch {
                        //could not load the file
                    }
                    vb.texture = SKTexture(imageNamed: "tex2")
                }
            }
        }
    }
}
