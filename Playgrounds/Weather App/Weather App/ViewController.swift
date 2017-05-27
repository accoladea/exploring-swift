//
//  ViewController.swift
//  Weather App
//
//  Created by Zhan Dov on 12/25/16.
//  Copyright © 2016 Accolade. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var textField: UITextField!
    @IBAction func submit(_ sender: Any) {
        if let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=" + textField.text!.replacingOccurrences(of: " ",with: "%20") +  ",uk&appid=039779dfcd4c22fae7b7a59e9acf3f95"){
        
        let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
            
            if error != nil {
                print(error);
            } else {
                
                if let urlContent = data {
                    do{
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        print(jsonResult);
                        
                        if let description = ((jsonResult["weather"] as? NSArray)?[0] as? NSDictionary)?["description"] as? String {
                            
                            DispatchQueue.main.sync(execute: {
                                self.resultLabel.text = description
                            })
                        }
                        
                    } catch {
                        print("JSON Processing Failed")
                    }
                }
            }
            
            
        }
        task.resume();
        } else {
            resultLabel.text = "Couldn't find weather for that city"
        }

    }
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

