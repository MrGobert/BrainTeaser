//
//  ViewController.swift
//  BrainTeaser
//
//  Created by James Gobert on 3/15/16.
//  Copyright © 2016 EverydayDigitals. All rights reserved.
//

import UIKit


class LoginVC: UIViewController {
    
    @IBOutlet weak var emailConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var passwordConstraint: NSLayoutConstraint!
    

    @IBOutlet weak var loginConstraints: NSLayoutConstraint!
    
    
    var animationEngine: AnimationEngine!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.animationEngine = AnimationEngine(constraints: [emailConstraint, passwordConstraint, loginConstraints])

    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func viewDidAppear(animated: Bool) {
        self.animationEngine.animateOnScreen(1)
        
        }
    
}

