//
//  CustomLabel.swift
//  BrainTeaser
//
//  Created by James Gobert on 3/17/16.
//  Copyright © 2016 EverydayDigitals. All rights reserved.
//

import UIKit
import pop

class CustomLabel: UILabel {
    
    
    
    override func awakeFromNib() {
//        setupLblView()
       
    }
    
    func setupLblView() {
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 3.0
        self.layer.shadowOffset = CGSizeMake(0.0, 2.0)
        self.layer.shadowColor = UIColor(red: 157.0/255.0, green: 157.0/255.0, blue: 157.0/255.0, alpha: 1.0).CGColor
        
        self.setNeedsLayout()

    }
    
}
