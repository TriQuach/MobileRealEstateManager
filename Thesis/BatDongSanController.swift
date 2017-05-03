//
//  BatDongSanController.swift
//  Thesis
//
//  Created by TriQuach on 4/2/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
import UIKit

class BatDongSanController: UIViewController, UITableViewDataSource,UITableViewDelegate  {
    
    
    
    
    
    
    @IBOutlet weak var imgMore: UIImageView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var lblRole: UILabel!
    var temp:String = ""
    var role:Int? // 0: buyer; 1: seller; 2: broker
    let estates = ["house1", "house2","house3"]
    let owner = ["triquach","quach","tri"]
    let phone = ["123","456","789"]
    let address = ["abc","xyx","asd"]
    var test:String?
    
    @IBOutlet weak var imgSearch: UIImageView!
    @IBOutlet weak var myTbv: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       // lblRole.text = temp
        self.navigationItem.title = "Bất động sản"

        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imgMoreTapped))
        imgMore.isUserInteractionEnabled = true
        imgMore.addGestureRecognizer(tap)
        
        myTbv.dataSource = self
        myTbv.delegate = self
    }
    func imgMoreTapped()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let timkiem = storyboard.instantiateViewController(withIdentifier: "TimKiemController") as! TimKiemController
        
        self.navigationController?.pushViewController(timkiem, animated: true)
    }
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailBuyer = storyboard.instantiateViewController(withIdentifier: "EstateDetailBuyer") as! EstateDetailBuyerController
        
        self.navigationController?.pushViewController(detailBuyer, animated: true)
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if (role == 0)
        {
            return 3
        }
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (role == 0)
        {
            if (section == 0)
            {
                return "Bất động sản đang quan tâm"
            }
            else if (section == 1)
            {
                return "Bất động sản mới nhất"
            }
            return "Bất động sản được quan tâm nhiều"
        }
        else if (role == 1)
        {
            return "Bất động sản của tôi"
        }
        return "Bất động sản đang quản lý"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BatDongSanControllerTableViewCell
       cell.myHouse.image = UIImage(named: estates[indexPath.row] + ".jpg")
        cell.lblAdress.text = address[indexPath.row]
        cell.lblOwner.text = owner[indexPath.row]
        cell.lblPhone.text = phone[indexPath.row]
        //cell?.backgroundColor = .yellow
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabbar = storyboard.instantiateViewController(withIdentifier: "EstateDetailBuyer") as! EstateDetailBuyerController
        tabbar.name_house = estates[indexPath.row]
     //   tabbar.status = temp!
        
        self.navigationController?.pushViewController(tabbar, animated: true)
    }
    
    
    
    
}
