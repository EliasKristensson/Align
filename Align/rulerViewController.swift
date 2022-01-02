//
//  rulerViewController.swift
//  Align
//
//  Created by Elias Kristensson on 2020-12-27.
//  Copyright © 2020 Elias Kristensson. All rights reserved.
//

import UIKit
import DeviceCheck

//struct Device {
//    static let labels = ["iPhone7", "iPhone8", "iPhoneX", "iPhone12"]
//    static var count = labels.count
//    static let scaleInch = [5.8, 6, 5.8, 6]
//}

class rulerViewController: UIViewController {
    
    @IBOutlet weak var rulerLabel: UILabel!
    @IBOutlet weak var rulerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        update()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        update()
    }

    func update() {
        print("update()")

        rulerView.subviews.forEach{ $0.removeFromSuperview() }
        rulerView.layer.sublayers?.forEach{ $0.removeFromSuperlayer() }

        let scale1cm = 10*device.scale1mm
        let min = 0.0
        let max = Double(self.rulerView.frame.height) / scale1cm

        let interval = 0.1
        let w = 20.0

        // LINES
        let lines = UIBezierPath()

        // DRAW TEMP OTHER LINES
        for line in stride(from: min, to: max, by: interval)
        {
            let isInteger = floor(line) == line
            let isHalfInteger = floor(line*2) == line*2

            var width = (isInteger) ? w : w/2
            
            if !isInteger && isHalfInteger {
                width = 3*w/4
            }
            
            let oneLine = UIBezierPath()
            
            oneLine.move(to: CGPoint(x: Double(self.rulerView.bounds.midX), y: line*scale1cm))
            oneLine.addLine(to: CGPoint(x: Double(self.rulerView.bounds.midX) + width, y: line*scale1cm))

            lines.append(oneLine)

            // INDICATOR TEXT
            if(isInteger)
            {
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 21))
                label.center = CGPoint(x: Double(self.rulerView.bounds.midX) + width + 25, y: line * scale1cm)
                label.font = UIFont(name: "HelveticaNeue",
                                    size: 10.0)
                label.textAlignment = .center
                label.text = "\(line)" + " cm"
                
                rulerView.addSubview(label)
            }
        }

        // DESIGN LINES IN LAYER
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = lines.cgPath
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 1

        // ADD LINES IN LAYER
        rulerView.layer.addSublayer(shapeLayer)
    }
    
    
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return devices.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return devices[row]
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        deviceType = devices[row]
//
////        update()
//    }
    
}


public extension CGFloat {
    /**
     Converts pixels to points based on the screen scale. For example, if you
     call CGFloat(1).pixelsToPoints() on an @2x device, this method will return
     0.5.
     
     - parameter pixels: to be converted into points
     
     - returns: a points representation of the pixels
     */
    func pixelsToPoints() -> CGFloat {
        return self / UIScreen.main.scale
    }
    
    /**
     Returns the number of points needed to make a 1 pixel line, based on the
     scale of the device's screen.
     
     - returns: the number of points needed to make a 1 pixel line
     */
    static func onePixelInPoints() -> CGFloat {
        return CGFloat(1).pixelsToPoints()
    }
}
