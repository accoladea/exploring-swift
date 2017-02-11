//
//  ViewController.swift
//  Core Data Demo
//
//  Created by Zhan Dov on 1/2/17.
//  Copyright © 2017 Accolade. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        
        /*//adds new user
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        
        newUser.setValue("mike", forKey: "username")
        newUser.setValue("myPass", forKey: "password")
        newUser.setValue(5, forKey: "age")
 
        do {
            try context.save()
            print("Saved")
        }
        catch {
            print("There was an error")
        }
        */
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        request.predicate = NSPredicate(format: "username = %@", "islomzhan")

        request.returnsObjectsAsFaults = false
    
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject]{
                    
                    if let username = result.value(forKey: "username") as? String {
                        //result.setValue("Dooley", forKey: "username")
                        context.delete(result)
                        do {
                            try context.save()
                        }
                        catch{
                            print("Delete failed")
                        }
                        /*do {
                            try context.save()
                        }
                        catch{
                            print("Rename failed")
                        }*/
                        print(username)
                    }
                }
            } else {
                print("No result")
            }
            
        } catch {
            
            print("Couldn't fetch results")
        }
        
        
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

