//
//  FinishScene.swift
//  Bunny
//
//  Created by Emre Yıldırım on 02/08/2017.
//  Copyright © 2017 Emre Yildirim. All rights reserved.
//

import SpriteKit

class FinishScene: SKScene, SKPhysicsContactDelegate {
    
    let fixedDelta: CGFloat = 1.0 / 60.0 // 60 FPS
    
    var watermelonSpawnTimer: CGFloat = 0
    
    var katanaSpawnTimer: CGFloat = 0
    
    var bananaSpawnTimer: CGFloat = 0
    
    /* it gives enemy speed (velocity) */
    let watermelonSpeed: CGFloat = 1000
    
    /* it gives bomb speed (velocity)*/
    let katanaSpeed: CGFloat = 1000
    
    /* it gives taco speed (velocity) */
    let bananaSpeed: CGFloat = 1000
    
    var player : Player!
    
    var katana : SKSpriteNode!
    
    var watermelon : SKSpriteNode!
    
    var banana : SKSpriteNode!
    
    var scoreLabel : SKLabelNode!
    
    var actualScore: Int = 0
    
    var bestScore: Int = 0
    
    var score : Int = 0 {
        didSet {
            scoreLabel.text = String(score)
        }
    }
    
    var center = CGFloat()
    
    var canMove = false, moveLeft = false
    
    var watermelons: [SKSpriteNode] = []
    
    var katanas: [SKSpriteNode] = []
    
    var bananas: [SKSpriteNode] = []
    
    override func didMove(to view: SKView) {
        self.view?.showsPhysics = false
        initializeGame();
    }
    
    override func update(_ currentTime: TimeInterval) {
        managePlayer()
        player.position.x = clamp(value: player.position.x, lower: player.size.width / 2, upper: UIScreen.main.bounds.size.width * 2 - player.size.width / 2)
        
        if watermelonSpawnTimer > 3.5 {
            spawnWatermelon()
            watermelonSpawnTimer = 0
        }
        
        if katanaSpawnTimer > 1.5  {
            spawnKatanas()
            katanaSpawnTimer = 0
        }
        
        if bananaSpawnTimer > 2.5 {
            spawnBananas()
            bananaSpawnTimer = 0
        }
        
        for node in katanas {
            node.position.y -= katanaSpeed * fixedDelta
            if node.position.y < -UIScreen.main.bounds.height * 2 {
                node.removeFromParent()
                katanas.remove(at: katanas.index(of: node)!)
            }
        }
        
        watermelonSpawnTimer += fixedDelta
        
        for node in watermelons {
            node.position.y -= watermelonSpeed * fixedDelta
            if node.position.y < -UIScreen.main.bounds.size.height * 2 {
                node.removeFromParent()
                watermelons.remove(at: watermelons.index(of: node)!)
            }
        }
    
        katanaSpawnTimer += fixedDelta
        
        for node in bananas {
            node.position.y -= bananaSpeed * fixedDelta
            if node.position.y < -UIScreen.main.bounds.size.height * 2 {
                node.removeFromParent()
                bananas.remove(at: bananas.index(of: node)!)
            }
        }
        bananaSpawnTimer += fixedDelta
        
        // It loads the another scene if you collect or make something
        if Int(scoreLabel.text!)! == 250 {
            let skView = self.view as SKView!
            let scene = EndScene(fileNamed: "EndScene")!
            scene.scaleMode = .aspectFill
            skView?.presentScene(scene)
        }
    }
    
    func initializeGame() {
        physicsWorld.contactDelegate = self
        player = childNode(withName: "Player") as! Player!
        watermelon = childNode(withName: "watermelon") as! SKSpriteNode
        center = UIScreen.main.bounds.size.width / 2
        katana = childNode(withName: "katana") as! SKSpriteNode
        banana = childNode(withName: "banana") as! SKSpriteNode
        scoreLabel = childNode(withName: "scoreLabel") as! SKLabelNode
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node
        
        // it is the points of enemy, taco and bomb
        
        if nodeA?.name == "watermelon" || nodeB?.name == "watermelon" {
            score += 2
            if nodeA?.name == "watermelon" {
                watermelons.remove(at: watermelons.index(of: nodeA as! SKSpriteNode)!)
                nodeA?.removeFromParent()
            } else if nodeB?.name == "watermelon" {
                watermelons.remove(at: watermelons.index(of: nodeB as! SKSpriteNode)!)
                nodeB?.removeFromParent()
            }
        } else if nodeA?.name == "banana" || nodeB?.name == "banana" {
            score += 1
            if nodeA?.name == "banana" {
                bananas.remove(at: bananas.index(of: nodeA as! SKSpriteNode)!)
                nodeA?.removeFromParent()
            } else if nodeB?.name == "banana" {
                bananas.remove(at: bananas.index(of: nodeB as! SKSpriteNode)!)
                nodeB?.removeFromParent()
            }
        } else if nodeA?.name == "katana" || nodeB?.name == "katana" {
            if nodeA?.name == "katana" {
                katanas.remove(at: katanas.index(of: nodeA as! SKSpriteNode)!)
                nodeA?.removeFromParent()
            } else if nodeB?.name == "katanas" {
                katanas.remove(at: katanas.index(of: nodeB as! SKSpriteNode)!)
                nodeB?.removeFromParent()
            }
            let skView = self.view as SKView!
            let scene = GameOver2(fileNamed: "GameOver2")
            scene?.scaleMode = .aspectFill
            skView?.presentScene(scene)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if location.x > center {
                moveLeft = false
            } else {
                moveLeft = true
                
            }
        }
        canMove = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        canMove = false
    }
    
    func managePlayer() {
        if canMove {
            player.move(left: moveLeft)
        }
    }
    
    func spawnWatermelon() {
        let x = CGFloat(arc4random_uniform(UInt32(center * 2))) - center
        let watermelonCopy = watermelon.copy() as! SKSpriteNode
        watermelonCopy.position.x = x
        watermelons.append(watermelonCopy)
        addChild(watermelonCopy)
    }
    
    func spawnKatanas() {
        let x = CGFloat(arc4random_uniform(UInt32(center * 2))) - center
        let katanaCopy = katana.copy() as! SKSpriteNode
        katanaCopy.position.x = x
        katanas.append(katanaCopy)
        addChild(katanaCopy)
    }
    
    func spawnBananas() {
        let x = CGFloat(arc4random_uniform(UInt32(center * 2))) - center
        let bananaCopy = banana.copy() as! SKSpriteNode
        bananaCopy.position.x = x
        bananas.append(bananaCopy)
        addChild(bananaCopy)
    }


func clamp<T: Comparable>(value: T, lower: T, upper: T) -> T {
    return min(max(value, lower), upper)
    }
}
