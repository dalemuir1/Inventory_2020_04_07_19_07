//
//  ButtonUtil.swift
//  Inventory
//
//  Created by dalemuir on 10/7/16.
//  Copyright © 2016 Dale Muir. All rights reserved.
//

import UIKit

class ButtonUtil: NSObject {

    static func configureButton(button: UIButton, isEnabled: Bool, isHidden: Bool){
        button.isHidden = isHidden
        if !isHidden {
            button.isEnabled = isEnabled
            button.layer.borderWidth = 1.0
            button.layer.cornerRadius = 6.0
            button.layer.borderColor = UIColor.blue.cgColor
        }
    }
    
       static func configureButtonArray(buttonArray: [UIButton], isEnabled: Bool, isHidden: Bool){
        for button in buttonArray {
            configureButton(button: button, isEnabled: isEnabled, isHidden: isHidden)
        }
    }
    
}
