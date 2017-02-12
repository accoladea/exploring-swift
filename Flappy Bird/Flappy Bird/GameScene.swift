//
//  GameScene.swift
//  Flappy Bird
//
//  Created by Zhan Dov on 2/11/17.
//  Copyright © 2017 accolade. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
   
    var bird = SKSpriteNode()
    
    var bg = SKSpriteNode()
    
    var scoreLabel = SKLabelNode()
    
    var score = 0

    var gameOverLabel = SKLabelNode()
    
    var timer = Timer()
    
    enum ColliderType: UInt32{
        
        case Bird = 1
        case Object = 2
        case Gap = 4
    }
    
    var gameOver = false
    
    func makePipes() {
        
//Pipes
        let movePipes = SKAction.move(by: CGVector(dx: -2 * self.frame.width,dy: 0), duration: TimeInterval(self.frame.width / 100))
        
        // Gap Height
        
        let gapHeight = bird.size.height * 4
        
        let movementAmount = arc4random() % UInt32(self.frame.height / 2)
        
        let pipeOffset = CGFloat(movementAmount) - self.frame.height / 4
        // Pipe 1
        let pipeTexture = SKTexture(imageNamed: "pipe1.png")
        
        let pipe1 = SKSpriteNode(texture: pipeTexture)
        
        pipe1.position = CGPoint(x: self.frame.midX + self.frame.width, y: self.frame.midY + pipeTexture.size().height / 2 + gapHeight / 2 + pipeOffset)
        
        pipe1.run(movePipes)
        
        pipe1.physicsBody = SKPhysicsBody(rectangleOf: pipeTexture.size())
        pipe1.physicsBody!.isDynamic = false
        
        //Bird and objects start to contact -> Pipe 1
        pipe1.physicsBody!.contactTestBitMask = ColliderType.Object.rawValue
        pipe1.physicsBody!.categoryBitMask  = ColliderType.Object.rawValue
        pipe1.physicsBody!.collisionBitMask = ColliderType.Object.rawValue

        
        self.addChild(pipe1)
        
        // Pipe 2
        let pipeTexture2 = SKTexture(imageNamed: "pipe2.png")
        
        let pipe2 = SKSpriteNode(texture: pipeTexture2)
        
        pipe2.position = CGPoint(x: self.frame.midX + self.frame.width, y: self.frame.midY - pipeTexture2.size().height / 2 - gapHeight / 2 + pipeOffset)
        
        pipe2.run(movePipes)
        
        pipe2.physicsBody = SKPhysicsBody(rectangleOf: pipeTexture2.size())
        pipe2.physicsBody!.isDynamic = false
        
        //Bird and objects start to contact -> Pipe 2
        pipe2.physicsBody!.contactTestBitMask = ColliderType.Object.rawValue
        pipe2.physicsBody!.categoryBitMask  = ColliderType.Object.rawValue
        pipe2.physicsBody!.collisionBitMask = ColliderType.Object.rawValue
        
        self.addChild(pipe2)
        
        pipe1.zPosition = -1
        pipe2.zPosition = -1
        
        // Creating a gap node to track scores when bird passes the pipes
        
        let gap = SKNode()
        
        gap.position = CGPoint(x: self.frame.midX + self.frame.width,y:self.frame.midY + pipeOffset)
        
        gap.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: pipeTexture.size().width, height: gapHeight))
        
        gap.physicsBody!.isDynamic = false
        
        gap.run(movePipes)
        
        gap.physicsBody!.contactTestBitMask = ColliderType.Bird.rawValue
        gap.physicsBody!.categoryBitMask  = ColliderType.Gap.rawValue
        gap.physicsBody!.collisionBitMask = ColliderType.Gap.rawValue

        self.addChild(gap)
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if gameOver == false {
            
            if contact.bodyA.categoryBitMask == ColliderType.Gap.rawValue || contact.bodyB.categoryBitMask == ColliderType.Gap.rawValue{
            
                score += 1
            
                scoreLabel.text = String(score)
            
            } else {
            
                self.speed = 0
            
                gameOver = true
                
                timer.invalidate()

            
                gameOverLabel.fontName = "Helvetica"
            
                gameOverLabel.fontSize = 30
            
                gameOverLabel.text = "Game Over! Tap to play again"
            
                gameOverLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
            
            self.addChild(gameOverLabel)
        }
            
        }

        
    }
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        setupGame()
        
    }
    
    func setupGame() {
        
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.makePipes), userInfo: nil, repeats: true)
        
        // Background
        let bgTexture = SKTexture(imageNamed: "bg.png")
        
        let moveBGAnimation = SKAction.move(by: CGVector(dx: -bgTexture.size().width, dy: 0), duration: 7)
        let shiftBGAnimation = SKAction.move(by: CGVector(dx: bgTexture.size().width, dy: 0), duration: 0)
        let moveBGForever = SKAction.repeatForever(SKAction.sequence([moveBGAnimation, shiftBGAnimation]))
        
        var i: CGFloat = 0
        
        while i < 3 {
            
            bg = SKSpriteNode(texture: bgTexture)
            
            bg.position = CGPoint(x: bgTexture.size().width * i, y: self.frame.midY)
            
            bg.size.height = self.frame.height
            
            bg.run(moveBGForever)
            
            bg.zPosition = -2
            
            self.addChild(bg)
            
            i += 1
        }
        
        
        // Animation of the bird
        
        let birdTexture = SKTexture(imageNamed: "flappy1.png")
        let birdTexture2 = SKTexture(imageNamed: "flappy2.png")
        
        let animation = SKAction.animate(with: [birdTexture, birdTexture2], timePerFrame: 0.1)
        
        let makeBirdFlap = SKAction.repeatForever(animation)
        
        bird = SKSpriteNode(texture: birdTexture)
        
        bird.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        bird.run(makeBirdFlap)
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height / 2)
        
        bird.physicsBody!.isDynamic = false
        
        //Bird and objects start to contact -> Bird
        bird.physicsBody!.contactTestBitMask = ColliderType.Object.rawValue
        bird.physicsBody!.categoryBitMask  = ColliderType.Bird.rawValue
        bird.physicsBody!.collisionBitMask = ColliderType.Bird.rawValue
        
        self.addChild(bird)
        
        //Another node -> Ground (invisible object)
        
        let ground = SKNode()
        
        ground.position = CGPoint(x: self.frame.midX, y: -self.frame.height / 2)
        
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: 1))
        
        ground.physicsBody!.isDynamic = false
        
        //Bird and objects start to contact -> Ground
        ground.physicsBody!.contactTestBitMask = ColliderType.Object.rawValue
        ground.physicsBody!.categoryBitMask  = ColliderType.Object.rawValue
        ground.physicsBody!.collisionBitMask = ColliderType.Object.rawValue
        
        
        self.addChild(ground)
        
        scoreLabel.fontName = "Helvetica"
        
        scoreLabel.fontSize = 60
        
        scoreLabel.text = "0"
        
        scoreLabel.position = CGPoint(x: self.frame.midX,y: self.frame.height / 2 - 70)
        
        self.addChild(scoreLabel)

    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameOver == false {
            
            bird.physicsBody!.isDynamic = true
            
            bird.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
            
            bird.physicsBody!.applyImpulse(CGVector(dx: 0, dy: 70))
            
        } else {
            
            gameOver = false
            
            score = 0
            
            self.speed = 1
            
            self.removeAllChildren()
            
            setupGame()
            
            
        }
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
