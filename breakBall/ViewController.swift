//
//  ViewController.swift
//  breakBall
//
//  Created by duy phương on 6/14/17.
//  Copyright © 2017 duyphương. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var ball:UIImageView!
    var pad:UIView!
    var brick:Brick!
    var ballRadius:CGFloat = 15
    var magin:CGFloat = 10
    var radian = CGFloat()
    var ballRaius = CGFloat()
    var deltaAngle = CGFloat()
    var xuoi = Bool()
    var direction:CGFloat = 1
    //    var bricks = [UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addBall()
        addPad()
        //        addBrick()
        //        self.bricks = brick.bricks
        brick = Brick(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 130))
        view.addSubview(brick)
        
        let time = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(check), userInfo: nil, repeats: true)
        let time2 = Timer.scheduledTimer(timeInterval: 0.03, target: self, selector: #selector(vaCham), userInfo: nil, repeats: true)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(onPan))
        pad.isUserInteractionEnabled = true
        pad.addGestureRecognizer(panGesture)
    }
    
    func onPan(panGesture: UIPanGestureRecognizer){
        //let translation = panGesture.translation(in: self.view)
        if (panGesture.state == .began || panGesture.state == .changed ){
            
            let point = panGesture.location(in: self.view)
            //            self.pan.center = point
            //self.pan.center = CGPoint (x: pan.center.x + translation.x, y:pan.center.y)
            self.pad.center = CGPoint (x: point.x, y:pad.center.y)
        }
    }
    
    func addBall() {
        ball = UIImageView(image: UIImage(named: "ball2"))
        ball.frame = CGRect(x: self.view.bounds.size.width/2 - 20, y: 200, width: 30, height: 30)
        ballRaius = 15
        self.view.addSubview(ball)
        
    }
    
    func rollBall() {
        if xuoi == true {
            quayXuoi()
        }
        else {
            quayNguoc()
        }
    }
    
    func addPad() {
        pad = UIView(frame: CGRect(x: self.view.bounds.size.width/2 - 80, y: self.view.bounds.size.height-30, width: 160, height: 30))
        pad.layer.backgroundColor = UIColor.green.cgColor
        self.view.addSubview(pad)
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
    
    //    func random0den1() -> CGFloat {
    //        return CGFloat(Float(arc4random()) / Float(UINT32_MAX))
    //    }
    func randomCGFloat(min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * (max - min) + min
    }
    func vaCham() {
        let dic = randomCGFloat(min: 0.5, max: 1.0)
//        let D = ballRaius + 15
//        if ((self.ball.center.x - self.pad.center.x) * (self.ball.center.x - self.pad.center.x) + (self.ball.center.y - self.pad.center.y) * (self.ball.center.y - self.pad.center.y))<= (D * D)
            if (ball.center.y + ballRaius >= self.pad.center.y - 15)
                && (ball.center.x >= self.pad.center.x - 65)
                && (ball.center.x <= self.pad.center.x + 65)
        
        {
            direction = -dic
        }
        
        if (ball.center.y <= ballRaius) {
            //            ball.center = CGPoint (x: 0, y: view.bounds.size.height/2)
            direction = dic
            
        }
        if (ball.center.y >= view.bounds.size.height - ballRaius) {
            ball.center = CGPoint (x: 0, y: view.bounds.size.height/2)
        }
        
    }
    
    func check() {
        let dic = randomCGFloat(min: 0.5, max: 1.0)
        rollBall()
        if (ball.center.y < CGFloat(130 + 15)) {
            if (ball.center.y > ballRadius){
                
                for i in 0...20{
                    if (ball.center.y <= brick.bricks[i].center.y + CGFloat(15+15)
                        && ball.center.x >= (brick.bricks[i].center.x-40)
                        && ball.center.x <= (brick.bricks[i].center.x+40)){
                        moveBrick(b1: brick.bricks[i], b2: brick.brickOut)
                        direction = dic
                        return
                    }
                }
            }
            else{
                direction = -dic
            }
            
        }
        //        if (ball.center.y > view.bounds.size.height - 60) {
        //            direction = -dic
        //        }
    }
    
    func moveBrick(b1:UIView, b2:UIView) {
        b1.center = b2.center
    }
    
}


