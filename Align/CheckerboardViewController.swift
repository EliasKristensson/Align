//
//  CheckerboardViewController.swift
//  Align
//
//  Created by Elias Kristensson on 2020-10-07.
//  Copyright © 2020 Elias Kristensson. All rights reserved.
//

import UIKit

class CheckerboardViewController: UIViewController {
    
    var settingsManager: SettingsManager!
    var number = 20
    var color = UIColor.black.cgColor
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bgWhite: UISwitch!
    @IBOutlet weak var sizeSquareSlider: UISlider!
    @IBOutlet weak var infoText: UILabel!
    @IBOutlet weak var titleText: UILabel!
    
    
    @IBAction func sizeChanged(_ sender: Any) {
        number = Int(sizeSquareSlider.value)
        infoText.text = "Number of squares: " + "\(number)" + "."
        update()
    }
    
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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sizeSquareSlider.value = Float(number)
        infoText.text = "Number of squares: " + "\(number)" + "."
        
        update()
    }
    
    
    
    
    
    func update() {
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: imageView.bounds.width, height: imageView.bounds.width))

        let img = renderer.image { ctx in
            ctx.cgContext.setFillColor(color)

            let width = imageView.bounds.width/CGFloat(number)
            
            for row in 0 ..< number {
                for col in 0 ..< number {
                    if (row + col) % 2 == 0 {
                        ctx.cgContext.fill(CGRect(x: CGFloat(col) * width, y: CGFloat(row) * width, width: width, height: width))
                    }
                }
            }
        }

        imageView.image = img
    }


}
