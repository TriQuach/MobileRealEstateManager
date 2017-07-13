//
//  Extension.swift
//  Thesis
//
//  Created by TriQuach on 4/2/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
import UIKit

extension UIButton
{
    func ghostButton()
    {
        
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.2352941176, green: 0.3529411765, blue: 0.6078431373, alpha: 1).cgColor
        self.layer.cornerRadius = 5
        
    }
    func ghostButton(borderWidth: CGFloat, borderColor: UIColor, cornerRadius: CGFloat)
    {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = cornerRadius
    }
    
    
}
