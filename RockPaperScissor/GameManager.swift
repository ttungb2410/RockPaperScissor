//
//  GameManager.swift
//  RockPaperScissor
//
//  Created by TTung on 3/1/17.
//  Copyright © 2017 TTung. All rights reserved.
//

import UIKit

class GameManager: NSObject {
    var itemViews: NSMutableArray!
    var right:String = ""
    var draw:String = ""
    var wrong:String = ""
    var heightFrame: Int?
    var widthFrame: Int?
    var time = 0
    var speed = 5
    
    override init(){
        self.itemViews = NSMutableArray()
        
    }
    
    func addItemToController(viewcontroller: UIViewController,width:Int , height:Int){
        let itemView = ItemView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        self.heightFrame = height
        self.widthFrame = width
        itemView.generationItem(width: width , height: height)
        self.itemViews?.add(itemView)
        viewcontroller.view.addSubview(itemView)
    }
    
    func updateSpeed(){
        speed = self.speed + 1
    }
    
    func resetSpeed(){
        speed = 5
    }
    
    func updateMove(){
        var currentViews = self.itemViews
        for itemView in self.itemViews!{
            if let tmpItemView = itemView as?  ItemView{
                if (currentViews?.contains(tmpItemView))!{
                    tmpItemView.speed = self.speed
                    (tmpItemView as AnyObject).updateMove()
                    bite(tmpItemView)
                }
                
            }
        }
        currentViews = self.itemViews
        

    }
    func start(){
        time = 30
    }
    
    func resetView(){
        itemViews.removeAllObjects()
    }
    
    
    func btnRockClicked() {
        right = "scissor 2.png"
        draw = "rock 2.png"
        wrong = "leaf 2.png"
        
    }
    
    func btnPaperClicked(){
        right = "rock 2.png"
        draw = "leaf 2.png"
        wrong = "scissor 2.png"
    }
    
    func btnScissorClicked(){
        right = "leaf 2.png"
        draw = "scissor 2.png"
        wrong = "rock 2.png"
    }
    
    func resetResult(){
        right = ""
        draw = ""
        wrong = ""
    }
    
    func bite(_ itemView: ItemView){
           if (itemView.status == itemView.DOWN){
           
            
            
             if itemView.frame.origin.y + itemView.frame.height > CGFloat(Double(itemView.heightFrame)*0.7) && itemView.frame.origin.y + itemView.frame.height <= CGFloat(Double(itemView.heightFrame)*0.8){
                
                if itemView.rdItemName == right {
                    print("right")
                    resetResult()
                    time = self.time + 5
                   
                    self.itemViews?.remove(itemView)
                    itemView.removeFromSuperview()
                }
                    
                else if itemView.rdItemName == draw {
                    print("draw")
                    resetResult()

                    self.itemViews?.remove(itemView)
                    itemView.removeFromSuperview()
                }else if itemView.rdItemName == wrong{
                    print("wrong")
                    if self.time < 5 {
                        time = 1
                    }else  {
                        time = self.time - 5
                    }
                    resetResult()

                    self.itemViews?.remove(itemView)
                    itemView.removeFromSuperview()
                }
                
            }
            else if (itemView.frame.origin.y + itemView.frame.height > CGFloat(Double(itemView.heightFrame)*0.8)) {
                print("lose")
                if self.time < 5 {
                    time = 1
                }else{
                    time = self.time - 5
                }
                resetResult()
                self.itemViews?.remove(itemView)
                itemView.removeFromSuperview()
                
            }
             else {
                resetResult()

            }
        }
    }

}
