//
//  ViewController.swift
//  Permanent Data Storage
//
//  Created by Zhan Dov on 12/23/16.
//  Copyright © 2016 Accolade. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    var arr: Array = ["--See Here The List--"];
    var ccc:Decimal = 0;
    @IBOutlet weak var firstname: UITextField!
    
    @IBOutlet weak var lastname: UITextField!
    
    @IBOutlet weak var telephone: UITextField!
    
    @IBOutlet weak var outputLabel: UILabel!
    
    @IBAction func addsContactButton(_ sender: Any) {
        
        
        ccc = ccc + 1
        
        let combinerStrings = "\(ccc)) \(firstname.text!)  \(lastname.text!)  \(telephone.text!)"
        arr.append(combinerStrings)
        
/////////////////////////////////////////////////
        UserDefaults.standard.set(arr, forKey: "contact_list")
        
        let contact_listObject = UserDefaults.standard.object(forKey: "contact_list")
        
        if let contact_list = contact_listObject as? NSArray{
            //print(contact_list)
            var i = 0;
            while i < contact_list.count {
                
                outputLabel.text = String(describing: contact_list)
                i=i+1
            }
        }

        //print(arr.count)
        
}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

