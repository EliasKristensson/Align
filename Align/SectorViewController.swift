//
//  SectorViewController.swift
//  Align
//
//  Created by Elias Kristensson on 2020-10-06.
//  Copyright © 2020 Elias Kristensson. All rights reserved.
//

import UIKit

class SectorStar: UIView {

    var noSpokes: Int!
    var size: CGFloat!

    override func draw(_ rect: CGRect) {
        for i in stride(from: 0, to: 360, by: 360/noSpokes) {
            drawSpoke(rect: rect, startRadian: deg2rad(CGFloat(i)), endRadian: deg2rad(CGFloat(i + 180/noSpokes)), color: .black)
            drawSpoke(rect: rect, startRadian: deg2rad(CGFloat(i + 180/noSpokes)), endRadian: deg2rad(CGFloat(i + 360/noSpokes)), color: .white)
        }
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

class SectorViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
   
    var settingsManager: SettingsManager!
    var spokes = [12, 24, 36, 45, 60, 72, 90, 120]
    var noSpokes = 12
    var size = 100
    var sectorRect: CGRect?
    var sectorStar: SectorStar!



    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var bgWhite: UISwitch!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var noSpokesSelector: UIPickerView!
    @IBOutlet weak var sectorSizeSlider: UISlider!
    
    
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
    
    @IBAction func sizeChanged(_ sender: Any) {
        size = Int(sectorSizeSlider.value)
        update()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noSpokesSelector.delegate = self
        noSpokesSelector.dataSource = self
        sectorSizeSlider.value = Float(size)
        
        sectorStar = SectorStar(frame: CGRect(x: containerView.bounds.minX, y: containerView.bounds.minY, width: containerView.bounds.width, height: containerView.bounds.height))
        
        sectorStar.size = CGFloat(size)
        sectorStar.noSpokes = noSpokes
        sectorStar.backgroundColor = .clear
        containerView.addSubview(sectorStar)
        
    }
    
    
    func update() {
        print("update()")
        
        containerView.subviews.forEach{ $0.removeFromSuperview() }

        sectorStar = SectorStar(frame: CGRect(x: containerView.bounds.minX, y: containerView.bounds.minY, width: containerView.bounds.width, height: containerView.bounds.height))
        
        sectorStar.size = CGFloat(size)
        sectorStar.noSpokes = noSpokes
        sectorStar.backgroundColor = .clear
        containerView.addSubview(sectorStar)
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
         return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return spokes.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(spokes[row])" + "spokes"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        noSpokes = spokes[row]
        
        update()
    }


}
