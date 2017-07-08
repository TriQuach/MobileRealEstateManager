//
//  Extension_UIImageView.swift
//  Thesis
//
//  Created by TriQuach on 5/10/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView
{
    
    
    func addCameraButton(x:Int, y: Int)
    {
       let btn = UIButton(frame: CGRect(x: x, y: y, width: 100, height: 100))
        
        btn.setImage(UIImage(named: "camera.png"), for: .normal)
        self.addSubview(btn)
        
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imgMoreTapped))
        btn.isUserInteractionEnabled = true
        btn.addGestureRecognizer(tap)

        self.addSubview(btn)
        
    }
    func imgMoreTapped()
    {
        print ("fuck")
    
    }
}
