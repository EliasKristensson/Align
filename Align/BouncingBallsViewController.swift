//
//  BouncingBallsViewController.swift
//  Align
//
//  Created by Elias Kristensson on 2021-10-20.
//  Copyright © 2021 Elias Kristensson. All rights reserved.
//

import UIKit

class BouncingBallsViewController: UIViewController {

    var counter = 0
    var balls = [Ball]()
    var timer: Timer!
    var paused = false
    var activeBall: Ball!
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var mainFrame: UIView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var bgWhite: UISwitch!
    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var rgbSlider: UISlider!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var rgbControl: UISegmentedControl!
    @IBOutlet weak var rgbText: UILabel!
    @IBOutlet weak var sizeText: UILabel!
    @IBOutlet weak var speedText: UILabel!
    @IBOutlet weak var infoText: UILabel!
    @IBOutlet weak var sizeSlider: UISlider!
    
    
    @IBAction func bgChanged(_ sender: Any) {
        if bgWhite.isOn {
            self.view.backgroundColor = UIColor.white
            
            titleText.textColor = .black
            infoText.textColor = .black
            rgbText.textColor = .black
            speedText.textColor = .black
            sizeText.textColor = .black
            
            mainFrame.layer.borderColor = UIColor.black.cgColor
            mainFrame.backgroundColor = UIColor.white
        } else {
            self.view.backgroundColor = UIColor.black
            
            titleText.textColor = .white
            infoText.textColor = .white
            rgbText.textColor = .white
            speedText.textColor = .white
            sizeText.textColor = .white
            
            mainFrame.layer.borderColor = UIColor.white.cgColor
            mainFrame.backgroundColor = UIColor.black
        }
    }
    
    @IBAction func clearBalls(_ sender: Any) {
        if timer != nil {
            timer.invalidate()
            timer = nil
        }
        
        for i in 0..<balls.count {
            self.balls[i].removeFromSuperview()
        }
        
        balls = [Ball]()
    }
    
    @IBAction func pausePressed(_ sender: Any) {
        
        if self.timer != nil {
            timer.invalidate()
        }

        if paused {
            pauseButton.setImage(UIImage(systemName: "pause"), for: .normal)
            pauseButton.setTitle(" Pause", for: .normal)

            self.timer = Timer.scheduledTimer(timeInterval: 1/1000, target: self, selector: #selector(self.moveBalls), userInfo: nil, repeats: true)

        } else {
            pauseButton.setImage(UIImage(systemName: "play"), for: .normal)
            pauseButton.setTitle(" Play", for: .normal)
        }
        
        paused.toggle()
    }
    
    @IBAction func addBall(_ sender: Any) {
        
        let size = 20
        let speed = 10
        
        let ball = Ball()
        ball.setup(box: mainFrame.bounds, size: size)
        ball.vx = CGFloat(speed)
        ball.vy = CGFloat(speed)
        ball.diameter = size
        ball.v = speed
        ball.tag = counter
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.updateBall))
        ball.addGestureRecognizer(gesture)
        
        balls.append(ball)
        
        activeBall = ball
        
        self.mainFrame.addSubview(ball)
        infoText.text = "Ball #" + "\(counter)" + ": [255 0 0], v = " + "\(speed)" + ", d = " + "\(size)"
        sizeText.text = "\(size)"
        speedText.text = "\(speed)"
        
        switch rgbControl.selectedSegmentIndex {
        case 0:
            rgbSlider.value = Float(255)
        case 1:
            rgbSlider.value = Float(0)
        case 2:
            rgbSlider.value = Float(0)
        default:
            rgbSlider.value = Float(255)
        }
        
        speedSlider.value = Float(speed)
        sizeSlider.value = Float(size)
        
        counter += 1
        
        if self.timer == nil {
            
            self.timer = Timer.scheduledTimer(timeInterval: 1/1000, target: self, selector: #selector(self.moveBalls), userInfo: nil, repeats: true)
            
            paused = false
            pauseButton.setImage(UIImage(systemName: "pause"), for: .normal)
            pauseButton.setTitle(" Pause", for: .normal)
        }


    }
    
    @IBAction func rgbChanged(_ sender: Any) {
        let value = Int(rgbSlider.value)

        rgbText.text = "\(value)"
        infoText.text = "Ball #" + "\(activeBall.tag)" + ": ["  + "\(activeBall.color[0])" + " " + "\(activeBall.color[1])" + " " + "\(activeBall.color[2])" + "], v = " + "\(activeBall.v)" + ", d = " + "\(activeBall.diameter)"
        
        activeBall.color[rgbControl.selectedSegmentIndex] = value
        activeBall.update(type: "Color")
    }
    
    @IBAction func sizeChanged(_ sender: Any) {
        let value = Int(sizeSlider.value)

        sizeText.text = "\(value)"
        
        activeBall.diameter = value
        activeBall.update(type: "Size")

        infoText.text = "Ball #" + "\(activeBall.tag)" + ": ["  + "\(activeBall.color[0])" + " " + "\(activeBall.color[1])" + " " + "\(activeBall.color[2])" + "], v = " + "\(activeBall.v)" + ", d = " + "\(activeBall.diameter)"

    }
    
    @IBAction func speedChanged(_ sender: Any) {
        let value = Int(speedSlider.value)
        let signX = Int(activeBall.vx).signum()
        let signY = Int(activeBall.vy).signum()

        speedText.text = "\(value)"
        
        activeBall.v = value
        activeBall.vx = CGFloat(value*signX)
        activeBall.vy = CGFloat(value*signY)
        
        infoText.text = "Ball #" + "\(activeBall.tag)" + ": ["  + "\(activeBall.color[0])" + " " + "\(activeBall.color[1])" + " " + "\(activeBall.color[2])" + "], v = " + "\(activeBall.v)" + ", d = " + "\(activeBall.diameter)"
        
    }
    
    @IBAction func rgbControlChanged(_ sender: Any) {
        rgbSlider.value = Float(activeBall.color[rgbControl.selectedSegmentIndex])
        let value = Int(rgbSlider.value)
        rgbText.text = "\(value)"

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainFrame.layer.borderWidth = 2
        mainFrame.layer.borderColor = UIColor.black.cgColor
        
    }
    
    
    
    func makeBall(speed: Int, size: Int, color: UIColor) {
        
        let ball = Ball()
        ball.setup(box: mainFrame.bounds, size: size)
        ball.vx = CGFloat(speed)
        ball.vy = CGFloat(speed)
        ball.tag = counter
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.updateBall))
        ball.addGestureRecognizer(gesture)
        
        balls.append(ball)
        
        activeBall = ball
        
        self.mainFrame.addSubview(ball)
        infoText.text = "Ball #" + "\(counter)" + ": [255 0 0], v = " + "\(speed)" + ", d = " + "\(size)"
        sizeText.text = "\(size)"
        speedText.text = "\(speed)"
        
        switch rgbControl.selectedSegmentIndex {
        case 0:
            rgbSlider.value = Float(255)
        case 1:
            rgbSlider.value = Float(0)
        case 2:
            rgbSlider.value = Float(0)
        default:
            rgbSlider.value = Float(255)
        }
        
        speedSlider.value = Float(speed)
        sizeSlider.value = Float(size)
        
        counter += 1

    }
    
    @objc func moveBalls() {
        for i in 0..<balls.count {
            balls[i].move()
        }
    }
    
    @objc func updateBall(sender : UITapGestureRecognizer) {

        if let tag = sender.view?.tag {
            if let tmp = balls.first(where: {$0.tag == tag}) {
                activeBall = tmp
                infoText.text = "Ball #" + "\(activeBall.tag)" + ": ["  + "\(activeBall.color[0])" + " " + "\(activeBall.color[1])" + " " + "\(activeBall.color[2])" + "], v = " + "\(activeBall.v)" + ", d = " + "\(activeBall.diameter)"
            }
        }
        
    }
    

    

}

extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue, alpha)
    }
}

//extension SignedNumberType {
//    var signValue: Int {
//        return (self >= -self) ? 1 : -1
//    }
//}
