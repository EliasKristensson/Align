//
//  settingsManager.swift
//  Align
//
//  Created by Elias Kristensson on 2021-02-22.
//  Copyright © 2021 Elias Kristensson. All rights reserved.
//

import UIKit

class SettingsManager {

    let devices = ["Typical", "iPhone 6/7/8 Plus", "iPhone X/XS/XS Max", "iPhone 11 Pro/Max", "iPhone 12/12 Max", "iPhone 12 mini", "iPad"]
    let pixels = UIScreen.screens.first?.currentMode?.size
    var scale = UIScreen.screens.first!.scale
    var screenPPI = Double(326)
    var deviceType = "Typical"
    
    func getScale() {
        
        switch deviceType {
        case "Typical":
            screenPPI = 326
        case "iPhone 6/7/8 Plus":
            screenPPI = 401
        case "iPhone X/XS/XS Max":
            screenPPI = 458
        case "iPhone 11 Pro/Max":
            screenPPI = 458
        case "iPhone 12/12 Max":
            screenPPI = 460
        case "iPhone 12 mini":
            screenPPI = 476
        case "iPad":
            screenPPI = 264
        default:
            screenPPI = 326
        }

    }


}
