//
//  ViewController.swift
//  Battery-Indicator
//
//  Created by Kai Gothe on 09.06.19.
//  Copyright © 2019 Kai Gothe. All rights reserved.
//

import UIKit

class ViewController: UIViewController, heyBatteryDelegate {
    
    func heyBatteryUpdate(value: Float, state: UIDevice.BatteryState) {
        print("Battery Level: \(value) Status: \(state)")
    }
    
    var myBatteryView : UIView?
    
    var batteryLevel: Float {
        return UIDevice.current.batteryLevel
    }
    
    var batteryState: UIDevice.BatteryState {
        return UIDevice.current.batteryState
    }
    
    var myBattery : heyBattery?

    @IBOutlet weak var batteryLevelLabel: UILabel!
    @IBOutlet weak var batteryChargingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myBattery = heyBattery()
        myBatteryView = BatteryIndicatorVC().view
        myBatteryView?.frame = CGRect(origin: CGPoint(x: 80, y: 80), size: CGSize(width: 24, height: 14))
        if let batteryView = myBatteryView{
            self.view.addSubview(batteryView)
        }
    }
    
}

