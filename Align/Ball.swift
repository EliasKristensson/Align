//
//  Ball.swift
//  Align
//
//  Created by Elias Kristensson on 2021-10-20.
//  Copyright © 2021 Elias Kristensson. All rights reserved.
//

import Foundation
import UIKit

class Ball: UIView {
    
    var color: [Int] = [255, 0, 0]
    var vx: CGFloat = 1
    var vy: CGFloat = 1
    var v: Int = 1
    var diameter: Int = 10
    var position: CGPoint = CGPoint(x: 0, y: 0)
    var mainBox: CGRect!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(box: CGRect, size: Int) {
        mainBox = box
        
        let x = Int.random(in: size...Int(mainBox.maxX)-size)
        let y = Int.random(in: size...Int(mainBox.maxY)-size)
        
        self.frame = CGRect(x: x, y: y, width: size, height: size)
        self.backgroundColor = UIColor(red: CGFloat(color[0]), green: CGFloat(color[1]), blue: CGFloat(color[2]), alpha: 1)
        self.layer.cornerRadius = self.frame.width/2
    }
    
    func move() {
        
        var dx = vx*0.05
        var dy = vy*0.05
        
        if (self.center.x + self.frame.width/2 + dx) > mainBox.maxX || (self.center.x - self.frame.width/2 + dx) < mainBox.minX {
            vx = vx*(-1)
            dx = dx*(-1)
        }

        if (self.center.y + self.frame.width/2 + dy) > mainBox.maxY || (self.center.y - self.frame.width/2 + dy) < mainBox.minY {
            vy = vy*(-1)
            dy = dy*(-1)
        }

        self.center.x += dx
        self.center.y += dy
        
    }

    func update(type: String) {

        if type == "Color" {
            self.backgroundColor = UIColor(red: CGFloat(color[0])/255, green: CGFloat(color[1])/255, blue: CGFloat(color[2])/255, alpha: 1)
        }
        
        if type == "Size" {
            self.frame.size.width = CGFloat(diameter)
            self.frame.size.height = CGFloat(diameter)
            self.layer.cornerRadius = self.frame.width/2
        }
    }
}
