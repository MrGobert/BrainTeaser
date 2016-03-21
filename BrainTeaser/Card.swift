//
//  Card.swift
//  BrainTeaser
//
//  Created by James Gobert on 3/15/16.
//  Copyright © 2016 EverydayDigitals. All rights reserved.
//

import UIKit

class Card: UIView {

    let shapes = ["shape1", "shape2", "shape3"]
    
    let numbers = ["number1", "number2", "number3"]
    
    let words = ["The Earth Is Round?": "true",
        "Tomatoes Are Fruit?": "true",
        "Microsoft makes toilet tissue?": "false"]
    
    var currentShape: String!
    
    var currentNumber: String!
    
    var currentWord: String!
    
    var currentWordValue: String!
    
    @IBOutlet weak var shapeImage: UIImageView!
    
    @IBOutlet weak var quizText: UILabel!
    
    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            setupView()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        setupView()
    }
    
    override func awakeFromNib() {
        setupView()
        
        if gameTypeOneSet == true {
            
        shapeImage.hidden = false
            
        selectShape()
            
        } else if gameTypeTwoSet == true {
            
        selectNumbers()
            
        } else if gameTypeThreeSet == true {
            
        quizText.hidden = false
            
        selectWords()
            
        } else {
            
            print("No gametype was selected")
        }
        
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSizeMake(0.0, 2.0)
        self.layer.shadowColor = UIColor(red: 157.0/255.0, green: 157.0/255.0, blue: 157.0/255.0, alpha: 1.0).CGColor
        
        self.setNeedsLayout()
    }
    
    func selectShape() {
        currentShape = shapes[Int(arc4random_uniform(3))]
        shapeImage.image = UIImage(named: currentShape)
    }
    
    func selectWords() {
        let index: Int = Int(arc4random_uniform(UInt32(words.count)))
        currentWord = Array(words.keys)[index]
        currentWordValue = Array(words.values)[index]
        
       
        quizText.text = currentWord
        
        
        print(currentWord)
        print(currentWordValue)
    }
    
    func selectNumbers() {
        
        currentNumber = numbers[Int(arc4random_uniform(3))]
        shapeImage.image = UIImage(named: currentNumber)
    }
   
}
