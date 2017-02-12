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
        
        let moveBGAnimation = SKAction.move(by: CGVector(dx: -1), duration: )
        
        bg = SKSpriteNode(texture: bgTexture)
        
        bg.position = CGPoint(x: self.frame.midX,y: self.frame.midY)
        
        bg.size.height = self.frame.height
        
        self.addChild(bg)
        
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
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
    }}
