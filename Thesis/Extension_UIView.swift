//
//  Extension_UIView.swift
//  Thesis
//
//  Created by TriQuach on 4/15/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
import UIKit

extension UIView
{
    func ghostUIView()
    {
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
        
    }
    
        
    func getGeneric<T>(object: T) -> T.Type {
        return T.self
    }
    
        // Swift.Int
}
