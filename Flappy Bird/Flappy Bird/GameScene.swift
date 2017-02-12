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
    
    enum ColliderType: UInt32{
        
        case Bird = 1
        case Object = 2
    }
    
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
        
        self.addChild(pipe1)
        
        // Pipe 2
        let pipeTexture2 = SKTexture(imageNamed: "pipe2.png")
        
        let pipe2 = SKSpriteNode(texture: pipeTexture2)
        
        pipe2.position = CGPoint(x: self.frame.midX + self.frame.width, y: self.frame.midY - pipeTexture2.size().height / 2 - gapHeight / 2 + pipeOffset)
        
        pipe2.run(movePipes)
        
        self.addChild(pipe2)
        
    }
    
    override func didMove(to view: SKView) {
        
        _ = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.makePipes), userInfo: nil, repeats: true)
        
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
        
            bg.zPosition = -1
            
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
        
        //Bird and objects start to contact
                
        
        self.addChild(bird)
        
//Another node -> Ground (invisible object)
        
        let ground = SKNode()
        
        ground.position = CGPoint(x: self.frame.midX, y: -self.frame.height / 2)
        
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: 1))
        
        ground.physicsBody!.isDynamic = false
        
        self.addChild(ground)
        
        

    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let birdTexture = SKTexture(imageNamed: "flappy1.png")
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height / 2)

        
        bird.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
        
        bird.physicsBody!.applyImpulse(CGVector(dx: 0, dy: 70))
       
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
    }}
