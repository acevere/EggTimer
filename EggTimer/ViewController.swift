//
//  ViewController.swift
//  EggTimer
//
//  Created by Alice Ye on 08/08/2020.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    let eggTimes = ["Soft": 3,
                    "Medium": 4,
                    "Hard": 7]
    
    
    var timer = Timer()
    var player: AVAudioPlayer!
    
    var totalTime = 0
    var secondsPassed = 0
    
    @IBOutlet weak var stopButton: UIButton!
    
    @IBAction func stopButtonPressed(_ sender: UIButton) {
        timer.invalidate()
        player.stop()
        stopButton.isHidden = true
    }
    
    @IBOutlet weak var TitleLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    override func viewDidLoad() {
           super.viewDidLoad()
           // Do any additional setup after loading the view.
        stopButton.isHidden = true
       }
    
    @IBAction func HardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        
        totalTime = eggTimes[hardness]!
        TitleLabel.text = hardness
        stopButton.isHidden = true
        progressBar.isHidden = false
        progressBar.progress = 0.0
        secondsPassed = 0
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            print(Float(secondsPassed) / Float(totalTime))
            
        } else {
            timer.invalidate()
            TitleLabel.text = "DONE!"
            progressBar.isHidden = true
            stopButton.isHidden = false
            //stopButton.isEnabled = true
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
    

}
