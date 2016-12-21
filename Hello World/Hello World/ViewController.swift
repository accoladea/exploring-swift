//
//  ViewController.swift
//  Hello World
//
//  Created by Zhan Dov on 12/20/16.
//  Copyright © 2016 Accolade. All rights reserved.
//
// One Day I Will Become the Best Programmer, If God Wills

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textFieldQuestion: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var labelQuestionCopy: UILabel!
    @IBAction func buttonTapped(_ sender: Any) {
        
        label.text = "Thanks, Your Question is Submitted!"
        labelQuestionCopy.text = textFieldQuestion.text
        
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

