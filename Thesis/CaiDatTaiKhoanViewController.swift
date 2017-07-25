//
//  CaiDatTaiKhoanViewController.swift
//  Thesis
//
//  Created by Tri Quach on 6/20/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import UIKit

class CaiDatTaiKhoanViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var myTbv: UITableView!
    var role:Int!
    var mangInfo:[String] = [
        "Tên",
        "Vai trò",
        "Địa chỉ",
        "Số điện thoại",
        "Email",
        "BĐS đã mua",
        "BĐS đang quan tâm",
        "BĐS đang bán",
        "BĐS đang quản lý"
    ]
    var mangValue:[String] = []
    var user:User!
    override func viewDidLoad() {
        super.viewDidLoad()

        myTbv.delegate = self
        myTbv.dataSource = self
       print (user.name)
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mangInfo.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if ( indexPath.row == 0 )
        {
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "cell1") as! ProfileAvatarTableViewCell
            let data:Data = Data(base64Encoded: user.avatar)!
            cell1.myImg.image = UIImage(data: data)
            
            cell1.myImg.layer.borderWidth = 1
            cell1.myImg.layer.masksToBounds = false
            cell1.myImg.layer.borderColor = UIColor.black.cgColor
            cell1.myImg.layer.cornerRadius = (self.view.frame.height) * 2 / 11 * 0.75 / 2
            cell1.myImg.clipsToBounds = true
            return cell1
        }
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "cell2") as! ProfileLabelTableViewCell
        cell2.lbl1.text = mangInfo[indexPath.row - 1]
        
        if (indexPath.row - 1 == 0)
        {
            cell2.lbl2.text = user.fullName
        }
        else if ( indexPath.row - 1 == 1)
        {
            if (role == 0)
            {
                cell2.lbl2.text = "Người mua nhà"
            }
            else if (role == 1)
            {
                cell2.lbl2.text = "Người bán nhà"
            }
            else
            {
                cell2.lbl2.text = "Bán nhà/môi giới"
            }
        }
        else if ( indexPath.row - 1 == 2)
        {
            cell2.lbl2.text = user.address
        }
        else if (indexPath.row - 1 == 3)
        {
            cell2.lbl2.text = user.phone
        }
        else if (indexPath.row - 1 == 4)
        {
            cell2.lbl2.text = user.email
        }
        else if (indexPath.row - 1 == 5)
        {
            cell2.lbl2.text = "1"
        }
        else if (indexPath.row - 1 == 6)
        {
            cell2.lbl2.text = "2"
        }
        else if (indexPath.row - 1 == 7)
        {
            cell2.lbl2.text = "3"
        }
        else if (indexPath.row - 1 == 8)
        {
            cell2.lbl2.text = "4"
        }
        return cell2
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0)
        {
            return (self.view.frame.height) * 2 / 11
        }
        return (self.view.frame.height)  * 1 / 12.5
    }
    

}
