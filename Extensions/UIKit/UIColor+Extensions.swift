//
//  UIColor.swift
//  SwiftSampleProject
//
//  Created by Christian Sjøgreen on 09/02/2017.
//  Copyright © 2017 Cesit. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let appPurple = UIColor.init(hex: 0x692398)
    
    convenience init(hex: Int) {
        self.init(
            red:    CGFloat((hex >> 16) & 0xff) / 255,
            green:  CGFloat((hex >> 08) & 0xff) / 255,
            blue:   CGFloat((hex >> 00) & 0xff) / 255,
            alpha:  1
        )
    }
}
