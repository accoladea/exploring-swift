//
//  ViewController.swift
//  Timer Table
//
//  Created by Zhan Dov on 12/23/16.
//  Copyright © 2016 Accolade. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var table: UITableView!
    @IBAction func sliderChanged(_ sender: Any) {
            table.reloadData()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 50
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        let a =  String((Int(slider.value * 20)))
        let b =  String((indexPath.row + 1))
        cell.textLabel?.text =  "\(a) * \(b) = " + String((Int(slider.value * 20)) * (indexPath.row + 1))
        return cell
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

