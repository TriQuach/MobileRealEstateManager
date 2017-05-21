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
//    var mang:[Estate] = [Estate(image: "house1", title: "Bán chung cư Cantavil diện tích 80, 2m2 ban công Đông Nam", gia: 123.0, dientich: 80.0, quan: "Quận 2", date: "13/5/2017"),Estate(image: "house2", title: "Bán chung cư Cantavil diện tích 80, 2m2 ban công Đông Nam", gia: 456.6, dientich: 19.0, quan: "Quận 2", date: "13/5/2017"),Estate(image: "house3", title: "Bán chung cư Cantavil diện tích 80, 2m2 ban công Đông Nam", gia: 234.5, dientich: 80, quan: "Quận 2", date: "13/5/2017")]
//    
//    var mang2:[Estate] = [Estate(image: "house4", title: "Bán chung cư Cantavil diện tích 80, 2m2 ban công Đông Nam", gia: 345.9, dientich: 75.8, quan: "Quận 2", date: "13/5/2017"),Estate(image: "house5", title: "Bán chung cư Cantavil diện tích 80, 2m2 ban công Đông Nam", gia: 3456.1, dientich: 90, quan: "Quận 2", date: "13/5/2017"),Estate(image: "house6", title: "Bán chung cư Cantavil diện tích 80, 2m2 ban công Đông Nam", gia: 1234, dientich: 80, quan: "Quận 2", date: "13/5/2017")]
//    
//    var mang3:[Estate] = [Estate(image: "house7", title: "Bán chung cư Cantavil diện tích 80, 2m2 ban công Đông Nam", gia: 215.8, dientich: 100, quan: "Quận 2", date: "13/5/2017"),Estate(image: "house8", title: "Bán chung cư Cantavil diện tích 80, 2m2 ban công Đông Nam", gia: 123.4, dientich: 80, quan: "Quận 2", date: "13/5/2017"),Estate(image: "house9", title: "Bán chung cư Cantavil diện tích 80, 2m2 ban công Đông Nam", gia: 123.6, dientich: 80, quan: "Quận 2", date: "13/5/2017")]
    var mang:[Estate] = []
    var mang2:[Estate] = []
    var mang3:[Estate] = []
    
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
        
       parseJSON()
        
      //  sleep(5)
    parseImage()
     //   print (mang[0].image)
        
        for i in 0..<mang.count
        {
            print ( mang[i].image )
        }
        
        myTbv.dataSource = self
        myTbv.delegate = self
        
        
        
        
        
    }
    func parseJSON()
    {
        let req = URLRequest(url: URL(string: "http://rem-real-estate-manager.1d35.starter-us-east-1.openshiftapps.com/rem/rem_server/estate/getAll")!)
        
        let task = URLSession.shared.dataTask(with: req) { (d, u, e) in
            
            do
            {
                let json = try JSONSerialization.jsonObject(with: d!, options: .allowFragments) as! AnyObject
                let estates = json["estates"] as! [AnyObject]
                for i in 0..<estates.count
                {
                    let id = estates[i]["id"] as! Int
                    
                    let date = estates[i]["postTime"] as! String
                    let title = estates[i]["name"] as! String
                    let price = estates[i]["price"] as! Double
                    let area = estates[i]["area"] as! Double
                    let address = estates[i]["address"] as! AnyObject
                    
                    let district = address["district"]
                        as! String
                    
                    let new_estate = Estate(ID: id,image: "", title: title, gia: price, dientich: area, quan: district, date: date)
                    
                    print (id)
                    self.mang.append(new_estate)
                    self.mang2.append(new_estate)
                    self.mang3.append(new_estate)
                    
                    
                
                }
                self.myTbv.reloadData()
            }catch{}
        }
        task.resume()
    }
    func parseImage()
    {
   //     print (mang[0].gia)
        
        for i in 0..<mang.count
        {
            let id = mang[i].ID
            let req = URLRequest(url: URL(string: "http://rem-real-estate-manager.1d35.starter-us-east-1.openshiftapps.com/rem/rem_server/estate/getRepresentPhoto/" + String(id))!)
            
            let task = URLSession.shared.dataTask(with: req) { (d, u, e) in
                
                do
                {
                    let json = try JSONSerialization.jsonObject(with: d!, options: .allowFragments) as! AnyObject
                    let photo = json["photo"] as! String
                    //print (photo)
                    self.mang[i].image = photo
                    
                 self.myTbv.reloadData()
                }catch{}
            }
            task.resume()
        }
        
        
       
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
            let data:Data = Data(base64Encoded: mang[indexPath.row].image)!
            cell.myHouse.image = UIImage(data: data)
            
            
            
            
            cell.lblGia.text = String(mang[indexPath.row].gia) + "tỷ"
            cell.lblDIenTich.text = String(mang[indexPath.row].dientich)
            cell.lblQuan.text = mang[indexPath.row].quan
            cell.lblDate.text = mang[indexPath.row].date
            cell.lblTitle.text = mang[indexPath.row].title
            return cell
        }
        else if ( indexPath.section == 1)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BatDongSanControllerTableViewCell
            //cell.myHouse.image = UIImage(named: mang2[indexPath.row].image + ".jpg")
            let data:Data = Data(base64Encoded: mang2[indexPath.row].image)!
            cell.myHouse.image = UIImage(data: data)
            cell.lblGia.text = String(mang2[indexPath.row].gia)
            cell.lblDIenTich.text = String(mang2[indexPath.row].dientich)
            cell.lblQuan.text = mang2[indexPath.row].quan
            cell.lblDate.text = mang2[indexPath.row].date
            cell.lblTitle.text = mang2[indexPath.row].title
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BatDongSanControllerTableViewCell
        //cell.myHouse.image = UIImage(named: mang3[indexPath.row].image + ".jpg")
        let data:Data = Data(base64Encoded: mang3[indexPath.row].image)!
        cell.myHouse.image = UIImage(data: data)
        cell.lblGia.text = String(mang3[indexPath.row].gia)
        cell.lblDIenTich.text = String(mang3[indexPath.row].dientich)
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
           // print ("fuck")
            
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
