//
//  GameScene.swift
//  Bunny
//
//  Created by Emre Yıldırım on 7/23/17.
//  Copyright © 2017 Emre Yildirim. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    /* Its for the swiping */
    var start: (location: CGPoint, time: TimeInterval)?
    
    var spawnPosition: SKNode!
    
    var spawnPosition2: SKNode!
    
    var coinSpawnTimer: CGFloat = 0
    
    var spawnTimer: CFTimeInterval = 0
    
    var randomTime: Int = Int(arc4random_uniform (3) + UInt32(2))
    
    var spawnTimer2: CFTimeInterval = 0
    
    let coinSpeed: CGFloat = 90
    
    let minDistance:CGFloat = 25
    
    let minSpeed:CGFloat = 1000
    
    let maxSpeed:CGFloat = 6000
    
    var player: SKSpriteNode!
    
    var coin : SKSpriteNode!
    
    var scrollLayer: SKNode!
    
    var scrollLayer2: SKNode!
    
    var scrollLayer3: SKNode!
    
    var scoreLabel: SKLabelNode!
    
    var obstacleSource: SKNode!
    
    var obstacleLayer: SKNode!
    
    var obstacleSource2: SKNode!
    
    var obstacleLayer2 : SKNode!
    
    var points = 1
    
    let fixedDelta: CFTimeInterval = 1.0 / 60.0 /* 60 FPS */
    
    /* This gives the grounds velocity */
    let scrollSpeed: CGFloat = 1000
    
    var coins : [SKSpriteNode] = []
    
    var center = CGFloat()
    
    // It connects everything to the GameScene.swift
    override func didMove(to view: SKView) {
        /* Setup the scene there */
        
        // !!!!!!!!!!!!!!!!!!!!!!!!!!
        physicsWorld.contactDelegate = self
        
        //code connection for spawnPosition
        spawnPosition = childNode(withName: "spawnPosition")
        
        spawnPosition2 = childNode(withName: "spawnPosition2")
        
        /* The connection of player and the scene */
        player = self.childNode(withName: "//player") as! SKSpriteNode!
        
        /* The connection of scrollLayer and the scene */
        scrollLayer = self.childNode(withName: "scrollLayer")
        
        /* The connection of scrollLayer2 and the scene */
        scrollLayer2 = self.childNode(withName: "scrollLayer2")
        
        scrollLayer3 = self.childNode(withName: "scrollLayer3")
        
        /* Set reference to obstacle layer node */
        obstacleLayer = self.childNode(withName: "obstacleLayer")
        
        obstacleLayer2 = self.childNode(withName: "obstacleLayer2")
        
        scoreLabel = childNode(withName: "scoreLabel") as! SKLabelNode
        
        coin = childNode(withName: "//coin") as! SKSpriteNode!
        
        /* Set reference to obstacle Source node */
        obstacleSource = self.childNode(withName: "obstacle")
        
        obstacleSource2 = self.childNode(withName: "obstacle2")
        
        center = UIScreen.main.bounds.size.width
    }
    
    //Physics
    func didBegin(_ contact: SKPhysicsContact) {
        /* Get references to bodies involved in collision */
        let contactA = contact.bodyA
        let contactB = contact.bodyB
        
        /* Get references to the physics body parent nodes */
        let nodeA = contactA.node!
        let nodeB = contactB.node!
        
        /* Did our hero pass through the 'goal'? */
        if nodeA.name == "coin" || nodeB.name == "coin" {
            
            /* Increment points */
            points += 1
            
            /* Update score label */
            scoreLabel.text = String(points)
            
            /*Remove Coin*/
            if nodeA.name == "coin"{
                nodeA.removeFromParent()
            } else if nodeB.name == "coin"{
                nodeB.removeFromParent()
            }
            
            /* We can return now */
            return
        }
        
        if nodeA.name == "obstacle" || nodeB.name == "obstacle" {
            
            if nodeA.name == "obstacle"{
                nodeA.removeFromParent()
                
                let skView = self.view as SKView!
                let scene = GameOver(fileNamed: "GameOver")
                scene?.scaleMode = .aspectFill
                skView?.presentScene(scene)
                
            }
        }
        
        if nodeA.name == "obstacle2" || nodeB.name == "obstacle2" {
            
            if nodeA.name == "obstacle2"{
                nodeA.removeFromParent()
                
                let skView = self.view as SKView!
                let scene = GameOver(fileNamed: "GameOver")
                scene?.scaleMode = .aspectFill
                skView?.presentScene(scene)
            }
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Called when a touch begins
        print(player.position.y)
        //        if player.position.y <= CGFloat(300) {
        // Where can you change player jumping
        //            player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 300))
        //            // The Jump action
        //            if player.position.y < CGFloat(273){
        //                player.run(SKAction(named: "Jump")!)
        //            }
        // Slide Action
        //            if player.position.y > CGFloat(0) {
        //                player.run(SKAction(named: "Slide")!)
        //            }
        //        }
        /* Its about swiping */
        if let touch = touches.first {
            start = (touch.location(in: self), touch.timestamp)
        }
    }
    // This is a swipe func
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        var swiped = false
        if let touch = touches.first, let startTime = self.start?.time,
            let startLocation = self.start?.location {
            let location = touch.location(in:self)
            let dx = location.x - startLocation.x
            let dy = location.y - startLocation.y
            let distance = sqrt(dx*dx+dy*dy)
            
            // Check if the user's finger moved a minimum distance
            if distance > minDistance {
                let deltaTime = CGFloat(touch.timestamp - startTime)
                let speed = distance / deltaTime
                
                // Check if the speed was consistent with a swipe
                if speed >= minSpeed && speed <= maxSpeed {
                    
                    // Determine the direction of the swipe
                    let x = abs(dx/distance) > 0.4 ? Int(sign(Float(dx))) : 0
                    let y = abs(dy/distance) > 0.4 ? Int(sign(Float(dy))) : 0
                    
                    swiped = true
                    switch (x,y) {
                    case (0,1):
                        print("swiped up")
                        if player.position.y <= CGFloat(300) {
                            // The players jump height
                            player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 600))
                            player.run(SKAction(named: "Jump")!)
                        }
                    case (0,-1):
                        print("swiped down")
                        player.run(SKAction(named: "Slide")!)
                    case (-1,0):
                        print("swiped left")
                    case (1,0):
                        print("swiped right")
                        player.run(SKAction(named: "Attack")!)
                    case (1,1):
                        print("swiped diag up-right")
                        if player.position.y <= CGFloat(450) {
                            // The players jump height
                            player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 600))
                            player.run(SKAction(named: "Jump")!)
                        }
                    case (-1,-1):
                        print("swiped diag down-left")
                    case (-1,1):
                        print("swiped diag up-left")
                    case (1,-1):
                        print("swiped diag down-right")
                        player.run(SKAction(named: "Slide")!)
                    default:
                        swiped = false
                        break
                    }
                }
            }
        }
        start = nil
        if !swiped {
            // Process non-swipes (taps, etc.)
            print("not a swipe")
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Grab current velocity
        let velocityY = player.physicsBody?.velocity.dy ?? 0
        
        // Check and Cap vertical velocity
        if velocityY > 500 {
            player.physicsBody?.velocity.dy = 500
        }
        // It rolls the ground
        scrollWorld()
        
        /* Process obstacles */
        updateObstacles()
        
        updateObstacles2()
        
        spawnTimer += fixedDelta
        spawnTimer2 += fixedDelta
        
        /* Loop through scroll layer nodes */
        for ground in scrollLayer.children as! [SKSpriteNode] {
            
            /* Get ground node position, convert node position to scene space */
            let groundPosition = scrollLayer.convert(ground.position, to: self)
            
            /* Check if ground sprite has left the scene */
            if groundPosition.x <= -ground.size.width / 1 {
                
                /* Reposition ground sprite to the second starting position */
                let newPosition = CGPoint(x: (self.size.width / 1) + ground.size.width - 20, y: groundPosition.y)
                
                /* Convert new node position back to scroll layer space */
                ground.position = self.convert(newPosition, to: scrollLayer)
            }
        }
        
        /* Loop through scroll layer 2 nodes */
        for building in scrollLayer2.children as! [SKSpriteNode] {
            
            /* Get building node position, convert node position to scene space */
            let buildingPosition = scrollLayer2.convert(building.position, to: self)
            
            /* Check if building sprite has left the scene */
            if buildingPosition.x <= -building.size.width / 1 {
                
                /* Reposition building sprite to the second starting position */
                let newPosition = CGPoint(x: (self.size.width / 1) + building.size.width, y: buildingPosition.y)
                
                /* Convert new node position back to scroll layer space */
                building.position = self.convert(newPosition, to: scrollLayer2)
            }
        }
        
        if coinSpawnTimer > 1 {
            spawnCoins()
            coinSpawnTimer = 0
        }
        
        coinSpawnTimer += CGFloat(fixedDelta)
        
        for node in coins {
            node.position.x -= coinSpeed * CGFloat(fixedDelta)
            if node.position.x < -UIScreen.main.bounds.size.height * 2 {
                node.removeFromParent()
                coins.remove(at: coins.index(of: node)!)
            }
        }
                // It loads the another scene if you collect or make something
                if Int(scoreLabel.text!)! == 1000 {
                    let skView = self.view as SKView!
                    let scene = FinishScene(fileNamed: "FinishScene")!
                    scene.scaleMode = .aspectFill
                    skView?.presentScene(scene)
        }
    }
    
    func scrollWorld() {
        /* Scroll World */
        scrollLayer.position.x -= scrollSpeed * CGFloat(fixedDelta)
        scrollLayer2.position.x -= scrollSpeed * CGFloat(fixedDelta)
        scrollLayer3.position.x -= scrollSpeed * CGFloat(fixedDelta)
        //        obstacleLayer.position.x -= scrollSpeed * CGFloat(fixedDelta)
    }
    
    func spawnCoins() {
        
        coin.position.x -= scrollSpeed * CGFloat(fixedDelta)
        
        let spawnLocation = spawnPosition2.position.y
        
        //        let x = CGFloat(arc4random_uniform(UInt32(center * 2 - coin.size.width / 2))) + coin.size.width / 2
        let coinCopy = coin.copy() as! SKSpriteNode
        //        coinCopy.position.x = CGFloat(90)
        coinCopy.position = convert(CGPoint(x: coin.position.x,y: spawnLocation), to: scrollLayer3)
        coins.append(coinCopy)
        scrollLayer3.addChild(coinCopy)
    }
    
    func updateObstacles() {
        /* Update Obstacles */
        
        obstacleLayer.position.x -= scrollSpeed * CGFloat(fixedDelta)
        
        let spawnLocation = spawnPosition.position.x
        
        /* Loop through obstacle layer nodes */
        for obstacle in obstacleLayer.children as! [SKReferenceNode] {
            
            /* Get obstacle node position, convert node position to scene space */
            let obstaclePosition = obstacleLayer.convert(obstacle.position, to: self)
            
            /* Check if obstacle has left the scene */
            if obstaclePosition.x <= -26 {
                // 26 is one half the width of an obstacle
                
                /* Remove obstacle node from obstacle layer */
                obstacle.removeFromParent()
            }
        }
        /* Time to add a new obstacle? */
        if spawnTimer >= Double(randomTime) {
            
            if spawnTimer.truncatingRemainder(dividingBy: 6) != 0 {
                /* Create a new obstacle by copying the source obstacle */
                let newObstacle = obstacleSource.copy() as! SKNode
                obstacleLayer.addChild(newObstacle)
                
                
                /* Convert new node position back to obstacle layer space */
                newObstacle.position = self.convert(CGPoint(x:spawnLocation,y: 100),  to: obstacleLayer)
                
                // Reset spawn timer
                spawnTimer = 0
                randomTime = Int(arc4random_uniform(2) + UInt32(2))
            }
        }
        
        spawnTimer+=fixedDelta
    }
    
    func updateObstacles2() {
        /* Update Obstacles */
        
        obstacleLayer2.position.x -= scrollSpeed * CGFloat(fixedDelta)
        
        let spawnLocation = spawnPosition2.position.x
        
        /* Loop through obstacle layer nodes */
        for obstacle2 in obstacleLayer2.children as! [SKReferenceNode] {
            
            /* Get obstacle node position, convert node position to scene space */
            let obstaclePosition2 = obstacleLayer2.convert(obstacle2.position, to: self)
            
            /* Check if obstacle has left the scene */
            if obstaclePosition2.x <= -26 {
                // 26 is one half the width of an obstacle
                
                /* Remove obstacle node from obstacle layer */
                obstacle2.removeFromParent()
            }
        }
        /* Time to add a new obstacle? */
        if spawnTimer2 >= 3 {
            
            /* Create a new obstacle by copying the source obstacle */
            let newObstacle2 = obstacleSource2.copy() as! SKNode
            obstacleLayer2.addChild(newObstacle2)
            
            
            /* Convert new node position back to obstacle layer space */
            newObstacle2.position = self.convert(CGPoint(x:spawnLocation,y: 300),  to: obstacleLayer2)
            
            // Reset spawn timer
            spawnTimer2 = 0
        }
        //spawnTimer+=fixedDelta
    }
    
    // claaaaaasssss
}
