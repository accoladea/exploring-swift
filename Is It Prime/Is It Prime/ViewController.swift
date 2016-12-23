//
//  ViewController.swift
//  Is It Prime
//
//  Created by Zhan Dov on 12/22/16.
//  Copyright © 2016 Accolade. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var inputGetTextField: UITextField!
    @IBOutlet weak var outputChangeLabel: UILabel!
    @IBAction func checkButton(_ sender: Any) {
        if let userEnteredString = inputGetTextField.text{
            
            let userEnteredInteger = Int(userEnteredString)
            
            if let number = userEnteredInteger {
                
                var isPrime = true
                
                if number == 1 {
                
                    isPrime = false
                
                }
                
                var i = 2
                
                while i < number{
                
                    if number % i == 0{
                    
                        isPrime = false
                    
                    }
                    
                    i += 1
                
                }
                
                if isPrime{
                    outputChangeLabel.text = "\(number) is prime!"
                } else {
                    outputChangeLabel.text = "\(number) is not prime"
                }
                
            }
            
                
            else {
                
                outputChangeLabel.text = "Please enter a positive whole number"
                
            }
            
        
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

