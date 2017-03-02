//
//  ItemView.swift
//  RockPaperScissor
//
//  Created by TTung on 3/1/17.
//  Copyright © 2017 TTung. All rights reserved.
//

import UIKit

class ItemView: UIImageView {

    var status: Int!
    var speed: Int = 0
    var vx: Int = 0
    var widthFrame: Int!
    var heightFrame: Int!
    var widthItem: Int!
    var heightItem: Int!
    var DOWN: Int = 0
    var ENDDOWN: Int = 1
    var rdItemName:String = ""
    var itemImage = ["rock 2.png", "leaf 2.png", "scissor 2.png"]
    
    
    override init(frame: CGRect){
        self.widthItem = Int(frame.width)
        self.heightItem = Int(frame.height)
        super.init(frame: frame)
        self.status = ENDDOWN
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func generationItem(width: Int , height: Int){
        self.heightFrame = height
        self.widthFrame = width
        let x: Float = Float(arc4random_uniform(UInt32(width - 60)))
        self.status = DOWN
        
        
        let rd = Int(arc4random_uniform(3))
        rdItemName = itemImage[rd]
        self.image = UIImage(named: rdItemName)
        self.frame = CGRect(x: CGFloat(x), y: CGFloat(40), width: CGFloat(60), height: CGFloat(60))
        
    }
    
    
    
    func updateMove(){
        
        if  (self.status == DOWN){
            self.center = CGPoint(x: self.center.x , y: self.center.y + CGFloat(self.speed))
            
            
            
            if (self.frame.origin.y + self.frame.height > CGFloat(Double(heightFrame)*0.81)){
                
                self.status = ENDDOWN
            }
        }
        else if (self.status == ENDDOWN){
            generationItem(width: self.widthFrame ,  height: self.heightFrame)
            self.status = DOWN
        }
        
    }
    
}




