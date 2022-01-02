//
//  FRAMEViewController.swift
//  Align
//
//  Created by Elias Kristensson on 2021-10-14.
//  Copyright © 2021 Elias Kristensson. All rights reserved.
//

import UIKit

class FRAMEViewController: UIViewController {

    var per = CGFloat(0.5)
//    var freq = 0.5
    var color = UIColor.white.cgColor
    var timer: Timer!
    var countdown: Timer!
    var time = 100.0
    var runCount = 1
    var angle = CGFloat(0)
    var shapeLayer = CAShapeLayer()
    var noImages = 2
    var delay = 1.0
    var repeatFire = false
    var delayCounter = 3
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var largeImageView: UIImageView!
    @IBOutlet weak var noImagesSlider: UISlider!
    @IBOutlet weak var noImagesText: UILabel!
    @IBOutlet weak var speedText: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var freqSlider: UISlider!
    @IBOutlet weak var freqText: UILabel!
    @IBOutlet weak var repeatButton: UIButton!
    @IBOutlet weak var countdownIndicator: UIButton!
    
    
    @IBAction func repeatChanged(_ sender: Any) {
        repeatFire.toggle()
        
        if repeatFire {
            repeatButton.setImage(UIImage(systemName: "repeat.circle"), for: .normal)
        } else {
            repeatButton.setImage(UIImage(systemName: "stop.circle"), for: .normal)
        }
    }
    
    @IBAction func speedChanged(_ sender: Any) {
        if timer != nil {
            timer.invalidate()
        }
        
        time = Double(speedSlider.value)
        speedText.text = "\(Int(time))" + " ms."
    }
    
    @IBAction func startPressed(_ sender: Any) {
        print("startPressed()")
        
        angle = 0

        if repeatFire {
            startSequence()
        } else {
            delayCounter = 3
            countdown = Timer.scheduledTimer(timeInterval: delay/3, target: self, selector: #selector(delayStart), userInfo: nil, repeats: true)

        }
        
        
    }
    
    @IBAction func freqChanged(_ sender: Any) {
        per = CGFloat(10/freqSlider.value)
        
        freqText.text = "\(per)" + " lp/mm."
        
        makeLines()
        drawLines()

    }
    
    @IBAction func noImagesChanged(_ sender: Any) {
        if timer != nil {
            timer.invalidate()
        }
        
        noImages = Int(noImagesSlider.value)
        noImagesText.text = "\(noImages)" + " images."
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if repeatFire {
            repeatButton.setImage(UIImage(systemName: "repeat.circle"), for: .normal)
        } else {
            repeatButton.setImage(UIImage(systemName: "stop.circle"), for: .normal)
        }
        
        freqText.text = "\(per)" + " lp/mm."
        noImagesText.text = "\(noImages)" + " images."
        speedText.text = "\(Int(time))" + " ms."
        largeImageView.isHidden = true
        countdownIndicator.isHidden = true
        
        makeLines()
        drawLines()
                
    }
    
    
    
    
    @objc func changeImage() {
        print("changeImage()")
        
        update(angle: angle)
        angle = angle + 180.0/CGFloat(noImages)
        
        runCount += 1
        
        if runCount > noImages {
            timer.invalidate()
            clearImage()
            runCount = 1
        }
    }
    
    @objc func startSequence() {
        print("startSequence()")

        timer = Timer.scheduledTimer(timeInterval: time/1000, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
    }

    @objc func delayStart() {
        print("delayStart()")

        countdownIndicator.isHidden = false
        
        switch delayCounter {
        case 3:
            countdownIndicator.setImage(UIImage(systemName: "3.circle"), for: .normal)
        case 2:
            countdownIndicator.setImage(UIImage(systemName: "2.circle"), for: .normal)
        case 1:
            countdownIndicator.setImage(UIImage(systemName: "1.circle"), for: .normal)
        case 0:
            countdownIndicator.setImage(UIImage(systemName: "0.circle"), for: .normal)
            countdown.invalidate()
            
            startSequence()
            countdownIndicator.isHidden = true
        default:
            countdownIndicator.setImage(UIImage(systemName: "3.circle"), for: .normal)
        }
        
        delayCounter -= 1
        
    }

    
    
    func clearImage() {
        imageView.subviews.forEach{ $0.removeFromSuperview() }
        imageView.layer.sublayers?.forEach{ $0.removeFromSuperlayer() }
    }
    
    func drawLines() {
        clearImage()
        imageView.layer.addSublayer(shapeLayer)
        imageView.setNeedsDisplay()
    }
    
    func makeLines() {
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
//        let shapeLayer = CAShapeLayer()
        shapeLayer.path = lines.cgPath
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = CGFloat(interval/2)

        shapeLayer.frame = imageView.bounds
        shapeLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)

    }
    
    func update(angle: CGFloat) {
        print("update(" + "\(angle)" + ")")
        
        imageView.subviews.forEach{ $0.removeFromSuperview() }
        imageView.layer.sublayers?.forEach{ $0.removeFromSuperlayer() }
//        imageView.layer.contentsGravity = .resizeAspectFill
        
        shapeLayer.setAffineTransform(CGAffineTransform(rotationAngle: angle))
        
        imageView.layer.addSublayer(shapeLayer)
        imageView.setNeedsDisplay()

    }

}
