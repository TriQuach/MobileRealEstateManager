//
//  Extension.swift
//  Thesis
//
//  Created by TriQuach on 4/2/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
import UIKit
import FaveButton
extension UIButton
{
    func ghostButton()
    {
        
        self.layer.borderWidth = 2
        self.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        self.layer.cornerRadius = 4
        
    }
    func ghostButton(borderWidth: CGFloat, borderColor: UIColor, cornerRadius: CGFloat)
    {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = cornerRadius
    }
    func addLikeButton()
    {
        let faveButton = FaveButton(
            frame: CGRect(x:0, y:0, width: 44, height: 44),
            faveIconNormal: UIImage(named: "like.png")
        )
        faveButton.delegate = self
        self.addSubview(faveButton)
    }
}
