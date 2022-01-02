//
//  SettingsViewController.swift
//  Align
//
//  Created by Elias Kristensson on 2021-02-22.
//  Copyright © 2021 Elias Kristensson. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let devices = ["Typical", "iPhone 6/7/8 Plus", "iPhone X/XS/XS Max", "iPhone 11 Pro/Max", "iPhone 12/12 Max", "iPhone 12 mini", "iPad"]
//    let pixels = UIScreen.screens.first?.currentMode?.size
//    var scale = UIScreen.screens.first!.scale
//    var screenPPI = device.PPI //Double()
//    var deviceType = device.deviceType //"Typical"
    
    @IBOutlet weak var devicePicker: UIPickerView!
    @IBOutlet weak var dismissButton: UIButton!
    
    @IBAction func dismissTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        devicePicker.dataSource = self
        devicePicker.delegate = self
        
        if let index = devices.firstIndex(where: {$0 == device.deviceType}) {
            print(index)
            devicePicker.selectRow(index, inComponent: 0, animated: true)

        }
        
        update()
    }
    
    func getScale() {
        
        switch device.deviceType {
        case "Typical":
            device.PPI = 326
        case "iPhone 6/7/8 Plus":
            device.PPI = 401
        case "iPhone X/XS/XS Max":
            device.PPI = 458
        case "iPhone 11 Pro/Max":
            device.PPI = 458
        case "iPhone 12/12 Max":
            device.PPI = 460
        case "iPhone 12 mini":
            device.PPI = 476
        case "iPad":
            device.PPI = 264
        default:
            device.PPI = 326
        }

    }

    func update() {
        print("update()")

        getScale()
//        device.PPI = screenPPI
//        device.scale = scale
        device.scale1mm = Double(device.PPI)/(25.4*Double(device.scale))
        
//        let scale1cm = 10*screenPPI/(25.4*Double(scale))
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return devices.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return devices[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        deviceType = devices[row]
        
        device.deviceType = devices[row]

        update()
    }

}
