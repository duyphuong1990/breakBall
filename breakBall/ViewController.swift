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
    var count = 0
    var mang = 5
    var time:Timer!
    var colors = [UIColor]()
//    var rdColor = 0
//    var hienThiMang:UILabel!
//    var hienThiDiem:UILabel!
//    var mangChoi1:UITextField!
//    var diemChoi1:UITextField!
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addBall()
        addPad()
//        mangChoi()
//        diemchoi()
//        addDiem()
//        addMang()
        colors = [UIColor.red,UIColor.yellow,UIColor.blue,UIColor.white]
        brick = Brick(frame: CGRect(x: 0, y: 100, width: self.view.bounds.size.width, height: 90))
        view.addSubview(brick)
        time = Timer.scheduledTimer(timeInterval: 0.008, target: self, selector: #selector(check), userInfo: nil, repeats: true)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(onPan))
        pad.isUserInteractionEnabled = true
        pad.addGestureRecognizer(panGesture)
    }
    
    func onPan(panGesture: UIPanGestureRecognizer){
        if (panGesture.state == .began || panGesture.state == .changed ){
            let point = panGesture.location(in: self.view)
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
    
    func randomCGFloat(min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * (max - min) + min
    }
    func vaCham() {
        let dic = randomCGFloat(min: 0.5, max: 1.0)
        if (ball.center.y + ballRaius >= self.pad.center.y - 15)
            && (ball.center.x >= self.pad.center.x - 65)
            && (ball.center.x <= self.pad.center.x + 65)
            
        {
            direction = -dic
        }
        if (ball.center.y <= ballRaius) {
            direction = dic
            
        }
        if (ball.center.y >= view.bounds.size.height - ballRaius) {
            ball.center = CGPoint (x: 0, y: view.bounds.size.height/2)
//            mang -= 1
        }
//        if mang == 0 {
//            self.ball.removeFromSuperview()
//            time.invalidate()
//            thongBaoThua()
        }
//        tinhMangChoi()
    
    
    func check() {
        
        let dic = randomCGFloat(min: 0.5, max: 1.0)
        rollBall()
        vaCham()
        if (ball.center.y < CGFloat(190 + 15)) {
            if (ball.center.y > ballRadius){
                
                for i in 0...14{
                    if (ball.center.y <= brick.bricks[i].center.y + CGFloat(10+15+100)
                        && ball.center.x >= (brick.bricks[i].center.x-45)
                        && ball.center.x <= (brick.bricks[i].center.x+45)){
                        count = count + 1
                        direction = dic
                        moveBrick(b1: brick.bricks[i], b2: brick.brickOut)
                       
                        
//                        if(rdColor == 5){
//                            rdColor = 0
//                        }
//                        view.backgroundColor = colors[rdColor]
//                        rdColor = rdColor + 1
//                        tinhDiem()
                        return
                    }
                    }
                
//                if count == 15 {
//                    self.ball.removeFromSuperview()
//                    time.invalidate()
//                    thongBaoThang()
                
            }
            
            else{
                direction = dic
            }
        }
    }

    
    func thang() {
        if count == 15 {
            self.ball.removeFromSuperview()
            time.invalidate()
            thongBaoThang()
        }
        
    }
    
    func thua() {
        if mang == 0 {
            self.ball.removeFromSuperview()
            time.invalidate()
            thongBaoThua()
        }
        
    }
    
    func moveBrick(b1:UIView, b2:UIView) {
        b1.center = b2.center
    }
    
    func thongBaoThang() {
        let alert = UIAlertController(title: "Bạn Đã Thắng", message: "Bạn Muốn Chơi Lại Không", preferredStyle: UIAlertControllerStyle.alert)
        let btnOK = UIAlertAction(title: "OK", style: .default) { (action) in
            self.count = 0
            self.mang = 5
//            self.diemChoi1.text = ""
//            self.mangChoi1.text = String(5)
            self.resetBroad()
            self.addBall()
            self.rollBall()
        }
        alert.addAction(btnOK)
        present(alert, animated: true, completion: nil)
    }
    
    func thongBaoThua() {
        let alert = UIAlertController(title: "Bạn Đã Thua", message: "Bạn Muốn Chơi Lại Không", preferredStyle: UIAlertControllerStyle.alert)
        let btnOK = UIAlertAction(title: "OK", style: .default) { (action) in
            self.mang = 5
            self.count = 0
//            self.diemChoi1.text = ""
//            self.mangChoi1.text = String(5)
            self.resetBroad()
            self.addBall()
            self.rollBall()
        }
        alert.addAction(btnOK)
        present(alert, animated: true, completion: nil)
    }
    
    
    func resetBroad() {
        
        brick.removeFromSuperview()
        ball.removeFromSuperview()
        brick = Brick(frame: CGRect(x: 0, y: 100, width: self.view.bounds.size.width, height: 90))
        view.addSubview(brick)
        time = Timer.scheduledTimer(timeInterval: 0.008, target: self, selector: #selector(check), userInfo: nil, repeats: true)
    
    }
    
//    func mangChoi() {
//        hienThiMang = UILabel(frame: CGRect(x: 10, y: 20, width: 50, height: 20))
//        hienThiMang.text = "LIFE"
//        self.view.addSubview(hienThiMang)
//    }
//    
//    func diemchoi() {
//        hienThiDiem = UILabel(frame: CGRect(x: self.view.bounds.size.width - 80, y: 20, width: 50, height: 20))
//        hienThiDiem.text = "ĐIỂM"
//        self.view.addSubview(hienThiDiem)
//    }
//    
//    func addMang() {
//        mangChoi1 = UITextField(frame: CGRect(x: 63, y: 20, width: 20, height: 20))
//        mangChoi1.text = ""
//        self.view.addSubview(mangChoi1)
//    }
//    
//    func addDiem() {
//        diemChoi1 = UITextField(frame: CGRect(x: self.view.bounds.size.width - 27, y: 20, width: 20, height: 20))
//        diemChoi1.text = ""
//        self.view.addSubview(diemChoi1)
//    }
//    
//    func tinhDiem() {
//        diemChoi1.text = String(count)
//        
//    }
//    
//    func tinhMangChoi() {
//        mangChoi1.text = String(mang)
//    }
}


