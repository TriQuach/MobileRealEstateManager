//
//  BatDongSanController.swift
//  Thesis
//
//  Created by TriQuach on 4/2/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
import UIKit
import FaveButton

class BatDongSanController: UIViewController, UITableViewDataSource,UITableViewDelegate{
    
    var count2 = 3
    var count:Int = 0
    var num_section:Int = 0
    var mang:[Estate] = [Estate(image: "house1", title: "Bán chung cư Cantavil diện tích 80, 2m2 ban công Đông Nam", gia: "4 tỷ", dientich: "80", quan: "Quận 2", date: "13/5/2017"),Estate(image: "house2", title: "Bán chung cư Cantavil diện tích 80, 2m2 ban công Đông Nam", gia: "4 tỷ", dientich: "80", quan: "Quận 2", date: "13/5/2017"),Estate(image: "house3", title: "Bán chung cư Cantavil diện tích 80, 2m2 ban công Đông Nam", gia: "4 tỷ", dientich: "80", quan: "Quận 2", date: "13/5/2017")]
    
    var mang2:[Estate] = [Estate(image: "house4", title: "Bán chung cư Cantavil diện tích 80, 2m2 ban công Đông Nam", gia: "4 tỷ", dientich: "80", quan: "Quận 2", date: "13/5/2017"),Estate(image: "house5", title: "Bán chung cư Cantavil diện tích 80, 2m2 ban công Đông Nam", gia: "4 tỷ", dientich: "80", quan: "Quận 2", date: "13/5/2017"),Estate(image: "house6", title: "Bán chung cư Cantavil diện tích 80, 2m2 ban công Đông Nam", gia: "4 tỷ", dientich: "80", quan: "Quận 2", date: "13/5/2017")]
    
    var mang3:[Estate] = [Estate(image: "house7", title: "Bán chung cư Cantavil diện tích 80, 2m2 ban công Đông Nam", gia: "4 tỷ", dientich: "80", quan: "Quận 2", date: "13/5/2017"),Estate(image: "house8", title: "Bán chung cư Cantavil diện tích 80, 2m2 ban công Đông Nam", gia: "4 tỷ", dientich: "80", quan: "Quận 2", date: "13/5/2017"),Estate(image: "house9", title: "Bán chung cư Cantavil diện tích 80, 2m2 ban công Đông Nam", gia: "4 tỷ", dientich: "80", quan: "Quận 2", date: "13/5/2017")]
    @IBOutlet weak var cell: BatDongSanControllerTableViewCell!
    
    @IBOutlet var btnLike: UIButton!
    
    @IBOutlet weak var imgMore: UIImageView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var lblRole: UILabel!
    
    var x:CGFloat = 0
    var y:CGFloat = 0
    
    var temp:String = ""
    
    var current_like = false
    var role:Int? // 0: buyer; 1: seller; 2: broker
    var estates = ["house1", "house2","house3"]
    var like = ["like.png","like.png","like.png"]
    var owner = ["triquachtriquachtriquachtrasdchtrasdchtrasdchtrasd","quachquachquachquachquac","tritritritritritritri"]
    var phone = ["123","456","789"]
    var address = ["abc","xyx","asd"]
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
            num_section = 3
            return 3
        }
        num_section = 1
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ( section == 0)
        {
            return mang.count
        }
        else if ( section == 1)
        {
            return mang2.count
        }
        return mang3.count
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
        
        
        if ( indexPath.section == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BatDongSanControllerTableViewCell
            cell.myHouse.image = UIImage(named: mang[indexPath.row].image + ".jpg")
            cell.lblGia.text = mang[indexPath.row].gia
            cell.lblDIenTich.text = mang[indexPath.row].dientich
            cell.lblQuan.text = mang[indexPath.row].quan
            cell.lblDate.text = mang[indexPath.row].date
            cell.lblTitle.text = mang[indexPath.row].title
            return cell
        }
        else if ( indexPath.section == 1)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BatDongSanControllerTableViewCell
            cell.myHouse.image = UIImage(named: mang2[indexPath.row].image + ".jpg")
            cell.lblGia.text = mang2[indexPath.row].gia
            cell.lblDIenTich.text = mang2[indexPath.row].dientich
            cell.lblQuan.text = mang2[indexPath.row].quan
            cell.lblDate.text = mang2[indexPath.row].date
            cell.lblTitle.text = mang2[indexPath.row].title
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BatDongSanControllerTableViewCell
        cell.myHouse.image = UIImage(named: mang3[indexPath.row].image + ".jpg")
        cell.lblGia.text = mang3[indexPath.row].gia
        cell.lblDIenTich.text = mang3[indexPath.row].dientich
        cell.lblQuan.text = mang3[indexPath.row].quan
        cell.lblDate.text = mang3[indexPath.row].date
        cell.lblTitle.text = mang3[indexPath.row].title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if ( role == 0)
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabbar = storyboard.instantiateViewController(withIdentifier: "EstateDetailBuyer") as! EstateDetailBuyerController
            tabbar.name_house = estates[indexPath.row]
            //   tabbar.status = temp!
            
            self.navigationController?.pushViewController(tabbar, animated: true)
        }
        else
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabbar = storyboard.instantiateViewController(withIdentifier: "EstateDetailOwner") as! EstateDetailOwnerViewController
            //   tabbar.status = temp!
            
            self.navigationController?.pushViewController(tabbar, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let xoa = UITableViewRowAction(style: .default, title: "xoa") { (action:UITableViewRowAction, index:IndexPath) in
            print ("fuck")
            
            if (index.section == 0)
            {
                self.mang.remove(at: index.row)
                self.myTbv.deleteRows(at: [index], with: .fade)
            }
            else if (index.section == 1)
            {
                self.mang2.remove(at: index.row)
                self.myTbv.deleteRows(at: [index], with: .fade)
            }
            else
            {
                self.mang3.remove(at: index.row)
                self.myTbv.deleteRows(at: [index], with: .fade)
            }
           self.count2 -= 1
            
        }
        
        return [xoa]
    }

    override func viewDidDisappear(_ animated: Bool) {
        var nav = self.navigationController?.navigationBar
        // 2
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.yellow
    }
    
}
