//
//  GameVC.swift
//  BrainTeaser
//
//  Created by James Gobert on 3/15/16.
//  Copyright © 2016 EverydayDigitals. All rights reserved.
//

import UIKit
import pop

class GameVC: UIViewController {
    
    @IBOutlet weak var yesBtn: CustomButton!
    @IBOutlet weak var noBtn: CustomButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var gameoverImg: UIImageView!
    @IBOutlet weak var playAgainBtn: CustomButton!
    @IBOutlet weak var restartBtn: CustomButton!
    
    
    
    var currentCard: Card!
    var scoreCard: Score!
    var counter: NSTimeInterval!
    var timer = NSTimer()
    var previousCard: String?
    
    var correctAnswer: Int = 0
    var incorrectAnswer: Int = 0


    override func viewDidLoad() {
        super.viewDidLoad()

        currentCard = createCardFromNib()
        currentCard.center = AnimationEngine.screenCenterPosition
        self.view.addSubview(currentCard)
        
       
        scoreCard = createScoreCard()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    @IBAction func yesPressed(sender: UIButton) {
        
        if gameTypeOneSet == true {
        
        if sender.titleLabel?.text == "YES" {
            checkShapeAnswer(sender)
            previousCard = currentCard.currentShape
            showNextCard()
            
        } else {
            titleLbl.text = "Does this card match the previous card?"
            previousCard = currentCard.currentShape
            showNextCard()

            }
            
        } else if gameTypeThreeSet == true {
            
            if sender.titleLabel?.text == "YES" {
                checkShapeAnswer(sender)
                previousCard = currentCard.currentWord
                showNextCard()
            } else if (sender.titleLabel?.text == "RESTART"){
                titleLbl.text = "Answer The Questions TRUE or FALSE"
                scoreCard.removeFromSuperview()
                correctAnswer = 0
                incorrectAnswer = 0
                yesBtn.setTitle("START", forState: .Normal)
                gameTypeThreeSet = true
                playAgainBtn.hidden = true
                
                currentCard = createCardFromNib()
                currentCard.center = AnimationEngine.screenCenterPosition
                self.view.addSubview(currentCard)
                timerLbl.text = "0:30"
                
            } else {
                titleLbl.text = ""
                showNextCard()
                
            }
            
            
        }
        
    }
    
    
    @IBAction func noPressed(sender: UIButton) {
        
        if gameTypeOneSet == true {
        
        checkShapeAnswer(sender)
        previousCard = currentCard.currentShape
        showNextCard()
            
        } else if gameTypeTwoSet == true {
            
            showNextCard()
            
        } else if gameTypeThreeSet == true {
            checkShapeAnswer(sender)
            showNextCard()
            
        } else {
            
            print("choose a game type")
        }
    }
 
    
    //Checking the card answer for Shapes
   //Tag One = YES Button, Tag Two = No Button
    
    func checkShapeAnswer(sender: UIButton) {
        
        if gameTypeOneSet == true {
       
        
        switch sender.tag {
        case 1:
            
            if (previousCard == currentCard.currentShape) {
                correctAnswer += 10
                
            } else {
                incorrectAnswer += 10
            }
            break;
            case 2:
                
                if (previousCard != currentCard.currentShape) {
                  correctAnswer += 10
            } else {
                incorrectAnswer += 10
            }
        default: ()
        break;
            
        }
            
        } else if gameTypeThreeSet == true {
            
            
            switch sender.tag {
            case 1:
                
                if currentCard.currentWordValue == "true" {
                    correctAnswer += 10
                    
                } else {
                    incorrectAnswer += 10
                }
                break;
            case 2:
                
                if currentCard.currentWordValue == "false" {
                    correctAnswer += 10
                } else {
                    incorrectAnswer += 10
                }
            default: ()
            break;
                
            }

            
            
        }
        
    }
    
    
    
    func showNextCard() {
        
        
        if let current = currentCard {
            let cardToRemove = current
            currentCard = nil
            
//            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(0.1) * Double(NSEC_PER_SEC)))
//            
//            dispatch_after(time, dispatch_get_main_queue()) {
            
            AnimationEngine.animateToPosition(cardToRemove, position: AnimationEngine.offScreenLeftPosition, completion: { (anim:POPAnimation!, finished: Bool) -> Void in
                cardToRemove.removeFromSuperview()
            })
                
            }
            
//        }
        
        if let next = createCardFromNib() {
            
            
//            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(0.2) * Double(NSEC_PER_SEC)))
//            dispatch_after(time, dispatch_get_main_queue()) {
            next.center = AnimationEngine.offScreenRightPosition
            self.view.addSubview(next)
                
//            }
            
            currentCard = next
            
//            if gameTypeOneSet == true {
            
            
            if noBtn.hidden {
                noBtn.hidden = false
                yesBtn.setTitle("YES", forState: .Normal)
                setTimer()
//                
//                } else if gameTypeThreeSet == true {
//                
//                if noBtn.hidden {
//                    noBtn.hidden = false
//                    yesBtn.setTitle("True", forState: .Normal)
//                    setTimer()
//
//                    
//                }
//            }
        }
            
            AnimationEngine.animateToPosition(next, position: AnimationEngine.screenCenterPosition, completion: { (anim: POPAnimation!, finshed: Bool) -> Void in
                
            })
        }
        
    }
    
    
    func createCardFromNib() -> Card! {
        return NSBundle.mainBundle().loadNibNamed("Card", owner: self, options: nil)[0] as? Card
    }
    
    func createScoreCard() -> Score? {
        return NSBundle.mainBundle().loadNibNamed("Score", owner: self, options: nil) [0] as? Score
    }
    
    
    func gameOver() {
        
        noBtn.hidden = true
        yesBtn.hidden = true
        restartBtn.hidden = false
        yesBtn.setTitle("RESTART", forState: .Normal)
        titleLbl.text = "Game Score"
        playAgainBtn.hidden = false
        gameTypeOneSet = false
        gameTypeTwoSet = false
        gameTypeThreeSet = false
        
        if let current = currentCard {
            let cardToRemove = current
            currentCard = nil
            AnimationEngine.animateToPosition(cardToRemove, position: AnimationEngine.offScreenLeftPosition, completion: { (anim: POPAnimation!, finished: Bool) -> Void in
                cardToRemove.removeFromSuperview()
            })
        }
        
        scoreCard.center = AnimationEngine.offScreenRightPosition
        self.view.addSubview(scoreCard)
        
        scoreCard.correctScore.text = "\(correctAnswer)"
        scoreCard.incorrectScore.text = "\(incorrectAnswer)"
        scoreCard.totalScore.text = "\(correctAnswer - incorrectAnswer)"
        
        AnimationEngine.animateToPosition(scoreCard, position: AnimationEngine.screenCenterPosition, completion: { (anim: POPAnimation!, finished: Bool) -> Void in
            
        })
        
       
    }
    

    
    
    
    @IBAction func playAgainBtnTapped(sender: UIButton) {
        
        
    }
    
    
    @IBAction func restartBtnPressed(sender: AnyObject) {
        
        titleLbl.text = "Remember this image"
        scoreCard.removeFromSuperview()
        correctAnswer = 0
        incorrectAnswer = 0
        yesBtn.setTitle("START", forState: .Normal)
        gameTypeOneSet = true
        playAgainBtn.hidden = true
        restartBtn.hidden = true
        
        currentCard = createCardFromNib()
        currentCard.center = AnimationEngine.screenCenterPosition
        self.view.addSubview(currentCard)
        timerLbl.text = "00"
        yesBtn.hidden = false

        
    }
    
    
    func setTimer() {
        
        counter = NSTimeInterval(30)
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("onTimer"), userInfo: nil, repeats: true)
        
    }
    
    func timerString(time: NSTimeInterval) -> String {
        let minutes = (Int(time) / 60) % 60
        let seconds = Int(time) % 60
        return String(format: "%d:%2d", minutes, seconds)
    }
    
    func onTimer() {
        if (counter > 0) {
            counter = counter - 1
            timerLbl.text = timerString(counter)
        } else {
            counter = 0
            gameOver()
            timer.invalidate()
        }
    }
    
    

}
