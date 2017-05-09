//
//  BatDongSanControllerTableViewCell.swift
//  Thesis
//
//  Created by TriQuach on 5/4/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import UIKit
import FaveButton
class BatDongSanControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var lblAdress: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblOwner: UILabel!
    @IBOutlet weak var myHouse: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
