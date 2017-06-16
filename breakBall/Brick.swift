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
    override init(frame: CGRect) {
        super.init(frame: frame)
        addBrick()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addBrick() {
        for indexHang in 0..<3 {
            for indexCot in 0..<7{
                brick = UIView(frame: CGRect(x: magin + CGFloat(indexCot) * spaceBetwenCot(), y: 10 + magin*CGFloat(indexHang+1) + CGFloat(indexHang)*CGFloat(30) , width: 50, height: 30))
                brick.layer.backgroundColor = UIColor.red.cgColor
                bricks.append(brick)
                self.addSubview(brick)
                
                
            }
        }
        brickOut = UIView(frame: CGRect(x: frame.width + 200, y: 100, width: 10, height: 10))
        self.addSubview(brickOut)
    }
    func spaceBetwenCot() -> CGFloat {
        let space = (frame.width - magin * 2 - 50) / CGFloat(6)
        return space
    }
    
    
    
    
    
}
