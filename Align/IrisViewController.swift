//
//  IrisViewController.swift
//  Align
//
//  Created by Elias Kristensson on 2020-12-26.
//  Copyright © 2020 Elias Kristensson. All rights reserved.
//

import UIKit

class IrisViewController: UIViewController {

    var settingsManager: SettingsManager!
    
    var edges = 12
    var size = CGFloat(100)
    
    
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var sidesLabel: UILabel!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var edgesSlider: UISlider!
    @IBOutlet weak var sizeSlider: UISlider!
    @IBOutlet weak var bgWhite: UISwitch!
    
    
    @IBAction func bgChanged(_ sender: Any) {
        update()
    }
    
    @IBAction func nrEdgesChanged(_ sender: Any) {
        update()
    }
    
    @IBAction func sizeChanged(_ sender: Any) {
        update()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bgWhite.isOn = false
        sizeSlider.value = Float(size)
        edgesSlider.value = Float(edges)
        
        update()
        
    }
    
    func update() {
        edges = Int(edgesSlider.value)
        size = CGFloat(sizeSlider.value)
        
        imageView.subviews.forEach{ $0.removeFromSuperview() }
        let star = StarView(frame: CGRect(x: 0, y: 0, width: imageView.frame.width, height: imageView.frame.height))
        star.numberOfEdges = edges
        star.radius = size*star.frame.width/2000
        
        if bgWhite.isOn {
            self.view.backgroundColor = UIColor.white
            imageView.backgroundColor = .white
            titleText.textColor = .black
            sizeLabel.textColor = .black
            sidesLabel.textColor = .black
            star.backgroundColor = .white
            star.fillColor = .black
        } else {
            self.view.backgroundColor = UIColor.black
            imageView.backgroundColor = .black
            titleText.textColor = .white
            sizeLabel.textColor = .white
            sidesLabel.textColor = .white
            star.backgroundColor = .black
            star.fillColor = .white
        }
        
        imageView.addSubview(star)
    }
    
    class StarView: UIView {
        var numberOfEdges = Int()
        var fillColor = UIColor()
        var radius = CGFloat()
        
        override func draw(_ rect: CGRect) {
            
            guard let context = UIGraphicsGetCurrentContext() else { return }
            
            let origin = CGPoint(x: rect.width / 2, y: rect.height / 2)
            let angle = CGFloat(360) / CGFloat(numberOfEdges)
            
            let lines = (0..<numberOfEdges).map { (index) -> CGPoint in

                var point = origin
                let pointRotation = angle * CGFloat(index)
                point.y -= radius
                point = point.rotate(around: origin, with: pointRotation)
                
                return point
            }
                
            context.addLines(between: lines)
            context.setFillColor(fillColor.cgColor)
            context.fillPath()
            
        }
    }
    


    
    
}

extension CGPoint {
    func rotate(around center: CGPoint, with degrees: CGFloat) -> CGPoint {
        let dx = self.x - center.x
        let dy = self.y - center.y
        let radius = sqrt(dx * dx + dy * dy)
        let azimuth = atan2(dy, dx) // in radians
        let newAzimuth = azimuth + degrees * CGFloat(Double.pi / 180.0) // convert it to radians
        let x = center.x + radius * cos(newAzimuth)
        let y = center.y + radius * sin(newAzimuth)
        return CGPoint(x: x, y: y)
    }
}
