//
//  GrayscaleViewController.swift
//  Align
//
//  Created by Elias Kristensson on 2020-10-18.
//  Copyright © 2020 Elias Kristensson. All rights reserved.
//

import UIKit

class GrayscaleViewController: UIViewController {
    
    var size = CGFloat(25)
    var type: CAGradientLayerType = .conic
    var gradient = CAGradientLayer()
    
    
    @IBOutlet weak var bgWhite: UISwitch!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var sizeSlider: UISlider!
    @IBOutlet weak var option: UISegmentedControl!
    
    @IBAction func optionChanged(_ sender: Any) {
        if option.selectedSegmentIndex == 0 {
            type = .conic
        } else if option.selectedSegmentIndex == 1 {
            type = .radial
        } else if option.selectedSegmentIndex == 2 {
            type = .axial
        }
        update()
    }
    
    @IBAction func sizeChanged(_ sender: Any) {
        size = CGFloat(sizeSlider.value)
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
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        update()
    }
    
    
    
    func makeGradient() {
        gradient.type = type
        gradient.colors = [
            UIColor.white.cgColor,
            UIColor.black.cgColor
        ]
        switch type {
        case .conic:
            gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
            gradient.endPoint = CGPoint(x: 1, y: 0.5)
        case .radial:
            gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
            gradient.endPoint = CGPoint(x: 1, y: 1)
        case .axial:
            gradient.startPoint = CGPoint(x: 0.5, y: 0)
            gradient.endPoint = CGPoint(x: 0.5, y: 1)
        default:
            gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
            gradient.endPoint = CGPoint(x: 1, y: 1)
        }
    }
    
    
    func update() {

        makeGradient()
        
        let width = view.frame.width*size/100
        
        containerView.subviews.forEach{ $0.removeFromSuperview() }
        
        containerView.frame = CGRect(x: self.view.center.x-width/2, y: self.view.center.y-width/2, width: width, height: width)
        
        containerView.layer.addSublayer(gradient)
        containerView.layer.cornerRadius = width/2
        switch type {
        case .conic:
            containerView.clipsToBounds = true
        case .radial:
            containerView.clipsToBounds = true
        case .axial:
            containerView.clipsToBounds = false
        default:
            containerView.clipsToBounds = true
        }
        gradient.frame = containerView.bounds

    }

}
