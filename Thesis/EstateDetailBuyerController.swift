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
    
    
    
    @IBOutlet weak var btnCare: UIButton!
    @IBOutlet weak var btnDate: UIButton!
    @IBOutlet weak var imgMainHouse: UIImageView!
   let estates = ["house1", "house2","house3"]
    
    var name_house:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        btnDate.ghostButton(borderWidth: 2, borderColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), cornerRadius: 10)
        imgMainHouse.image = UIImage(named: name_house! + ".jpg")
       btnCare.ghostButton(borderWidth: 2, borderColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), cornerRadius: 10)
        self.navigationItem.title = "Chi tiết BĐS"
       
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
