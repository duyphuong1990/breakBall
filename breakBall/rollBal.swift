//
//  rollBal.swift
//  breakBall
//
//  Created by duy phương on 6/20/17.
//  Copyright © 2017 duyphương. All rights reserved.
//

import UIKit

class rollBal: NSObject {
    
    var xuoi:Bool!
    var deltaAngle:CGFloat!
    var radian:CGFloat!
    
    }
    func rollBall() {
        if xuoi == true {
            quayXuoi()
        }
        else {
            quayNguoc()
        }
    }
    func quayXuoi() {
        deltaAngle = 0.2
        radian = radian + deltaAngle
        ball.transform = CGAffineTransform(rotationAngle: radian)
        self.ball.center = CGPoint(x: self.ball.center.x + ballRaius * deltaAngle, y: self.ball.center.y + ballRaius * direction * deltaAngle)
        
        if (ball.center.x >=  view.bounds.size.width - ballRaius) {
            xuoi = false
            
        }
    }
    func quayNguoc() {
        deltaAngle = -0.2
        radian = radian + deltaAngle
        ball.transform = CGAffineTransform(rotationAngle: radian)
        self.ball.center = CGPoint(x: self.ball.center.x + ballRaius * deltaAngle, y: self.ball.center.y - ballRaius * deltaAngle * direction)
        if (ball.center.x <=  ballRaius) {
            xuoi = true
            
        }
    }
    
    

