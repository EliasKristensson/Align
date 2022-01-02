//
//  StrobeViewController.swift
//  Align
//
//  Created by Elias Kristensson on 2021-10-20.
//  Copyright © 2021 Elias Kristensson. All rights reserved.
//

import UIKit

class StrobeViewController: UIViewController {

    var index = 0
    var timer: Timer!
    var isRunning = false
    var duration = Double(0.2)
    
    @IBOutlet weak var typeSelector: UISegmentedControl!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var strobeView: UIView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var speedSlider: UISlider!
    
    @IBAction func start(_ sender: Any) {
        
        if timer != nil {
            timer.invalidate()
        }
        
        if isRunning {
            strobeView.isHidden = true
            startButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
            startButton.setTitle("Start", for: .normal)
        }

        if typeSelector.selectedSegmentIndex == 0 {
            if !isRunning {
                strobeView.isHidden = false
//                strobeView.backgroundColor = .white
                timer = Timer.scheduledTimer(timeInterval: duration/2, target: self, selector: #selector(burstBW), userInfo: nil, repeats: true)
//                strobeView.flash(numberOfFlashes: 10000, duration: duration)
                startButton.setImage(UIImage(systemName: "stop.circle"), for: .normal)
                startButton.setTitle("Stop", for: .normal)
            }
            
            isRunning.toggle()
            
        } else if typeSelector.selectedSegmentIndex == 1 {
            
            if !isRunning {
                strobeView.isHidden = false
                timer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(burstRGB), userInfo: nil, repeats: true)
                startButton.setImage(UIImage(systemName: "stop.circle"), for: .normal)
            }
            
            isRunning.toggle()
            
        } else {
            if !isRunning {
                strobeView.isHidden = false
                timer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(burstBGYR), userInfo: nil, repeats: true)
                startButton.setImage(UIImage(systemName: "stop.circle"), for: .normal)
            }
            
            isRunning.toggle()
        }
    }
    
    @IBAction func speedChanged(_ sender: Any) {
        strobeView.isHidden = true
        isRunning = false
        duration = Double(speedSlider.value/1000)
        strobeView.isHidden = true
        startButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
        startButton.setTitle("Start", for: .normal)
        timeLabel.text = "\(Int(speedSlider.value))" + " ms."
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
        strobeView.isHidden = true
        speedSlider.setValue(Float(duration)*1000, animated: false)
        timeLabel.text = "\(speedSlider.value)" + " ms."
        startButton.setTitle("Start", for: .normal)

    }
    
    @objc func burstBW() {
        
        let colors = [UIColor(red: 1, green: 1, blue: 1, alpha: 1), UIColor(red: 0, green: 0, blue: 0, alpha: 1)]
        
        strobeView.backgroundColor = colors[index]
        
        index += 1
        
        if index > 1 {
            index = 0
        }
    }
    
    @objc func burstRGB() {
        
        let colors = [UIColor(red: 1, green: 0, blue: 0, alpha: 1), UIColor(red: 0, green: 1, blue: 0, alpha: 1), UIColor(red: 0, green: 0, blue: 1, alpha: 1)]
        
        strobeView.backgroundColor = colors[index]
        
        index += 1
        
        if index > 2 {
            index = 0
        }
    }
    
    @objc func burstBGYR() {
        
        let colors = [UIColor(red: 0, green: 0, blue: 1, alpha: 1), UIColor(red: 0, green: 1, blue: 0, alpha: 1), UIColor(red: 1, green: 1, blue: 0, alpha: 1), UIColor(red: 1, green: 0, blue: 0, alpha: 1)]
        
        strobeView.backgroundColor = colors[index]
        
        index += 1
        
        if index > 3 {
            index = 0
        }
    }
    
}


extension UIView {
    func flash(numberOfFlashes: Float, duration: Double) {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = duration
        flash.fromValue = 1
        flash.toValue = 0.0
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        flash.autoreverses = true
        flash.repeatCount = numberOfFlashes
        layer.add(flash, forKey: nil)
    }
 }
