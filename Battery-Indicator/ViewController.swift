//
//  ViewController.swift
//  Battery-Indicator
//
//  Created by Kai Gothe on 09.06.19.
//  Copyright © 2019 Kai Gothe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var myBattery = heyBattery()

    @IBOutlet weak var batteryLevelLabel: UILabel!
    @IBOutlet weak var batteryChargingLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func setBatteryLevelLabel(value: Float){
        batteryLevelLabel.text = "Battery Level: \(value)"
    }
    
    func setIsBatteryCharging(value: Bool){
        batteryChargingLabel.text = "is battery charging \(value ? "Yes" : "No" )"
    }

}

