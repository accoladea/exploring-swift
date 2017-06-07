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

    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var errorShow: UILabel!
    
    @IBAction func loginButton(_ sender: Any) {
        
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (user, error) in
            
            if error != nil {
                
                var errorMessage = "Login failed - please try again"
                
                let error = error as NSError?
                
                if let parseError = error?.userInfo["error"] as? String {
                    
                    errorMessage = parseError
                    
                }
                
                self.errorShow.text = "Error: "+errorMessage
                
            } else {
            
                print("Logged in")
                
            }
            
        }
        
    }
    @IBAction func signupButton(_ sender: Any) {
        
        let user = PFUser()
        
        user.username = usernameField.text
        user.password = passwordField.text
        
        user.signUpInBackground() {
            (success, error) in
            
            if error != nil {
                
                var errorMessage = "Signup failed - please try again"
                
                let error = error as NSError?
                
                if let parseError = error?.userInfo["error"] as? String {
                    errorMessage = parseError
                }
                
                self.errorShow.text = "Error: "+errorMessage
                
            } else {
                
                print("Signed up")
                
            }
            
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if PFUser.current() != nil {
            
            self.performSegue(withIdentifier: "goToUserInfo", sender: self)
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
