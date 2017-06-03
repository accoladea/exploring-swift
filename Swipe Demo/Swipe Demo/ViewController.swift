//
//  ViewController.swift
//  Swipe Demo
//
//  Created by Zhan Dov on 6/1/17.
//  Copyright © 2017 accolade. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let label = UILabel(frame: CGRect(x: self.view.bounds.width / 2 - 100, y: self.view.bounds.height / 2 - 50, width: 200, height: 100 ))
        
        label.text = "Drag me!"
        
        label.textAlignment = NSTextAlignment.center
        
        view.addSubview(label)
        
        let gesture = UIPanGestureRecognizer(target: self , action: #selector(self.wasDragged(gestureRecognizer:)))
        
        label.isUserInteractionEnabled = true
        
        label.addGestureRecognizer(gesture)
    
    }
    
    
    func wasDragged(gestureRecognizer: UIPanGestureRecognizer) {
        
        let translation = gestureRecognizer.translation(in: view)
        
        print(translation)
        
        let label = gestureRecognizer.view!
        
        label.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: self.view.bounds.height / 2 + translation.y)
        
        if gestureRecognizer.state == UIGestureRecognizer
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

