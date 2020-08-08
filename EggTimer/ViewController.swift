//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let eggTimes: [String : TimeInterval] = [
        "Soft"      : 2 * 60,
        "Medium"    : 7 * 60,
        "Hard"      : 12 * 60
    ]
    
    var deadline: Date?
    
    @IBOutlet weak var countdownLabel: UILabel!
    
    @IBAction func selectHardness(_ sender: UIButton) {
        
        let maybeTitle = sender.currentTitle
        
        switch maybeTitle {
        case "Soft", "Medium", "Hard":
            print("\(maybeTitle!) : \(eggTimes[maybeTitle!]!)")
            deadline = Date(timeIntervalSinceNow: eggTimes[maybeTitle!]!)
            countDown()
        default:
            print("Error")
        }
    }
    
    func countDown() {
        if let d = deadline {
            let remaining = Int(d.timeIntervalSinceNow)
            countdownLabel.text = "\(remaining)"
            
            switch remaining {
            case 1...60:
                countdownLabel.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            default:
                countdownLabel.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
            }
            
            if (d < Date()) {
                deadline = nil
                countdownLabel.text = "0"
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.countDown()
            }
        }
    }
    
}
