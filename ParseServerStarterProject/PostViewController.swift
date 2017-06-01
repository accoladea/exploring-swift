//
//  PostViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Zhan Dov on 5/31/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse

class PostViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet weak var imageToPost: UIImageView!
    @IBAction func chooseAnImage(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = false
        
        self.present(imagePicker, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            imageToPost.image = image
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var messageTextField: UITextField!
    
    func createAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
        
    }

    
    @IBAction func postImage(_ sender: Any) {
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        let post = PFObject(className: "Posts")
        
        post["message"] = messageTextField.text
        
        post["userid"] = PFUser.current()?.objectId!
        
        let imageData = UIImageJPEGRepresentation((imageToPost?.image!)!, 1.0)
        
        let imageFile = PFFile(name: "image.png", data: imageData!)
        
        post["imageFile"] = imageFile
        
        post.saveInBackground { (success, error) in
            
            self.activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if error != nil {
                self.createAlert(title: "Could not post image", message: "Please try again later")
                UIApplication.shared.endIgnoringInteractionEvents()

            } else {
                self.createAlert(title: "Image Posted!", message: "Your image has been posted successfully")
                
                self.messageTextField.text = ""
                
                self.imageToPost.image = UIImage(named: "four.png")
                UIApplication.shared.endIgnoringInteractionEvents()

                
            }
            
        
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
