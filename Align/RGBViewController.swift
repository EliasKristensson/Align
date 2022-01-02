//
//  RGBViewController.swift
//  Align
//
//  Created by Elias Kristensson on 2020-10-07.
//  Copyright © 2020 Elias Kristensson. All rights reserved.
//

import UIKit

class RGBTarget: UIView {

    var settingsManager: SettingsManager!
    var noSpokes = 1
    var size: CGFloat!

    override func draw(_ rect: CGRect) {
        drawSpoke(rect: rect, startRadian: deg2rad(CGFloat(0)), endRadian: deg2rad(CGFloat(120)), color: .blue)
        drawSpoke(rect: rect, startRadian: deg2rad(CGFloat(120)), endRadian: deg2rad(CGFloat(240)), color: .green)
        drawSpoke(rect: rect, startRadian: deg2rad(CGFloat(240)), endRadian: deg2rad(CGFloat(360)), color: .red)
    }

    private func drawSpoke(rect: CGRect, startRadian: CGFloat, endRadian: CGFloat, color: UIColor) {
        let center = CGPoint(x: rect.origin.x + rect.width / 2, y: rect.origin.y + rect.height / 2)
        let radius = size * (min(rect.width, rect.height)) / (2 * 100)
        
        let path = UIBezierPath()
        path.move(to: center)
        path.addArc(withCenter: center, radius: radius, startAngle: startRadian, endAngle: endRadian, clockwise: true)
        path.close()
        color.setFill()
        path.fill()
    }
    
    func deg2rad(_ number: CGFloat) -> CGFloat {
        return number * .pi / 180
    }
}

class RGBViewController: UIViewController {

    var size = 100
    var rgbTarget: RGBTarget!
    
    @IBOutlet weak var bgWhite: UISwitch!
    @IBOutlet weak var sizeSlider: UISlider!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleText: UILabel!
    
    
    @IBAction func sizeChanged(_ sender: Any) {
        size = Int(sizeSlider.value)
        update()
    }
    
    @IBAction func bgChanged(_ sender: Any) {
        if bgWhite.isOn {
            self.view.backgroundColor = UIColor.white
            titleText.textColor = .black
        } else {
            self.view.backgroundColor = UIColor.black
            titleText.textColor = .white
        }
        update()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        rgbTarget = RGBTarget(frame: CGRect(x: containerView.bounds.minX, y: containerView.bounds.minY, width: containerView.bounds.width, height: containerView.bounds.height))
        
        sizeSlider.value = Float(size)
        rgbTarget.size = CGFloat(size)
        rgbTarget.backgroundColor = .clear
        containerView.addSubview(rgbTarget)
    }
    
    
    func update() {
        print("updateRGB()")
        
        containerView.subviews.forEach{ $0.removeFromSuperview() }
        
        rgbTarget = RGBTarget(frame: CGRect(x: containerView.bounds.minX, y: containerView.bounds.minY, width: containerView.bounds.width, height: containerView.bounds.height))
        
        rgbTarget.size = CGFloat(size)
        rgbTarget.backgroundColor = .clear
        containerView.addSubview(rgbTarget)
    }
    
}
