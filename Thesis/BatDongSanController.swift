//
//  BatDongSanController.swift
//  Thesis
//
//  Created by TriQuach on 4/2/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
import UIKit

class BatDongSanController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tbvLatestEstate: UITableView!
    @IBOutlet weak var tbvRole: UITableView!
    @IBOutlet weak var tbvCare: UITableView!
    @IBOutlet weak var lblRole: UILabel!
    var temp:String?
    let estates = ["house1", "house2","house3"]
    let owner = ["triquach","quach","tri"]
    let phone = ["123","456","789"]
    let address = ["abc","xyx","asd"]
        override func viewDidLoad() {
        super.viewDidLoad()
//            lblTest.text = temp
           // lblRole.text = temp
            self.navigationItem.setHidesBackButton(true, animated:true);
            
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return estates.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if (tableView == self.tbvRole)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BatDongSanControllerTableViewCell
            cell.imgEstate.image = UIImage(named: estates[indexPath.row] + ".jpg")
            cell.lblEstate.text = estates[indexPath.row]
            cell.lblOwner.text = owner[indexPath.row]
            cell.lblPhone.text = phone[indexPath.row]
            cell.lblAddress.text = address[indexPath.row]
            
            return cell
        }
        else if ( tableView == self.tbvLatestEstate)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! BatDongSanControllerTableViewCell
            cell.imgEstate.image = UIImage(named: estates[indexPath.row] + ".jpg")
            cell.lblEstate.text = estates[indexPath.row]
            cell.lblOwner.text = owner[indexPath.row]
            cell.lblPhone.text = phone[indexPath.row]
            cell.lblAddress.text = address[indexPath.row]
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BatDongSan2ControllerTableViewCell
        cell.imgEstate.image = UIImage(named: estates[indexPath.row] + ".jpg")
        cell.lblEstate.text = estates[indexPath.row]
        cell.lblOwner.text = owner[indexPath.row]
        cell.lblPhone.text = phone[indexPath.row]
        cell.lblAddress.text = address[indexPath.row]
        
        return cell
    }
    
}
