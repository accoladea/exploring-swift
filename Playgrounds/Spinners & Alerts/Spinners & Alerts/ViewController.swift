//
//  ViewController.swift
//  Spinners & Alerts
//
//  Created by Zhan Dov on 5/29/17.
//  Copyright © 2017 accolade. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var activityIndicator = UIActivityIndicatorView()
    
    
    
    
    @IBAction func createAlert(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Hey There!", message: "Are you sure?", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            
            print("OK button pressed")
            
            self.dismiss(animated: true, completion: nil)
        }))
        
        alertController.addAction(UIAlertAction(title: "No", style: .default, handler: { (UIAlertAction) in
            
            print("No button pressed")
            
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func pauseApp(_ sender: Any) {
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        activityIndicator.center = self.view.center
        
        activityIndicator.hidesWhenStopped = true
        
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        
        //UIApplication.shared.beginIgnoringInteractionEvents()
        
        
    }
    
    @IBAction func restoreApp(_ sender: Any) {
        
        activityIndicator.stopAnimating()
        
        //UIApplication.shared.endIgnoringInteractionEvents()
        
        
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

