//
//  ViewController.swift
//  Guess Game
//
//  Created by Zhan Dov on 12/22/16.
//  Copyright © 2016 Accolade. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBAction func guessButton(_ sender: Any) {
        let diceRoll = String(arc4random_uniform(6))
        
        if inputTextField.text == diceRoll{
            changeLabel.text = "You are right!"
        } else {
            changeLabel.text = "You are wrong! It was a \(diceRoll)"
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

