//
//  TinNhanTableViewCell.swift
//  Thesis
//
//  Created by Tri Quach on 7/17/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import UIKit

class TinNhanTableViewCell: UITableViewCell {
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var myImg: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
