//
//  EstateDetailBuyerController.swift
//  Thesis
//
//  Created by TriQuach on 4/6/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
import UIKit
import M13Checkbox
import FaveButton
class EstateDetailBuyerController: UIViewController, UITableViewDelegate, UITableViewDataSource,FaveButtonDelegate {
    
    
    
    @IBOutlet var btnLike: FaveButton!
    @IBOutlet var lblCare: UILabel!
    @IBOutlet weak var myTbv: UITableView!
    @IBOutlet weak var btnCare: UIButton!
    @IBOutlet weak var btnDate: UIButton!
    @IBOutlet weak var imgMainHouse: UIImageView!
    let estates = ["house1", "house2","house3"]
    let descrip = ["abc","xyx","asd"]
    
    var name_house:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        myTbv.dataSource = self
        myTbv.delegate = self
        
        imgMainHouse.image = UIImage(named: name_house! + ".jpg")
        self.navigationItem.title = "Chi tiết BĐS"
        
        btnLike.isHidden = true
        
        
       
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! EstateDetailControllerTableViewCell
        cell.myImg.image = UIImage(named: estates[indexPath.row] + ".jpg")
        cell.lblDescrip.text = descrip[indexPath.row]
        //cell?.backgroundColor = .yellow
        return cell

    }
   
    @IBAction func btnHen(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabbar = storyboard.instantiateViewController(withIdentifier: "login") as! LogInViewController
        tabbar.id = "EstateDetailBuyer"
        self.navigationController?.pushViewController(tabbar, animated: true)
        
    }
    
    @IBAction func btnQuanTam(_ sender: Any) {
//        let faveButton = FaveButton(
//            frame: CGRect(x:btnCare.frame.origin.x, y:btnCare.frame.origin.y, width: 44, height: 44),
//            faveIconNormal: UIImage(named: "like.png"))
//        faveButton.isSelected = true
//        
//        faveButton.delegate = self
//        view.addSubview(faveButton)
        
        btnLike.isHidden = false
        btnLike.isSelected = true
        
        btnCare.isHidden = true
    }
    func faveButton(_ faveButton: FaveButton, didSelected selected: Bool) {
        
    }
    
}
