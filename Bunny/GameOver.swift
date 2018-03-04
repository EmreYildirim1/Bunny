//
//  GameOver.swift
//  Bunny
//
//  Created by Emre Yıldırım on 27/07/2017.
//  Copyright © 2017 Emre Yildirim. All rights reserved.
//

import SpriteKit
import GoogleMobileAds

let defaults = UserDefaults.standard // allows us to access and store data on the phone

class GameOver: SKScene {
    
    var restartButton: MSButtonNode!
    var highScoreLabel: SKLabelNode!
    var resumeButton: MSButtonNode!
    
    var currentScene: SKScene!
    
    var adView: GoogleAdViewController!
    
    override func didMove(to view: SKView) {
        restartButton = childNode(withName: "restartButton") as! MSButtonNode!
        highScoreLabel = childNode(withName: "highScoreLabel") as! SKLabelNode!
        resumeButton = childNode(withName: "resumeButton") as! MSButtonNode!
        
        restartButton.selectedHandler = {
            let skView = self.view as SKView!
            let scene = GameScene(fileNamed: "GameScene")
            scene?.scaleMode = .aspectFit
            skView?.presentScene(scene)
        }
        
        adView = GoogleAdViewController()
        
        resumeButton.selectedHandler = {
            let scene = self.currentScene
            scene?.view?.isPaused = false
            scene?.scaleMode = .aspectFit
            
            //let skView = self.view?.window?.rootViewController
            self.adView.currentScene = self.currentScene
            //skView?.present(self.adView, animated: true, completion: nil)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            //show window
            appDelegate.window?.rootViewController = self.adView
        }
        
         highScoreLabel.text = String(defaults.integer(forKey: "highScore"))
        
    }
}
