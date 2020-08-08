//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let softTime = 5
    let mediumTime = 7
    let hardTime = 12
    
    @IBAction func selectHardness(_ sender: UIButton) {
        switch sender.currentTitle {
        case "Hard":
            print("Hard \(hardTime)")
        case "Medium":
            print("Medium \(mediumTime)")
        case "Soft":
            print("Soft \(softTime)")
        default:
            print("This should not happen")
        }
    }
    
}
