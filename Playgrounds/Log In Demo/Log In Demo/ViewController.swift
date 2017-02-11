//
//  ViewController.swift
//  Log In Demo
//
//  Created by Zhan Dov on 1/12/17.
//  Copyright © 2017 Accolade. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBAction func logOut(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
    
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        do {
            let results = try context.fetch(request)
            
            if results.count > 0 {
                
                for result in results {
                    
                    context.delete(result as! NSManagedObject)
                    do {
                        try context.save()
                    }
                    catch{
                        print("Individual Delete failed")
                    }
                }
                
                label.alpha = 0
                logOutSender.alpha = 0
                logInButton.alpha = 1
                
                isLoggedIn = false
            }
        }
        catch{
            print("Delete failed")
        }
    }
    @IBOutlet weak var logOutSender: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var label: UILabel!
    var isLoggedIn = false
    @IBAction func logIn(_ sender: AnyObject) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        if isLoggedIn {
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
            
            
            
            do {
               let results = try context.fetch(request)
                
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        
                        result.setValue(textField.text, forKey:"name")
                        
                        do {
                            
                            try context.save()
                        
                        } catch {
                            
                            print("Update username save failed")
                            
                        }
                    }
                    
                    label.text = "Hi there " + textField.text! + "!"
                }
                
            } catch {
                print("Update username failed")
            }
            
        } else {
            
            let newValue = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        
            newValue.setValue(textField.text, forKey: "name")
            
            do {
                try context.save()

                logInButton.setTitle("Login", for: [])

                label.alpha = 1
                
                label.text = "Hi there " + textField.text! + "!"
                
                logOutSender.alpha = 1
                
                isLoggedIn = true
            
        } catch {
            print("Failed to save")
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
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            for result in results as! [NSManagedObject] {
                
                if let username = result.value(forKey: "name") as? String {
                    
                    textField.alpha = 0
                    
                    logInButton.setTitle("Update username", for: [])
                    
                    label.alpha = 1
                    
                    label.text = "Hi there " + username + "!"
                }
            }
        } catch {
            print("Request failed")
        }
    }


}

