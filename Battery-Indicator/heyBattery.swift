//
//  batteryLevelManager.swift
//  Battery-Indicator
//
//  Created by Kai Gothe on 09.06.19.
//  Copyright © 2019 Kai Gothe. All rights reserved.
//

import UIKit

protocol heyBatteryDelegate {
    func heyBatteryUpdate(value: UIDevice.BatteryState, state: UIDevice.BatteryState)
}


// delegates

class heyBattery {
    
    private var batteryLevel: Float {
        return UIDevice.current.batteryLevel
    }
    
    private var batteryState: UIDevice.BatteryState {
        return UIDevice.current.batteryState
    }
    
    init() {
        UIDevice.current.isBatteryMonitoringEnabled = true
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(batteryLevelDidChange),
            name: UIDevice.batteryLevelDidChangeNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(batteryStateDidChange(_:)),
            name: UIDevice.batteryStateDidChangeNotification,
            object: nil
        )
        print(batteryLevel)
        debugBattery(state: batteryState)
    }
    
    // MARK: Battery 
    
    
    // MARK: Functions
    @objc func batteryLevelDidChange(_ notification: Notification) {
        print(batteryLevel)
    }
    
    @objc func batteryStateDidChange(_ notification: Notification){
        print(batteryState)
        debugBattery(state: batteryState)
    }
    
    private func debugBattery(state: UIDevice.BatteryState){
        switch state {
        case .charging:
            print("Lädt")
        case .full :
            print("Voll")
        case .unknown:
            print("unkown")
        case .unplugged:
            print("angeschlossen")
        }
    }
}
