//
//  GridViewController.swift
//  Align
//
//  Created by Elias Kristensson on 2020-10-10.
//  Copyright © 2020 Elias Kristensson. All rights reserved.
//

import UIKit

class GridViewController: UIViewController {
    
    var settingsManager: SettingsManager!
    var width = 2
    var no = 20
    var color = UIColor.black.cgColor
    
    @IBOutlet weak var infoText: UILabel!
    @IBOutlet weak var lineWidth: UISlider!
    @IBOutlet weak var distSlider: UISlider!
    @IBOutlet weak var containerView: UIImageView!
    @IBOutlet weak var bgWhite: UISwitch!
    @IBOutlet weak var titleText: UILabel!
    
    @IBAction func widthChanged(_ sender: Any) {
        width   = Int(lineWidth.value)
        no      = Int(distSlider.value)
        infoText.text = "Width: " + "\(Int(width))" + ". Distance between lines: " + "\(Int(no))" + "."
        
        update()
    }
    
    @IBAction func noChanged(_ sender: Any) {
        width   = Int(lineWidth.value)
        no      = Int(distSlider.value)
        infoText.text = "Width: " + "\(Int(width))" + ". Distance between lines: " + "\(Int(no))" + "."
        
        update()
    }

    @IBAction func bgChanged(_ sender: Any) {
        if bgWhite.isOn {
            self.view.backgroundColor = UIColor.white
            titleText.textColor = .black
            infoText.textColor = .black
            color = UIColor.black.cgColor
        } else {
            self.view.backgroundColor = UIColor.black
            titleText.textColor = .white
            infoText.textColor = .white
            color = UIColor.white.cgColor
        }
        update()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lineWidth.minimumValue = 1
        lineWidth.value = Float(width)
        lineWidth.maximumValue = 50
        
        distSlider.minimumValue = 1
        distSlider.value = Float(no)
        distSlider.maximumValue = 200
        
        update()
        
    }
    
    func update() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: containerView.bounds.width, height: containerView.bounds.height))
        
        
        let img = renderer.image { ctx in
            for x in stride(from: Int(containerView.bounds.minX)+width/2, to: Int(containerView.bounds.maxX), by: no) {
                
                ctx.cgContext.move(to: CGPoint(x: CGFloat(x), y: containerView.bounds.minY))
                ctx.cgContext.addLine(to: CGPoint(x: CGFloat(x), y: containerView.bounds.maxY))
                ctx.cgContext.setLineWidth(CGFloat(width))
                ctx.cgContext.setStrokeColor(color)
                ctx.cgContext.strokePath()
                
            }
            for y in stride(from: Int(containerView.bounds.minY)+width/2, to: Int(containerView.bounds.maxY), by: no) {
                
                ctx.cgContext.move(to: CGPoint(x: containerView.bounds.minX, y: CGFloat(y)))
                ctx.cgContext.addLine(to: CGPoint(x: containerView.bounds.maxX, y: CGFloat(y)))
                ctx.cgContext.setLineWidth(CGFloat(width))
                ctx.cgContext.setStrokeColor(color)
                ctx.cgContext.strokePath()
                
            }
            
        }
        
        containerView.image = img
    }


}
