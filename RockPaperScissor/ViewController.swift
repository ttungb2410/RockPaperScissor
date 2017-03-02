//
//  ViewController.swift
//  RockPaperScissor
//
//  Created by TTung on 3/1/17.
//  Copyright © 2017 TTung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var gameTimer:Timer!
    var gameScore: Timer!
    var timeMove: Timer!
    var timeAddItem: Timer!
    var timeSpeed: Timer!
    var timeScore = 0
    var maiViewSize: CGSize!
    var buttonSenderTag: UIButton!
    
    
    @IBOutlet weak var lbl_Time: UILabel!
    @IBOutlet weak var lbl_Score: UILabel!
    @IBOutlet weak var lbl_HighScore: UILabel!
    
    var gameManager: GameManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.gameManager = GameManager()
        maiViewSize = self.view.bounds.size
        
        addBackGround()
        addScoreZone()
        
        addStart()
        addBtnRock()
        addBtnPaper()
        addBtnScissor()
    }
    func start(){
        timeScore = 0
    }
    func countScore(){
        timeScore = timeScore + 1
        lbl_Score.text = String(timeScore)
    }
    func Score(){
        start()
        gameScore = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countScore), userInfo: nil, repeats: true)
        
    }
    func reset(){
        gameTimer.invalidate()
        gameScore.invalidate()
        timeMove.invalidate()
        timeAddItem.invalidate()
        timeSpeed.invalidate()
        self.gameManager.speed = 3
        self.gameManager.time = 30
        lbl_Score.text = String("0")
        lbl_Time.text = String("30")
        buttonSenderTag.isHidden = false
        lbl_HighScore.text = "High Score: \(self.timeScore)"
        lbl_HighScore.isHidden = false
        self.timeScore = 0
        
    }
    
    func countDown(){
        self.gameManager.time = self.gameManager.time - 1
        if self.gameManager.time == 0{
            
            
            self.gameManager.time = 30
            reset()
            
        }
        lbl_Time.text = String(self.gameManager.time)
        
    }
    
    func countTime() {
        self.gameManager.start()
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
    }
    
    
    func btnStartClicked(sender: UIButton) {
        
        buttonSenderTag = sender
        if buttonSenderTag.tag == 101{
            removeView()
            gameManager.resetView()
            buttonSenderTag.isHidden = true
            addItem()
            timeMoveItem()
            countTime()
            Score()
            lbl_HighScore.isHidden = true
        }
    }
    func addStart(){
        let button = UIButton(frame: CGRect(x: CGFloat(self.maiViewSize.width*0.5 - 40), y: CGFloat(self.maiViewSize.height*0.8 - self.maiViewSize.height*0.15/2 - 20 ), width: 80, height: 40))
        button.backgroundColor = UIColor.red
        button.alpha = 0.5
        button.setTitle("Start", for: .normal)
        button.addTarget(self, action: #selector(btnStartClicked), for: .touchUpInside)
        button.tag = 101
        self.view.addSubview(button)
        
    }
    
    
    func addItem(){
        
        self.gameManager!.addItemToController(viewcontroller: self, width: (Int(self.maiViewSize.width)), height: (Int(self.maiViewSize.height)))
    }
    
    func timeMoveItem(){
        timeSpeed = Timer.scheduledTimer(timeInterval: 4.2, target: self.gameManager, selector: #selector(gameManager.updateSpeed), userInfo: nil, repeats: true)
        timeMove = Timer.scheduledTimer(timeInterval: 0.01, target: self.gameManager , selector:  #selector(gameManager.updateMove), userInfo: nil, repeats: true)
        timeAddItem = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(addItem), userInfo: nil, repeats: true)
        
    }
    
    func removeView(){
        let subviews = self.view.subviews
        
        for subview in subviews as[UIView]{
            if subview.tag != 101 && subview.tag != 102 {
                subview.removeFromSuperview()
            }
        }
    }
    
    func addScoreZone(){
        let scoreZoneFrame: CGRect = CGRect(x: CGFloat(0), y: CGFloat(Double(self.maiViewSize.height) * 0.6), width: CGFloat(self.maiViewSize.width), height: CGFloat(Double(self.maiViewSize.height) * 0.2))
        let scoreZone : UIView = UIView(frame: scoreZoneFrame)
        scoreZone.backgroundColor = UIColor(red: 255, green: 61, blue: 94, alpha: 1.0)
        scoreZone.alpha = 0.5
        scoreZone.tag = 102
        self.view.addSubview(scoreZone)
        self.view.sendSubview(toBack: scoreZone)
    }
    func addBackGround(){
        let image: UIImage = UIImage(named: "BackGround.jpg")!
        let bgImage: UIImageView = UIImageView(image: image)
        bgImage.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(self.maiViewSize.width), height: CGFloat(Double(self.maiViewSize.height) * 0.6))
        bgImage.tag = 102
        self.view.addSubview(bgImage)
        self.view.sendSubview(toBack: bgImage)
        
        
    }
    func addBtnRock(){
        let buttonRock = UIButton(frame: CGRect(x: CGFloat(13), y: CGFloat(self.maiViewSize.height - self.maiViewSize.height*0.2/2 - 40 ), width: (self.maiViewSize.width - 52)/3, height: 80))
        buttonRock.setImage(UIImage(named: "rock.png"), for: .normal)
        buttonRock.addTarget(self.gameManager, action: #selector(GameManager.btnRockClicked), for: .touchUpInside)
        buttonRock.tag = 102
        self.view.addSubview(buttonRock)
    }
    
    
    
    func addBtnPaper(){
        let buttonPaper = UIButton(frame: CGRect(x: CGFloat(26 + (self.maiViewSize.width - 52)/3), y: CGFloat(self.maiViewSize.height - self.maiViewSize.height*0.2/2 - 40 ), width: (self.maiViewSize.width - 52)/3, height: 80))
        buttonPaper.setImage(UIImage(named: "leaf.png"), for: .normal)
        buttonPaper.addTarget(self.gameManager, action: #selector(GameManager.btnPaperClicked), for: .touchUpInside)
        buttonPaper.tag = 102
        self.view.addSubview(buttonPaper)
        
    }
    
    
    
    func addBtnScissor(){
        let buttonScissor = UIButton(frame: CGRect(x:(self.maiViewSize.width - (self.maiViewSize.width - 52)/3 - 13) , y: CGFloat(self.maiViewSize.height - self.maiViewSize.height*0.2/2 - 40 ), width: (self.maiViewSize.width - 52)/3, height: 80))
        buttonScissor.setImage(UIImage(named: "scissor.png"), for: .normal)
        buttonScissor.addTarget(self.gameManager, action: #selector(GameManager.btnScissorClicked), for: .touchUpInside)
        buttonScissor.tag = 102
        
        self.view.addSubview(buttonScissor)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

   


}

