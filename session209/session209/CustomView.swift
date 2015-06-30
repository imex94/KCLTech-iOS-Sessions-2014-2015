//
//  CustomView.swift
//  session209
//
//  Created by Alex Telek on 31/01/2015.
//  Copyright (c) 2015 Alex Telek. All rights reserved.
//

import UIKit

@IBDesignable class CustomView: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}
