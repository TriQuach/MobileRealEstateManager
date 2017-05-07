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
        btnDate.ghostButton(borderWidth: 2, borderColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), cornerRadius: 10)
        imgMainHouse.image = UIImage(named: name_house! + ".jpg")
       btnCare.ghostButton(borderWidth: 2, borderColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), cornerRadius: 10)
        self.navigationItem.title = "Chi tiết BĐS"
       
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
        btnCare.backgroundColor = UIColor(patternImage: UIImage(named: "checked.png")!)
    }
}
