//
//  GameTypeVC.swift
//  BrainTeaser
//
//  Created by James Gobert on 3/17/16.
//  Copyright © 2016 EverydayDigitals. All rights reserved.
//

import UIKit

class GameTypeVC: UIViewController {
    
    
    @IBOutlet weak var gameTypeOne: NSLayoutConstraint!
    
    @IBOutlet weak var gameTypeTwo: NSLayoutConstraint!
    
    @IBOutlet weak var gameTypeThree: NSLayoutConstraint!
    
    
    var animationEngine: AnimationEngine!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

       self.animationEngine = AnimationEngine(constraints: [gameTypeOne, gameTypeTwo, gameTypeThree])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        self.animationEngine.animateOnScreen(0)
        
    }
    
    
    @IBAction func gameTypeOneTapped(sender: AnyObject) {
        
       gameTypeOneSet = true
        
    }

    @IBAction func gameTypeTwoTapped(sender: AnyObject) {
        
        gameTypeTwoSet = true
        
    }
    
    
    @IBAction func gameTypeThreeTapped(sender: AnyObject) {
        
        gameTypeThreeSet = true
        
    }

 
}
