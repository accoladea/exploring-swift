//
//  ViewController.swift
//  Audio Player
//
//  Created by Zhan Dov on 12/31/16.
//  Copyright © 2016 Accolade. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBAction func play(_ sender: Any) {
        player.play()
    }
    @IBAction func pause(_ sender: Any) {
        player.pause()
    }
    @IBAction func slider(_ sender: Any) {
        player.volume = sliderOutlet.value
    }
    @IBOutlet weak var sliderOutlet: UISlider!
    
    
    var player = AVAudioPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let audioPath = Bundle.main.path(forResource: "mozart", ofType: "mp3")
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
                    } catch{
            // Process any errors
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

