//
//  Extension_UIImageView.swift
//  Thesis
//
//  Created by TriQuach on 5/10/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
import UIKit
import FaveButton
extension UIImageView
{
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
