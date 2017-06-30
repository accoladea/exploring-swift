//
//  MenuScene.swift
//  rebels
//
//  Created by Zhan Dov on 6/23/17.
//  Copyright © 2017 accolade. All rights reserved.
//

import SpriteKit
import UIKit

class MenuScene: SKScene {
    
   var starfield:SKEmitterNode!;

    var newGameButtonNode:SKSpriteNode!;
    var difficultyButtonNode:SKSpriteNode!;
    var difficultyLabelNode:SKLabelNode!

    
  override func didMove(to view: SKView) {

       starfield = self.childNode(withName: "starfield") as! SKEmitterNode;
       starfield.advanceSimulationTime(10)

        newGameButtonNode = self.childNode(withName: "newGameButton") as! SKSpriteNode
        difficultyButtonNode = self.childNode(withName: "difficultyButton") as! SKSpriteNode
        difficultyLabelNode = self.childNode(withName: "difficultyLabel") as! SKLabelNode
    
    let userDefaults = UserDefaults.standard
    
    if userDefaults.bool(forKey: "medium"){
        
        difficultyLabelNode.text = "Medium"
        
    } else if userDefaults.bool(forKey: "hard"){
        
        difficultyLabelNode.text = "Hard"
        
    } else {
        
        difficultyLabelNode.text = "Easy"
    }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "newGameButton" {
                
                let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                
                let gameScene = GameScene(size: self.size)
                
                self.view?.presentScene(gameScene, transition: transition)
                
            } else if nodesArray.first?.name == "difficultyButton" {
                
                changeDifficulty()
                
            }
        }
    }
    
    func changeDifficulty () {
    
        let userDefaults = UserDefaults.standard
        
        if difficultyLabelNode.text == "Easy" {
            
            difficultyLabelNode.text = "Medium"
            
            userDefaults.set(true, forKey: "medium")
            
        } else if difficultyLabelNode.text == "Medium" {
            
            difficultyLabelNode.text = "Hard"
            
            userDefaults.set(true, forKey: "hard")
            
        } else {
            
            difficultyLabelNode.text = "Easy"
            userDefaults.set(false, forKey: "medium")
            userDefaults.set(false, forKey: "hard")
        }
        
        userDefaults.synchronize()
        
    }
    
}
