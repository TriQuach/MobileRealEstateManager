//
//  ResultSearchTableViewCell.swift
//  Thesis
//
//  Created by Tri Quach on 6/25/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import UIKit

class ResultSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var myHouse: UIImageView!
    @IBOutlet weak var lblPostDate: UILabel!
    @IBOutlet weak var lblQuan: UILabel!
    @IBOutlet weak var lblDIenTich: UILabel!
    @IBOutlet weak var lblGia: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
