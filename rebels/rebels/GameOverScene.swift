//
//  GameScene.swift
//  rebels
//
//  Created by Zhan Dov on 6/21/17.
//  Copyright © 2017 accolade. All rights reserved.
//

import UIKit
import SpriteKit


class GameOverScene: SKScene {

    var score = 0
    var highestScore = 0
    
    var starfield:SKEmitterNode!;
    
    var scoreLabel:SKLabelNode!
    var highestScoreLabel:SKLabelNode!
    
    var newGameButtonNode:SKSpriteNode!
 
    override func didMove(to view: SKView) {

        starfield = self.childNode(withName: "starfield") as! SKEmitterNode;
        starfield.advanceSimulationTime(10)
        
        scoreLabel = self.childNode(withName: "scoreLabel") as! SKLabelNode
        scoreLabel.text = "\(score)"
        
        highestScoreLabel = self.childNode(withName: "highestScoreLabel") as! SKLabelNode
        highestScoreLabel.text = "\(highestScore)"
        
        newGameButtonNode = self.childNode(withName: "newGameButton") as! SKSpriteNode
        

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let location = touch?.location(in: self) {
            let node = self.nodes(at: location)
            
            if node[0].name == "newGameButton" {
                let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                let gameScene = GameScene(size: self.size)
                self.view!.presentScene(gameScene, transition: transition)
            }
        }

    }
    
}
