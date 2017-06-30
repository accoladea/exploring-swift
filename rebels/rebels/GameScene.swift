//
//  GameScene.swift
//  rebels
//
//  Created by Zhan Dov on 6/21/17.
//  Copyright © 2017 accolade. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var starfield: SKEmitterNode!;
    var player: SKSpriteNode!;
    
    var scoreLabel: SKLabelNode!;
    var score: Int = 0{
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var highestScore = 0
    
    var gameTimer: Timer!;
    var possibleComets = ["alien","alien3"];
    
    var cometCategory: UInt32 = 0x1 << 1;
    var photonTorpedoCategory: UInt32 = 0x1 << 0;
        
    var livesArray: [SKSpriteNode]!
    
    override func didMove(to view: SKView) {
        
        addLives()
        
        starfield = SKEmitterNode(fileNamed: "Starfield")
        starfield.position = CGPoint(x:0, y: frame.height)
        starfield.advanceSimulationTime(15)
        self.addChild(starfield)
        starfield.zPosition = -1
        
        
        player = SKSpriteNode(imageNamed: "shuttle")
        player.position = CGPoint(x: frame.midX, y: frame.minY + 200)
        player.xScale = 1.5
        player.yScale = 1.5
        
        self.addChild(player)
        
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        
        
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.position = CGPoint(x: self.frame.size.width - 100, y: self.frame.size.height - 70)
        
        scoreLabel.fontName = "AmericanTypewriter-Bold"
        scoreLabel.fontSize = 35
        scoreLabel.fontColor = UIColor.white
        scoreLabel.zPosition = 5
        score = 0
        self.addChild(scoreLabel)
        
        var timeInterval = 0.75;
        
        if UserDefaults.standard.bool(forKey: "medium"){
            
            timeInterval = 0.5
        } else if UserDefaults.standard.bool(forKey: "hard"){
            
            timeInterval = 0.35
        }
        
        gameTimer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(addComets), userInfo: nil, repeats: true)
        
    }
    
    func addLives(){
        
        livesArray = [SKSpriteNode]()
        
        for live in 1 ... 3 {
            
            let liveNode = SKSpriteNode(imageNamed: "life-img")
            liveNode.xScale = 0.45
            liveNode.yScale = 0.45
            liveNode.zPosition = 5
            liveNode.zRotation = 0.5
            liveNode.position = CGPoint(x: self.frame.minX + CGFloat(4-live) * liveNode.size.width, y: self.frame.size.height - 73 + liveNode.size.height / 2)
            
            self.addChild(liveNode)
            livesArray.append(liveNode)
        }
        
    }
    
    func addComets() {
        
        possibleComets = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: possibleComets) as! [String]
        
        let comet = SKSpriteNode(imageNamed: possibleComets[0])
        
        let randomCometPosition = GKRandomDistribution(lowestValue: Int(self.frame.minX + comet.size.width), highestValue: Int(self.frame.size.width - comet.size.width))
        let cometPosition = CGFloat(randomCometPosition.nextInt())
        
        comet.position = CGPoint(x: cometPosition, y: self.frame.size.height + comet.size.height)
        
        comet.physicsBody = SKPhysicsBody(rectangleOf: comet.size)
        comet.physicsBody?.isDynamic = true
        
        comet.physicsBody?.categoryBitMask = cometCategory
        comet.physicsBody?.contactTestBitMask = photonTorpedoCategory
        comet.physicsBody?.collisionBitMask = 0
        self.addChild(comet)
        
        let animationDuration: TimeInterval = 6
        
        var actionArray = [SKAction]()
        
        actionArray.append(SKAction.move(to: CGPoint(x: cometPosition, y: -comet.size.height + self.frame.minY), duration: animationDuration))
        
        actionArray.append(SKAction.run {
            
            self.run(SKAction.playSoundFileNamed("loose.mp3", waitForCompletion: false))
            
            if self.livesArray.count > 0 {
                
                let liveNode = self.livesArray.first
                liveNode!.removeFromParent()
                self.livesArray.removeFirst()
                
                if self.livesArray.count == 0 {
                    
                    let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                    let gameOver = SKScene(fileNamed: "GameOverScene") as! GameOverScene
                    
                    gameOver.highestScore = self.highestScore
                    gameOver.score = self.score
                    
                    let maxscoreDefault = UserDefaults.standard
                    
                    if (maxscoreDefault.value(forKey: "Highscore") != nil){
                        
                        self.highestScore = maxscoreDefault.value(forKey: "Highscore") as! Int
                        gameOver.highestScore = self.highestScore
                        
                    }
                    
                    if self.score > self.highestScore {
                        self.highestScore = self.score
                        gameOver.highestScore = self.highestScore
                        
                        let userDefaultsScore = UserDefaults.standard
                        userDefaultsScore.set(self.highestScore, forKey: "Highscore")
                        userDefaultsScore.synchronize()
                        
                    }

                    self.view?.presentScene(gameOver, transition: transition) 
                }
            }
            
        })
        
        actionArray.append(SKAction.removeFromParent())
        comet.run(SKAction.sequence(actionArray))
        
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            
            let location = touch.location(in: self)
            
            if player.contains(location) {
                
                player.position = CGPoint(x: location.x, y: location.y + 15)
                
            }
            
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            
            let location = touch.location(in: self)
            
            if player.contains(location) {
                
                player.position = CGPoint(x: location.x, y: location.y + 15)
                
            }
            
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            
            let location = touch.location(in: self)
            
            if player.contains(location) {
                    fireTorpedo()
            }
            
        }
        
        
    }
    
    func fireTorpedo() {
        
        self.run(SKAction.playSoundFileNamed("torpedo.mp3", waitForCompletion: false))
        
        let torpedoNode = SKSpriteNode(imageNamed: "torpedo")
        torpedoNode.position = (player?.position)!
        torpedoNode.position.y += 10
        
        torpedoNode.physicsBody = SKPhysicsBody(circleOfRadius: torpedoNode.size.width / 2)
        torpedoNode.physicsBody?.isDynamic = true
        
        torpedoNode.physicsBody?.categoryBitMask = photonTorpedoCategory
        torpedoNode.physicsBody?.contactTestBitMask = cometCategory
        torpedoNode.physicsBody?.collisionBitMask = 0
        torpedoNode.physicsBody?.usesPreciseCollisionDetection = true
        
        self.addChild(torpedoNode)
        
        let animationDuration: TimeInterval = 0.3
        
        var actionArray = [SKAction]()
        
        actionArray.append(SKAction.move(to: CGPoint(x: (player?.position.x)!, y: self.frame.size.height + 10), duration: animationDuration))
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
        
        if (firstBody.categoryBitMask & photonTorpedoCategory) != 0 && (secondBody.categoryBitMask & cometCategory) != 0 {
            
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
        
        self.run(SKAction.wait(forDuration: 0.5)) {
            
            explosion.removeFromParent()
        }
        
        score += 5
        
    }
    
    
}
