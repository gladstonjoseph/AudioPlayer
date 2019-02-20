//
//  ViewController.swift
//  AudioPlayer
//
//  Created by Gladston Joseph on 2/20/19.
//  Copyright © 2019 Gladston Joseph. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBAction func play(_ sender: Any) {
        player.play()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,  selector: #selector(ViewController.updateScrubber), userInfo: nil, repeats: true)
    }
    
    @IBAction func pause(_ sender: Any) {
        player.pause()
        timer.invalidate()
    }
    
    @IBAction func stop(_ sender: Any) {
        timer.invalidate()
        player.pause()
        scrubber.value = scrubber.minimumValue
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        } catch {
            // Process any errors
        }
    }
    
    @IBAction func volumeChanged(_ sender: Any) {
        player.volume = volumeSlider.value
    }
    
    @IBOutlet weak var volumeSlider: UISlider!
    
    @IBAction func scrubberMoved(_ sender: Any) {
        player.currentTime = TimeInterval(scrubber.value)
    }
    
    @IBOutlet weak var scrubber: UISlider!
    
    var player = AVAudioPlayer()
    let audioPath = Bundle.main.path(forResource: "sheep", ofType: "mp3")
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
            scrubber.maximumValue = Float(player.duration)
        } catch {
            // Process any errors
        }
    }
    @objc func updateScrubber() {
        scrubber.value = Float(player.currentTime)
    }
}
