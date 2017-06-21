//
//  Brick.swift
//  breakBall
//
//  Created by duy phương on 6/16/17.
//  Copyright © 2017 duyphương. All rights reserved.
//

import UIKit

class Brick: UIView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    var brick:UIView!
    var bricks = [UIView]()
    var brickOut:UIView!
    var magin:CGFloat = 10
    var count:Int!
    var value:Int!
    var maginBien:CGFloat = 60
    var colors = [UIColor.red,UIColor.yellow,UIColor.blue,UIColor.brown]
    var valueBrick = [Int]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addBrick()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addBrick() {
        for indexHang in 0..<3 {
            for indexCot in 0..<3{
                brick = UIView(frame: CGRect(x: maginBien + CGFloat(indexCot) * spaceBetwenCot(), y: magin*CGFloat(indexHang+1) + CGFloat(indexHang)*CGFloat(20) , width: 80, height: 20))
                brick.layer.backgroundColor = UIColor.red.cgColor
                valueBrick.append(0)
                bricks.append(brick)
                self.addSubview(brick)
            }
        }
        brickOut = UIView(frame: CGRect(x: frame.width + 200, y: 100, width: 80, height: 20))
        self.addSubview(brickOut)
    }
    func spaceBetwenCot() -> CGFloat {
        let space = (frame.width - maginBien * 2 - 80) / CGFloat(2)
        return space
    }
    
    
    
    
    
}
