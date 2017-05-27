//
//  ViewController.swift
//  API Demo
//
//  Created by Zhan Dov on 5/27/17.
//  Copyright © 2017 accolade. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = URL(string: "http://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=039779dfcd4c22fae7b7a59e9acf3f95")!;
        
        let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
            
            if error != nil {
                print(error as Any);
            } else {
                
                if let urlContent = data {
                    do{
                    let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                    
                        print(jsonResult);
                        
                        if let description = ((jsonResult["weather"] as? NSArray)?[0] as? NSDictionary)?["description"] as? String {
                            print(description)
                        }
                        
                    } catch {
                        print("JSON Processing Failed")
                    }
                }
            }
            
            
        }
        task.resume();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

