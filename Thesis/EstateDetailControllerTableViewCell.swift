//
//  EstateDetailControllerTableViewCell.swift
//  Thesis
//
//  Created by TriQuach on 5/4/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import UIKit

class EstateDetailControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDescrip: UILabel!
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
