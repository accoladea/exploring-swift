//
//  GameScene.swift
//  Flappy Bird
//
//  Created by Zhan Dov on 2/11/17.
//  Copyright © 2017 accolade. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
   
    var bird = SKSpriteNode()
    
    var bg = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        
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
        
        self.addChild(bird)
        
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let birdTexture = SKTexture(imageNamed: "flappy1.png")
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height / 2)

        
        bird.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
        
        bird.physicsBody!.applyImpulse(CGVector(dx: 0, dy: 70))
       
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
    }}
