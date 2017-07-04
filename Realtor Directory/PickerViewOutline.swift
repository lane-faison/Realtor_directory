//
//  PickerViewOutline.swift
//  Realtor Directory
//
//  Created by Lane Faison on 7/4/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import UIKit

@IBDesignable

class PickerViewOutline: UIPickerView {
   
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            setupView()
        }
    }
    
    func setupView() {
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor?.cgColor
    }
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
}
