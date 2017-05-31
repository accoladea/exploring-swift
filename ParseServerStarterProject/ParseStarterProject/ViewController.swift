/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/
/*
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
 
 */

import UIKit
import Parse

class ViewController: UIViewController {
    
    var signupMode = true
    
    var activityIndicator = UIActivityIndicatorView()
    
    func createAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupOrLogin: UIButton!
    @IBAction func signupOrLogin(_ sender: Any) {
        
        if emailTextField.text! == "" || passwordTextField.text == "" {
            
            createAlert(title: "Error in form", message: "Please enter an email and passord")
            
        } else {
            
            activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
                activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
                view.addSubview(activityIndicator)
                UIApplication.shared.beginIgnoringInteractionEvents()
            
            
            
            if signupMode {
                // Sign Up
                
                let user = PFUser()
                
                user.username = emailTextField.text
                user.email = emailTextField.text
                user.password = passwordTextField.text
                
                user.signUpInBackground(block: { (success, error) in
                
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    if error != nil {
                        
                        let nsError = error! as NSError
                        
                        let alertError = nsError.userInfo["error"]!
                        
                        self.createAlert(title: "Signup Error", message: alertError as! String)
                        
                    } else {
                        print("user signed up")
                        
                        self.performSegue(withIdentifier: "showUserTable", sender: self)
    
                    }
                })
            } else {
                // Login mode
                PFUser.logInWithUsername(inBackground: emailTextField.text!, password: passwordTextField.text!, block: { (user, error) in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    if error != nil {
                        
                        
                        let nsError = error! as NSError
                        
                        let alertError = nsError.userInfo["error"]!
                        
                        self.createAlert(title: "Login Error", message: alertError as! String)
                        
                    } else {
                        print("Logged in")
                        
                        self.performSegue(withIdentifier: "showUserTable", sender: self)
                        
                    }
                })
                
            }
            
            
            
            
            
        }
        
        
    }
    @IBAction func changeSignupMode(_ sender: Any) {
        
        if signupMode {
            
            // Change to login mode
            
            signupOrLogin.setTitle("Log In", for: [])
            
            changeSignupModeButton.setTitle("Sign Up", for: [])
            
            messageLabel.text = "Don't have an account?"
            
            signupMode = false
            
        } else {
            
            // Change to signup mode
            
            signupOrLogin.setTitle("Sign Up", for: [])
            
            changeSignupModeButton.setTitle("Log In", for: [])
            
            messageLabel.text = "Already have an account?"
            
            signupMode = true
            
        }
    }
    @IBOutlet weak var changeSignupModeButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        
        if PFUser.current() != nil {
            
            performSegue(withIdentifier: "showUserTable", sender: self)
            
        }
        
        self.navigationController?.navigationBar.isHidden = false
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()


        
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
