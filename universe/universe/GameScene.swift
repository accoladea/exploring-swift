//
//  GameScene.swift
//  universe
//
//  Created by Zhan Dov on 6/11/17.
//  Copyright © 2017 accolade. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var starField: SKEmitterNode!
    var s: SKSpriteNode!
    
    var scoreLabel: SKLabelNode!
    var score: Int = 0 {
        didSet {
            scoreLabel?.text = "Score: \(score)"
        }
    }
    
    var gameTimer: Timer!
    
    var possibleAliens = ["alien", "alien2", "alien3"]
    
    let alienCategory:UInt32 = 0x1 << 1
    let photonTorpedoCategory:UInt32 = 0x1 << 0
    
    
    override func didMove(to view: SKView) {
        
        if starField != nil {
            
            starField = SKEmitterNode(fileNamed:"Starfield")
            starField?.position = CGPoint(x: 0, y: self.frame.minY)
            starField?.advanceSimulationTime(10)
            self.addChild(starField!)
            starField?.zPosition = -1
        }  else {
            
            print("Check out a bug on 'starField' ")
            
        }

        
        let sTexture = SKTexture (imageNamed: "shuttle")
        
        if s != nil {
            
            self.addChild(s!)
            s = SKSpriteNode(texture: sTexture)
            s.xScale = 2.5
            s.yScale = 2.5
            s.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 250)
            
        } else {
            
            print("Check out a bug on 's' ")
        
        }
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        self.physicsWorld.contactDelegate = self
        
        if scoreLabel != nil {
            
            scoreLabel = SKLabelNode(text: "Score: 0")
            scoreLabel.position = CGPoint(x: self.frame.minX + 200, y: self.frame.midY + 560)
            scoreLabel.fontName = "AmericanTypewriter-Bold"
            scoreLabel.fontColor = UIColor.white
            scoreLabel.fontSize = 58
            score = 0
            self.addChild(scoreLabel!)
        }  else {
            
            print("Check out a bug on 'scoreLabel' ")
            
        }
        
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(addAlien), userInfo: nil, repeats: true)
     
    }
    
    func addAlien () {
        
        possibleAliens = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: possibleAliens) as! [String]
        
        let alien = SKSpriteNode(imageNamed: possibleAliens[0])
        
        let randomAlienPosition = GKRandomDistribution(lowestValue: Int(self.frame.minX), highestValue: Int(self.frame.maxX))
        
        let position = CGFloat(randomAlienPosition.nextInt())
        
        alien.position = CGPoint(x: position, y: self.frame.size.height + alien.size.height)
        
        alien.physicsBody = SKPhysicsBody(rectangleOf: alien.size)
        alien.physicsBody?.isDynamic = true
        
        alien.physicsBody?.categoryBitMask = alienCategory
        alien.physicsBody?.contactTestBitMask = photonTorpedoCategory
        alien.physicsBody?.collisionBitMask = 0
        
        alien.xScale = 1.5
        alien.yScale = 1.5
        
        self.addChild(alien)
        
        let animationDuration: TimeInterval = 6
        
        var actionArray = [SKAction]()
        
        actionArray.append(SKAction.move(to: CGPoint(x: position, y: -alien.size.height + self.frame.minY), duration: animationDuration))
        actionArray.append(SKAction.removeFromParent())
        
        alien.run(SKAction.sequence(actionArray))
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            
            let location = touch.location(in: self)
            
            if s.contains(location) {
                
                s.position = location
                
            }
            
        }

    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            
            let location = touch.location(in: self)
            
            if s.contains(location) {
                
                s.position = location
                
            }
            
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        fireTorpedo()
    }
    
    func fireTorpedo() {
        
        self.run(SKAction.playSoundFileNamed("torpedo.mp3", waitForCompletion: false))
        
        let torpedoNode = SKSpriteNode(imageNamed: "torpedo")
        torpedoNode.position = (s?.position)!
        torpedoNode.position.y += 5
        
        torpedoNode.physicsBody = SKPhysicsBody(circleOfRadius: torpedoNode.size.width / 2)
        torpedoNode.physicsBody?.isDynamic = true
        
        torpedoNode.physicsBody?.categoryBitMask = photonTorpedoCategory
        torpedoNode.physicsBody?.contactTestBitMask = alienCategory
        torpedoNode.physicsBody?.collisionBitMask = 0
        torpedoNode.physicsBody?.usesPreciseCollisionDetection = true
        
        self.addChild(torpedoNode)
        
        let animationDuration: TimeInterval = 0.3
        
        var actionArray = [SKAction]()
        
        actionArray.append(SKAction.move(to: CGPoint(x: (s?.position.x)!, y: self.frame.size.height + 10), duration: animationDuration))
        actionArray.append(SKAction.removeFromParent())
        
        torpedoNode.run(SKAction.sequence(actionArray))
        
    }
   
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            
            firstBody = contact.bodyA
            secondBody = contact.bodyB

        } else {
            
            firstBody = contact.bodyB
            secondBody = contact.bodyA
            
        }
        
        if (firstBody.categoryBitMask & photonTorpedoCategory) != 0 && (secondBody.categoryBitMask & alienCategory) != 0 {
            
            torpedoDidCollideWithAlien(torpedoNode: (firstBody.node as? SKSpriteNode)!, alienNode: (secondBody.node as? SKSpriteNode)!)
            
        }
        
        
    }
    
    func torpedoDidCollideWithAlien (torpedoNode: SKSpriteNode, alienNode:SKSpriteNode) {
    
        let explosion =  SKEmitterNode(fileNamed: "Explosion")!
        
        explosion.position = alienNode.position
        
        self.addChild(explosion)
        
        self.run(SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: false))
        
        torpedoNode.removeFromParent()
        alienNode.removeFromParent()
        
        self.run(SKAction.wait(forDuration: 2)) { 
            
            explosion.removeFromParent()
        }
        
        score += 5
    
    }
    
    
}
