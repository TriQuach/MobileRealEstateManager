//
//  BatDongSanControllerTableViewCell.swift
//  Thesis
//
//  Created by TriQuach on 5/4/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import UIKit

class BatDongSanControllerTableViewCell: UITableViewCell {

    
    @IBOutlet weak var btnAddEstate: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblQuan: UILabel!
    @IBOutlet weak var lblDIenTich: UILabel!
    @IBOutlet weak var lblGia: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
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
