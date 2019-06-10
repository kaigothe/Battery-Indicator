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
        print("Delegate called  in VC")
    }
    
    var batteryLevel: Float {
        return UIDevice.current.batteryLevel
    }
    
    var batteryState: UIDevice.BatteryState {
        return UIDevice.current.batteryState
    }

    @IBOutlet weak var batteryLevelLabel: UILabel!
    @IBOutlet weak var batteryChargingLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBatteryView()
        
        UIDevice.current.isBatteryMonitoringEnabled = true
        NotificationCenter.default.addObserver(self, selector: #selector(batteryLevelDidChange), name: UIDevice.batteryLevelDidChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(batteryStateDidChange), name: UIDevice.batteryStateDidChangeNotification, object: nil)
        
        switch batteryState {
        case .unplugged, .unknown:
            batteryChargingLabel.text = "not charging"
        case .charging, .full:
            batteryChargingLabel.text = "charging or full"
        }
        
        batteryLevelLabel.text = "\(Int((batteryLevel) * 100))%"
    }
    
    func setupBatteryView(){
        if let batteryView = BatteryIndicatorVC().view{
            batteryView.frame = CGRect(origin: CGPoint(x: 20, y: 80), size: CGSize(width: 24, height: 14))
            self.view.addSubview(batteryView)
        }
    }
    
    @objc func batteryLevelDidChange (notification: Notification) {
        batteryLevelLabel.text = "\(Int((batteryLevel) * 100))%"
    }
    
    @objc func batteryStateDidChange (notification: Notification) {
        switch batteryState {
        case .unplugged, .unknown:
            batteryChargingLabel.text = "not charging"
        case .charging, .full:
            batteryChargingLabel.text = "charging or full"
        }
    }

    

}

