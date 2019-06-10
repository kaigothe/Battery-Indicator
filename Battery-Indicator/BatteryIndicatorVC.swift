//
//  BatteryIndicatorVC.swift
//  Battery-Indicator
//
//  Created by Kai Gothe on 09.06.19.
//  Copyright © 2019 Kai Gothe. All rights reserved.
//

import UIKit

class BatteryIndicatorVC: UIViewController, heyBatteryDelegate {
    
    
//  Red level level

    let thresholdForLowBattery : Float = 10
    let batteryFrame = CGRect(x:0, y:0, width:24, height: 14)
    let indicatorMaxWidth : CGFloat = 14
    let indicatorHeight : CGFloat = 8
    let greenColor : UIColor = UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0)
    let redColor : UIColor = UIColor(hexString: "#eb3b5a")
    let yellowColor : UIColor = UIColor(hexString: "#fed330")
    
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
        indicator.backgroundColor = greenColor
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
            
            // Indicator
            
            if (self.myBattery.showLevel() <= self.thresholdForLowBattery){
                self.indicator.backgroundColor = self.redColor
            }else{
                self.indicator.backgroundColor = self.greenColor
            }
            
            // Battery Indicator size
            self.indicator.frame.size = CGSize(width: (CGFloat(self.myBattery.showLevel())*self.indicatorMaxWidth), height: self.indicatorHeight)
            
            // Choose Battery Image
            switch self.myBattery.showStatus(){
            case .charging :
                self.imageWrapper?.image = self.batteryChargingImage
            default:
                self.imageWrapper?.image = self.batteryImage
            }
        }
    }
    
    
    func heyBatteryUpdate(value: Float, state: UIDevice.BatteryState, isLowPowerEnabled: Bool?) {
        print("Battery update called in BatteryIndicatorVC")
        updateIndicator()
    }
}


extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
