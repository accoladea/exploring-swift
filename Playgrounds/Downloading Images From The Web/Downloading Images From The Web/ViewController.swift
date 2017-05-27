//
//  ViewController.swift
//  Downloading Images From The Web
//
//  Created by Zhan Dov on 2/18/17.
//  Copyright © 2017 accolade. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var personImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        if documentsPath.count > 0 {
            
            let documentsDirectory = documentsPath[0]
            
            let restorePath = documentsDirectory + "/avicenna.jpg"
            
            personImageView.image = UIImage(contentsOfFile: restorePath)
            
            
        }
        
        let url = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b4/Avicenna_Portrait_on_Silver_Vase_-_Museum_at_BuAli_Sina_%28Avicenna%29_Mausoleum_-_Hamadan_-_Western_Iran_%287423560860%29.jpg/220px-Avicenna_Portrait_on_Silver_Vase_-_Museum_at_BuAli_Sina_%28Avicenna%29_Mausoleum_-_Hamadan_-_Western_Iran_%287423560860%29.jpg")!
        
        let request = NSMutableURLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                
                print(error)
                
            } else {
                if let data = data{
                    if let personImage = UIImage(data: data) {
                        self.personImageView.image = personImage
                        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                        if documentsPath.count > 0 {
                            let documentsDirectory = documentsPath[0]
                            
                                let savePath = documentsDirectory + "/avicenna.jpeg"
                                
                                do {
                                
                                    try UIImageJPEGRepresentation(personImage, 1)?.write(to: URL(fileURLWithPath: savePath))
                                } catch {
                                        //process error
                                }
                        }
                    }
                }
            }
            
        }
        
        task.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

