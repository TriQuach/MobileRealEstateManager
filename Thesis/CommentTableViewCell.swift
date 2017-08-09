//
//  CommentTableViewCell.swift
//  Thesis
//
//  Created by Tri Quach on 8/9/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var lblAnswer: UILabel!
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var lblBuyer: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
