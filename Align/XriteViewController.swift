//
//  XriteViewController.swift
//  Align
//
//  Created by Elias Kristensson on 2020-10-24.
//  Copyright © 2020 Elias Kristensson. All rights reserved.
//

import UIKit

class XriteViewController: UIViewController {
    
    var settingsManager: SettingsManager!
    
    var colors = [UIColor]()
    var width = CGFloat(100)
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var sizeSlider: UISlider!
    @IBOutlet weak var bgWhite: UISwitch!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func widthChanged(_ sender: Any) {
        width = CGFloat(sizeSlider.value)
        
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

        sizeSlider.minimumValue = 2
        sizeSlider.maximumValue = Float(imageView.bounds.width/4)
        sizeSlider.value = Float(imageView.bounds.width/4)
            
        width = imageView.bounds.width/4
        
        makeColors()
        update()
    }
    
    func makeColors() {
        
        let rgb = [[115, 82, 68], [194, 150, 130], [98, 122, 157], [87, 108, 67], [133, 128, 177], [103, 189, 170], [214, 126, 44], [80, 91, 166], [193, 90, 99], [94, 60, 108], [157, 188, 64], [224, 163, 46], [56, 61, 150], [70, 148, 73], [175, 54, 60], [231, 199, 31], [187, 86, 149], [8, 133, 161], [243, 243, 242], [200, 200, 200], [160, 160, 160], [122, 122, 121], [85, 85, 85], [52, 52, 52]]
        
        for value in rgb {
            colors.append(UIColor(red: CGFloat(value[0])/255, green: CGFloat(value[1])/255, blue: CGFloat(value[2])/255, alpha: 1))
        }
        
        
    }
    
    func update() {
        
        imageView.frame = CGRect(x: 0, y: 0, width: 4*width, height: 6*width)
        imageView.center = view.center
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 4*width, height: 6*width))

        let img = renderer.image { ctx in
            
            var index = 0
            for col in 0 ..< 4 {
                for row in stride(from: 5, through: 0, by: -1) {
//                for row in 0 ..< 6 {
                        ctx.cgContext.setFillColor(colors[index].cgColor)
                        ctx.cgContext.fill(CGRect(x: CGFloat(col)*width, y: CGFloat(row)*width, width: width-1, height: width-1))
                        index = index + 1
                }
            }
        }

        imageView.image = img
    }

}
