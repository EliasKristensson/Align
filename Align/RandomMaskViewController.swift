//
//  RandomMask.swift
//  Align
//
//  Created by Elias Kristensson on 2021-11-13.
//  Copyright © 2021 Elias Kristensson. All rights reserved.
//

import Foundation
import UIKit

class RandomMaskViewController: UIViewController {
    
    var settingsManager: SettingsManager!
    var number = 20
    var color = UIColor.black.cgColor
    var locked = false
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var numberSlider: UISlider!
    @IBOutlet weak var bgWhite: UISwitch!
    @IBOutlet weak var lockButton: UIButton!
    
    
    @IBAction func lockTapped(_ sender: Any) {
        locked.toggle()
        bgWhite.isEnabled = !locked
        
        if !locked {
            lockButton.setTitle(" pattern not locked", for: .normal)
            lockButton.setImage(UIImage(systemName: "lock.open"), for: .normal)
            update()
        } else {
            lockButton.setTitle(" pattern locked", for: .normal)
            lockButton.setImage(UIImage(systemName: "lock"), for: .normal)
        }
        
    }
    
    @IBAction func numberChanged(_ sender: Any) {
        number = Int(numberSlider.value)
        infoLabel.text = "Number of squares: " + "\(number)" + "."
    }
    
    @IBAction func numberChangedEnded(_ sender: Any) {
        if !locked {
            update()
        }
        
    }
    
    @IBAction func bgWhiteChanged(_ sender: Any) {
        if bgWhite.isOn {
            self.view.backgroundColor = UIColor.white
            infoLabel.textColor = UIColor.black
            color = UIColor.black.cgColor
            titleLabel.textColor = .black
            lockButton.tintColor = .black
        } else {
            self.view.backgroundColor = UIColor.black
            infoLabel.textColor = UIColor.white
            color = UIColor.white.cgColor
            titleLabel.textColor = .white
            lockButton.tintColor = .white
        }
        
        if !locked {
            update()
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberSlider.value = Float(number)
        infoLabel.text = "Number of squares: " + "\(number)" + "."
        
        if !locked {
            update()
        }
        
    }
    
    
    
    func update() {
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: imageView.bounds.width, height: imageView.bounds.width))
        
        let img = renderer.image { ctx in
            ctx.cgContext.setFillColor(color)

            let width = imageView.bounds.width/CGFloat(number)
            
            for row in 0 ..< number {
                for col in 0 ..< number {
                    if Int.random(in: 0...1) == 1 {
                        ctx.cgContext.fill(CGRect(x: CGFloat(col) * width, y: CGFloat(row) * width, width: width, height: width))
                    }
                }
            }
        }

        imageView.image = img
    }

}
