//
//  SecondViewController.swift
//  Advanced Segues
//
//  Created by Zhan Dov on 12/28/16.
//  Copyright © 2016 Accolade. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var username = "Akhmed"
    
    var activeRow = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        print(globalVariable)
        print(activeRow)
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
