//
//  MenuScene.swift
//  universe
//
//  Created by Zhan Dov on 6/20/17.
//  Copyright © 2017 accolade. All rights reserved.
//

import SpriteKit


class MenuScene: SKScene {
    
    var starfield:SKEmitterNode?
    var newGameButtonNode:SKSpriteNode?
    var difficultyButtonNode:SKSpriteNode?
    var difficultyLabel: SKLabelNode?
    
    override func didMove(to view: SKView) {
        starfield = self.childNode(withName: "starfield") as? SKEmitterNode
        starfield?.advanceSimulationTime(10)
        
        newGameButtonNode = self.childNode(withName: "newGameButton") as? SKSpriteNode
        difficultyButtonNode = self.childNode(withName: "difficultyButton") as? SKSpriteNode
        
        difficultyLabel = self.childNode(withName: "difficultyLabel") as? SKLabelNode
        
        let userDefaults = UserDefaults.standard
        
        if userDefaults.bool(forKey: "hard") {
            difficultyLabel?.text = "Hard"
        } else {
            difficultyLabel?.text = "Easy"
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
        
            let node = self.nodes(at: location)
            
            if node[0].name == "newGameButton" {
                let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                let gameScene = GameScene(size: self.size)
                
                self.view!.presentScene(gameScene, transition: transition)
                
            } else if node[0].name == "difficultyButton" {
                
                changeDifficulty()
                
            }
        }
        
        
        
    }
    
    func changeDifficulty() {
        
        let userDefaults = UserDefaults.standard
        
        if difficultyLabel?.text == "Easy" {
           
            difficultyLabel?.text = "Hard"
            userDefaults.set(true, forKey: "hard")
        } else {
            
            difficultyLabel?.text = "Easy"
            userDefaults.set(false, forKey: "hard")
        }
        
        userDefaults.synchronize()
        
    }
}
