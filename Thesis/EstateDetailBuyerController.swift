//
//  EstateDetailBuyerController.swift
//  Thesis
//
//  Created by TriQuach on 4/6/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
import UIKit

class EstateDetailBuyerController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
   let estates = ["house1", "house2","house3"]
    @IBOutlet weak var btnDate: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //btnDate.ghostButton()
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return estates.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EstateDetailBuyerControllerTableViewCell
            cell.img.image = UIImage(named: estates[indexPath.row] + ".jpg")
            cell.lblDescrip.text = "askdalskdamsklsadaskdalskdamsklsadaskdalskdamsklsadaskdalskdamsklsad"
            return cell
    }
    
}
