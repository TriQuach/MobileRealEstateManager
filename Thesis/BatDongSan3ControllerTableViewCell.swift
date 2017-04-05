//
//  BatDongSan3ControllerTableViewCell.swift
//  Thesis
//
//  Created by TriQuach on 4/5/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import UIKit

class BatDongSan3ControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblOwner: UILabel!
    @IBOutlet weak var lblEstate: UILabel!
    @IBOutlet weak var imgEstate: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
