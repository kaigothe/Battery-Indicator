//
//  batteryLevelManager.swift
//  Battery-Indicator
//
//  Created by Kai Gothe on 09.06.19.
//  Copyright © 2019 Kai Gothe. All rights reserved.
//

import UIKit

protocol heyBatteryDelegate {
    func heyBatteryUpdate(value: Float, state: UIDevice.BatteryState, isLowPowerEnabled:Bool?)
}


// delegates

class heyBattery {
    
    private var batteryLevel: Float {
        return UIDevice.current.batteryLevel
    }
    
    private var batteryState: UIDevice.BatteryState {
        return UIDevice.current.batteryState
    }
    
    private var isLowPowerModeEnabled : Bool{
        return ProcessInfo.processInfo.isLowPowerModeEnabled
    }
    
    var delegate : heyBatteryDelegate?
    
    init() {
        UIDevice.current.isBatteryMonitoringEnabled = true
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.batteryLevelDidChange(_:)),
            name: UIDevice.batteryLevelDidChangeNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.batteryStateDidChange(_:)),
            name: UIDevice.batteryStateDidChangeNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(lowPowerModeChanged(_:)),
            name: NSNotification.Name.NSProcessInfoPowerStateDidChange,
            object: nil
        )
        
        print(batteryLevel)
        debugBattery(state: batteryState)
    }
    
    
    // MARK: Battery functions
    public func showLevel() -> Float{
        return self.batteryLevel
    }
    
    public func showStatus() -> UIDevice.BatteryState{
        return self.batteryState
    }
    
    
    // MARK: Notifications Functions
    @objc func batteryLevelDidChange(_ notification: Notification) {
        print(batteryLevel)
        self.delegate?.heyBatteryUpdate(value: self.batteryLevel, state: self.batteryState, isLowPowerEnabled: isLowPowerModeEnabled)
        print("BatteryLevel : \(self.batteryLevel) ")
    }
    
    @objc func batteryStateDidChange(_ notification: Notification){
        print(batteryState)
        self.delegate?.heyBatteryUpdate(value: self.batteryLevel, state: self.batteryState, isLowPowerEnabled: isLowPowerModeEnabled)
         debugBattery(state: self.batteryState)
    }
    
    @objc func lowPowerModeChanged(_ notifications: Notification){
        self.delegate?.heyBatteryUpdate(value: self.batteryLevel, state: self.batteryState, isLowPowerEnabled: isLowPowerModeEnabled)
    }
    
    private func debugBattery(state: UIDevice.BatteryState){
        switch state {
        case .charging:
            print("Lädt")
        case .full :
            print("Voll")
        case .unplugged:
            print("angeschlossen")
        case .unknown:
            print("unkown")
        default:
            print("default")
        }
    }
}
