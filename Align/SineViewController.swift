//
//  SineViewController.swift
//  Align
//
//  Created by Elias Kristensson on 2021-02-22.
//  Copyright © 2021 Elias Kristensson. All rights reserved.
//

import UIKit

class SineViewController: UIViewController {
    
    var size = CGFloat(25)
    var freq = 0.5
    var per = 2.0
    var color = UIColor.black.cgColor
    var sineWave = CAGradientLayer()
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var infoText: UILabel!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var bgWhite: UISwitch!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var frequency: UISlider!
    @IBOutlet weak var waveSelector: UISegmentedControl!
    
    @IBAction func bgChanged(_ sender: Any) {
        if bgWhite.isOn {
            self.view.backgroundColor = UIColor.white
            infoText.textColor = UIColor.black
            color = UIColor.black.cgColor
            titleText.textColor = .black
        } else {
            self.view.backgroundColor = UIColor.black
            infoText.textColor = UIColor.white
            color = UIColor.white.cgColor
            titleText.textColor = .white
        }
        update()
    }
    
    @IBAction func waveTypeChanged(_ sender: Any) {
        
    }
    
    @IBAction func freqChanged(_ sender: Any) {
        let value = Int(frequency.value)
        per = Double(value)/10
        freq = Double(round(100/per)/100)
        infoText.text = "Period: " + "\(per)" + " mm. Frequency: " + "\(freq)" + " lp/mm."
        update()

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frequency.value = Float(per)
        
        update()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        update()
    }
    
    
    func makeSineWave() {
        print("makeSineWave()")
        
        let height = 25.4*Double(containerView.frame.height)/device.PPI // Height in mm
        let f = 2*height/per // Height (mm) / period (mm) = Number of lines across height
        
        var colors = [CGColor]()
        for i in stride(from: 0.0, through: 1.0, by: 1/f) {
            let component = CGFloat(0.5 + 0.5*cos(Double.pi*Double(i)*f))
            colors.append(UIColor(red: 1 - component, green: 1 - component, blue: 1 - component, alpha: 1).cgColor)
        }

        sineWave.colors = colors
        
    }
    
    
    func update() {
        
        imageView.subviews.forEach{ $0.removeFromSuperview() }
        imageView.layer.sublayers?.forEach{ $0.removeFromSuperlayer() }

        // FREQUENCY LENGTH
        let interval = Double(per*device.scale1mm) // period (mm) * nr of pixel (mm-1)

        // LINES
        let lines = UIBezierPath()

        // DRAW TEMP OTHER LINES
        for line in stride(from: 0.0, to: Double(self.imageView.frame.height), by: interval)
        {
            let oneLine = UIBezierPath()
            
            oneLine.move(to: CGPoint(x: Double(self.imageView.bounds.minX), y: line))
            oneLine.addLine(to: CGPoint(x: Double(self.imageView.bounds.maxX), y: line))

            lines.append(oneLine)
        }

        // DESIGN LINES IN LAYER
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = lines.cgPath
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = CGFloat(interval/2)

        // ADD LINES IN LAYER
        imageView.layer.addSublayer(shapeLayer)
        
//        makeSineWave()
//        containerView.subviews.forEach{ $0.removeFromSuperview() }
//        sineWave.frame = containerView.bounds
//        containerView.layer.addSublayer(sineWave)
        
    }

}
