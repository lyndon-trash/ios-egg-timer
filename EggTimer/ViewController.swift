//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressView: UIProgressView!

    let startAlarm = 15
    
    let eggTimes: [String : TimeInterval] = [
        "Soft"      : 5 * 60,
        "Medium"    : 7 * 60,
        "Hard"      : 12 * 60
    ]
    
    var deadline: Date?
    var player: AVAudioPlayer?
    var timerStart = 1000
    
    
    @IBAction func selectHardness(_ sender: UIButton) {
        
        let maybeTitle = sender.currentTitle
        
        switch maybeTitle {
        case "Soft", "Medium", "Hard":
            print("\(maybeTitle!) : \(eggTimes[maybeTitle!]!)")
            deadline = Date(timeIntervalSinceNow: eggTimes[maybeTitle!]!)
            timerStart = Int(deadline!.timeIntervalSinceNow)
            countDown()
        default:
            print("Error")
        }
    }
    
    private func countDown() {
        
        if let d = deadline {
            let remaining = Int(d.timeIntervalSinceNow)
            
            progressView.progress = calculateProgress(start: timerStart, current: remaining)
            
            switch remaining {
            case 1...startAlarm:
                progressView.progressTintColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                soundAlarm()
            default:
                progressView.progressTintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            }
            
            if (d < Date()) {
                deadline = nil
                progressView.progressTintColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
                progressView.progress = 1.0
                player?.stop()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.countDown()
            }
        }
    }
    
    private func soundAlarm() {
        
        if (!(player?.isPlaying ?? false)) {
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            self.player = try! AVAudioPlayer(contentsOf: url!, fileTypeHint: AVFileType.mp3.rawValue)
            player?.play()
        }
    }
    
    private func calculateProgress(start: Int, current: Int) -> Float {
        
        return Float(current) / Float(start)
    }
    
}
