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
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        if (self.myCheckBox.isSelected == true)
        {
            self.myCheckBox.setCheckState(.checked, animated: true)
        }
        
    }
}
