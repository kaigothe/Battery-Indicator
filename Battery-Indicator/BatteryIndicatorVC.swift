//
//  BatteryIndicatorVC.swift
//  Battery-Indicator
//
//  Created by Kai Gothe on 09.06.19.
//  Copyright © 2019 Kai Gothe. All rights reserved.
//

import UIKit

class BatteryIndicatorVC: UIViewController, heyBatteryDelegate {
    
    
    let batteryFrame = CGRect(x:0, y:0, width:24, height: 14)
    let indicatorMaxWidth : CGFloat = 14
    let indicatorHeight : CGFloat = 8
    var imageWrapper : UIImageView?
    var batteryImage = UIImage(named: "battery")
    var batteryChargingImage = UIImage(named: "battery-charging")
    var indicator = UIView(frame: CGRect(x: 3, y: 3, width: 0, height: 8))
    let myBattery = heyBattery()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame.size = batteryFrame.size
        myBattery.delegate = self
        // ImageView
        craeteImageWrapper()
    }
    
    func craeteImageWrapper(){
        imageWrapper = UIImageView(frame: self.batteryFrame)
        indicator.backgroundColor = UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0)
        if let imageWrapper = imageWrapper{
            self.view.addSubview(indicator)
            self.view.addSubview(imageWrapper)
            updateIndicator()
        }else{
            print("ImageView not found")
        }
        
    }
    
    func updateIndicator(){
        print("Battery Level : \(CGFloat(self.myBattery.showLevel())*self.indicatorMaxWidth)")
        DispatchQueue.main.async {
            self.indicator.frame.size = CGSize(width: (CGFloat(self.myBattery.showLevel())*self.indicatorMaxWidth), height: self.indicatorHeight)
            switch self.myBattery.showStatus(){
            case .charging :
                self.imageWrapper?.image = self.batteryChargingImage
            default:
                self.imageWrapper?.image = self.batteryImage
            }
        }
    }
    
    func heyBatteryUpdate(value: Float, state: UIDevice.BatteryState) {
        print("Battery update called in BatteryIndicatorVC")
        updateIndicator()
    }
}


