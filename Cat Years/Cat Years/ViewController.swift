//
//  ViewController.swift
//  Cat Years
//
//  Created by Zhan Dov on 12/20/16.
//  Copyright © 2016 Accolade. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var toBeChangedField: UILabel!
    @IBOutlet weak var getsAge: UITextField!
    @IBAction func submitButton(_ sender: Any) {
        let ageOfCat = Int(getsAge.text!)! * 7
        toBeChangedField.text = String(ageOfCat)
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

