//
//  DangMoiCollectionViewCell.swift
//  Thesis
//
//  Created by Tri Quach on 5/28/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import UIKit
import M13Checkbox
class DangMoiCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var myImg: UIImageView!
    @IBOutlet var myCheckBox: M13Checkbox!
    @IBOutlet weak var btnLike: UIButton!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        if (myCheckBox.isEnabled)
//        {
//            myCheckBox.isEnabled = true
//        }
//        else
//        {
//            myCheckBox.setCheckState(.unchecked, animated: true)
//        }
      
        
    }
}
