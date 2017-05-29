/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
//// Adds a class :`)
//        let users = PFObject(className: "Users")
//        
//        users["Name"] = "Islomzhan"
//        
//        users.saveInBackground { (success, error) -> Void in
//            
//            
//            if success {
//                
//                print("Object has been saved.")
//                
//            } else {
//                
//                if error != nil {
//                    
//                    print (error)
//                    
//                } else {
//                    
//                    print ("Error")
//                }
//                
//            }
//            
//        }
//
//        
//// Retrieves data
//        let query = PFQuery(className: "Users")
//
//        query.getObjectInBackground(withId: "X5SgajduXU") { (object, error) in
//            
//            if error != nil {
//                
//                print(error)
//            
//            } else {
//                
//                if let user = object {
//
//                    print(user)
//                    print(user["Name"])
//                }
//            }
//            
//        }
//        
        
//// Changes the data
        let query = PFQuery(className: "Users")
        
        query.getObjectInBackground(withId: "X5SgajduXU") { (object, error) in
            
            if error != nil {
                
                print(error)
                
            } else {
                
                if let user = object {

        
                    user["Name"] = "Akhmedov"
        
                    user.saveInBackground  { (success, error) -> Void in
            
            
                        if success {
                
                            print("Saved.")
                
                        } else {
                    
                            print ("Error")
                        }
                
                    }
                    
                }
        }
    }
        
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
