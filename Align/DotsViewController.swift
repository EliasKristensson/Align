//
//  DotsViewController.swift
//  Align
//
//  Created by Elias Kristensson on 2020-10-06.
//  Copyright © 2020 Elias Kristensson. All rights reserved.
//

import UIKit

class DotsViewController: UIViewController {

    var settingsManager: SettingsManager!
    var dotSize = Float(5)
    var dotNumber = Float(10)
    var whiteBG = true
    var color = UIColor.black.cgColor
    
    @IBOutlet weak var bgWhite: UISwitch!
    @IBOutlet weak var dotSizeSlider: UISlider!
    @IBOutlet weak var dotNoSlider: UISlider!
    @IBOutlet weak var infoText: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleText: UILabel!
    
    
    @IBAction func sizeChanged(_ sender: Any) {
        dotSize = round(dotSizeSlider.value)
        dotNumber = round(dotNoSlider.value)
        infoText.text = "Dot size: " + "\(Int(dotSize))" + ". Distance between dots: " + "\(Int(dotNumber))" + "."
        drawDots()
    }
    
    @IBAction func noChanged(_ sender: Any) {
        dotSize = round(dotSizeSlider.value)
        dotNumber = round(dotNoSlider.value)
        infoText.text = "Dot size: " + "\(Int(dotSize))" + ". Distance between dots: " + "\(Int(dotNumber))" + "."
        drawDots()
    }
    
    @IBAction func switchChanged(_ sender: Any) {
        if bgWhite.isOn {
            self.view.backgroundColor = UIColor.white
            self.containerView.backgroundColor = UIColor.white
            infoText.textColor = UIColor.black
            titleText.textColor = .black
        } else {
            self.view.backgroundColor = UIColor.black
            self.containerView.backgroundColor = UIColor.black
            infoText.textColor = UIColor.white
            titleText.textColor = .white
        }
        drawDots()
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bgWhite.isOn = whiteBG
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.black.cgColor
        dotSizeSlider.value = dotSize
        dotNoSlider.value = dotNumber
        infoText.text = "Dot size: " + "\(dotSize)" + ". Distance between dots: " + "\(dotNumber)" + "."
        infoText.textColor = UIColor.black
        
        drawDots()
    }
    
    
    
    
    
    
    
    func drawDots() {
        
        containerView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        
        let r = CGFloat(dotSize)
        var N = CGFloat(dotNumber)
        
        if N < r {
            N = r
        }
        
        var c = UIColor.white.cgColor
        if bgWhite.isOn {
            c = UIColor.black.cgColor
        }
        
        for i in stride(from: containerView.bounds.minX+r, to: containerView.bounds.maxX-r, by: N) {
            for k in stride(from: containerView.bounds.minY+r, to: containerView.bounds.maxY-r, by: N) {
                
                let path = UIBezierPath(ovalIn: CGRect(x: i, y: k, width: r, height: r))
                
                let shapeLayer = CAShapeLayer()
                shapeLayer.path = path.cgPath
                shapeLayer.fillColor = c
                shapeLayer.lineWidth = 0
                
                containerView.layer.addSublayer(shapeLayer)
                
            }
        }
        
    }
    

}
