//
//  ViewController.swift
//  Animations
//
//  Created by Zhan Dov on 12/25/16.
//  Copyright © 2016 Accolade. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBAction func fadeIn(_ sender: Any) {
        
        image.alpha = 0
        
        UIView.animate(withDuration: 1, animations: {
            
            self.image.alpha = 1
            
        })
    }
    
    @IBAction func slideIn(_ sender: Any) {
        
        image.center = CGPoint(x: image.center.x - 500, y: image.center.y)
        
        UIView.animate(withDuration: 2) {
            
            self.image.center = CGPoint(x: self.image.center.x + 500, y: self.image.center.y)
            
        }
        
    }
    
    @IBAction func grow(_ sender: Any) {
        
        image.frame = CGRect(x: 0, y: 160, width: 200, height: 200)
        
        UIView.animate(withDuration: 1) {
                    self.image.frame = CGRect(x: 0, y: 160, width: 400, height: 400)
        }
    }
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var pause: UIButton!
    
    var counter = 1
    
    var isAnimating = false
    
    func animate () {
        
        image.image = UIImage(named: "frame_" + String(counter) + "_delay-0.06s.gif")
        
        counter += 1
        
        if counter == 6 {
            
            counter = 0
            
        }
        
    }
    
    var timer = Timer()
    
    @IBAction func next(_ sender: Any) {
        /*
        var i = 0;
        
        where i < 9 {
            
        self.image.image = UIImage(named: "frame_" + String(i) + "_delay-0.06s.gif")
         
            i += 1;
        
        }*/
        /*
        self.image.image = UIImage(named: "frame_" + String(counter) + "_delay-0.06s.gif")
        
        counter += 1
        
        if counter == 6 {
            
            counter = 0
        
        }
        */
        
        if isAnimating {
            
            timer.invalidate()
            pause.setTitle("Start Animation", for: [])
            isAnimating = false
            
        } else {
         
            timer = Timer.scheduledTimer(timeInterval: 0.06, target: self, selector: #selector(ViewController.animate), userInfo: nil, repeats: true)
            
            pause.setTitle("Stop Animation", for: [])
            
            isAnimating = true

        }
        
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

