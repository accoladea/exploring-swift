//
//  SecondViewController.swift
//  To Do List App
//
//  Created by Zhan Dov on 12/24/16.
//  Copyright © 2016 Accolade. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var itemTextField: UITextField!
    
    @IBAction func add(_ sender: Any) {
        
        var items: [String]
        let itemsObject = UserDefaults.standard.object(forKey: "items")
        if let tempItems = itemsObject as? [String]{
            items = tempItems
            items.append(itemTextField.text!)
        } else {
             items = [itemTextField.text!]
        }
        
        UserDefaults.standard.set(items, forKey: "items")
        
        itemTextField.text = ""
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

