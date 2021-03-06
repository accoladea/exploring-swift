//
//  ViewController.swift
//  TicTacToe
//
//  Created by Zhan Dov on 12/26/16.
//  Copyright © 2016 Accolade. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var turnImage: UIImageView!
    
    @IBOutlet weak var turnLabel: UILabel!
    
    @IBAction func newGame(_ sender: AnyObject) {
        activeGame = true
        
        activePlayer = 1
        
        gameState = [0,0,0,0,0,0,0,0,0]
        
        
        for i in 1..<10 {
            
            if let button = view.viewWithTag(i) as? UIButton {
                
                button.setImage(nil, for: [])
            }
            
            winnerLabel.isHidden = true
            playingAgainButton.isHidden = true
            
            winnerLabel.center = CGPoint(x: winnerLabel.center.x - 500, y: winnerLabel.center.y)
            playingAgainButton.center = CGPoint(x: playingAgainButton.center.x - 500, y: playingAgainButton.center.y)
            
        }
        //clearing below section
        turnImage.image = UIImage(named: "nought.png")
        turnLabel.text = " -Turn"
        turnLabel.backgroundColor = UIColor(red: 103/255, green: 206/255, blue: 122/255, alpha: 1)
        turnImage.backgroundColor = UIColor(red: 103/255, green: 206/255, blue: 122/255, alpha: 1)
    }
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var playingAgainButton: UIButton!
    @IBAction func playAgain(_ sender: Any) {
        
        activeGame = true
        
        activePlayer = 1
        
        gameState = [0,0,0,0,0,0,0,0,0]
        
        
        for i in 1..<10 {
           
            if let button = view.viewWithTag(i) as? UIButton {
                
                button.setImage(nil, for: [])
            }
            
            winnerLabel.isHidden = true
            playingAgainButton.isHidden = true
            
            winnerLabel.center = CGPoint(x: winnerLabel.center.x - 500, y: winnerLabel.center.y)
            playingAgainButton.center = CGPoint(x: playingAgainButton.center.x - 500, y: playingAgainButton.center.y)
            
        }
        
        //clearing below section
        turnImage.image = UIImage(named: "nought.png")
        turnLabel.text = " -Turn"
        turnLabel.backgroundColor = UIColor(red: 103/255, green: 206/255, blue: 122/255, alpha: 1)
        turnImage.backgroundColor = UIColor(red: 103/255, green: 206/255, blue: 122/255, alpha: 1)
        
    }
    // 1 is noughts, 2 is crosses
    
    var activeGame = true
    
    var activePlayer = 1
    
    var gameState = [0,0,0,0,0,0,0,0,0] // 0 -empty, 1 - noughts, 2 - crosses
    
    let winningCombinations = [[0,1,2], [3,4,5], [6,7,8], [0,3, 6], [1,4,7], [2,5,8],
                               [0,4,8], [2,4,6]]
 
    @IBOutlet weak var asdfda: UIButton!
    @IBAction func asdfda(_ sender: AnyObject) {
        
        let activePosition = sender.tag - 1
        
        if gameState[activePosition] == 0 && activeGame{
            
            gameState[activePosition] = activePlayer
            
            if activePlayer == 1 {
                
                sender.setImage(UIImage(named: "nought.png"), for: [])
                turnImage.image = UIImage(named: "cross.png")
                
                activePlayer = 2
                
            } else {
                
                sender.setImage(UIImage(named: "cross.png"), for: [])
                turnImage.image = UIImage(named: "nought.png")
                
                activePlayer = 1
            }
            
        }
        
        if gameState.contains(0) == false && activeGame {
            
            winnerLabel.text = "Nobody won"
            playingAgainButton.isHidden = false
            winnerLabel.isHidden = false
            
            UIView.animate(withDuration: 1, animations: {
                
                self.winnerLabel.center = CGPoint(x: self.winnerLabel.center.x + 500, y: self.winnerLabel.center.y)
                self.playingAgainButton.center = CGPoint(x: self.playingAgainButton.center.x + 500, y: self.playingAgainButton.center.y)
                
            })
            
        activeGame = false
            
        }
        for combination in winningCombinations {
            
            if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]]{
                
                // We have a winner!

                activeGame = false
                
                winnerLabel.isHidden = false
                
                playingAgainButton.isHidden = false
                
                if gameState[combination[0]] == 1 {
                    
                    winnerLabel.text = "Noughts have won!"
                    turnImage.image = UIImage(named: "nought.png")
                    turnLabel.text = " is Winner!"
                    turnLabel.adjustsFontSizeToFitWidth = true
                    turnLabel.backgroundColor = UIColor(red: 255/255, green: 83/255, blue: 75/255, alpha: 1)
                    turnImage.backgroundColor = UIColor(red: 255/255, green: 83/255, blue: 75/255, alpha: 1)
    
                } else {
                    winnerLabel.text = "Crosses have won!"
                    turnImage.image = UIImage(named: "cross.png")
                    turnLabel.text = " is Winner!"
                    turnLabel.adjustsFontSizeToFitWidth = true
                    turnLabel.backgroundColor = UIColor(red: 119/255, green: 91/255, blue: 163/255, alpha: 1)
                    turnImage.backgroundColor = UIColor(red: 119/255, green: 91/255, blue: 163/255, alpha: 1)
                }
                
                
                
                UIView.animate(withDuration: 1, animations: {
                    
                    self.winnerLabel.center = CGPoint(x: self.winnerLabel.center.x + 500, y: self.winnerLabel.center.y)
                    self.playingAgainButton.center = CGPoint(x: self.playingAgainButton.center.x + 500, y: self.playingAgainButton.center.y)
                
                })
                
            }
        
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        winnerLabel.isHidden = true
        playingAgainButton.isHidden = true
        
        winnerLabel.center = CGPoint(x: winnerLabel.center.x - 500, y: winnerLabel.center.y)
        playingAgainButton.center = CGPoint(x: playingAgainButton.center.x - 500, y: playingAgainButton.center.y)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

