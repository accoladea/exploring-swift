//
//  InfoViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Zhan Dov on 6/4/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse

class InfoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
    @IBOutlet var userImage: UIImageView!
    @IBAction func addProfileImage(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        
        //imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            userImage.image = image
            
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    var gender: Bool = false
    var country: String = ""
    var status: Int = 0
    
    @IBOutlet var errorMessage: UILabel!
    
    @IBOutlet var statusSControl: UISegmentedControl!
    @IBOutlet var genderSControl: UISegmentedControl!
    @IBOutlet var countryField: UITextField!
    @IBAction func finish(_ sender: Any) {
        
        
        
        // countryField
        
        country = countryField.text!

        print("\n" + country + "\n")
        
        // genderSControl
        
        print(genderSControl.selectedSegmentIndex)
        
        if genderSControl.selectedSegmentIndex == 1 {
            
            //Gender selected is woman
            gender = true
            
            print(gender)
            
        } else {
            //Gender selected is man
            gender = false
            print(gender)
        }
        
        PFUser.current()?["isFemale"] = gender
        
        // Status of a person
        
        
        if genderSControl.selectedSegmentIndex == 0 {
            
            //Status selected is "student"
            
            status = 0
            
            print(status)
            
        } else if genderSControl.selectedSegmentIndex == 1 {
            
            //Status selected is "working"
            status = 1
            
            print(status)
            
        } else {
            //Status selected is "neither"
            
            status = 2
            print(status)
        }

        
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let isFemale = PFUser.current()?["isFemale"] {
            
            genderSControl.selectedSegmentIndex = 1
            
        }
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
