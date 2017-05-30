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
    
    var isLogin:Bool = false
    
    var count2 = 3
    var count:Int = 0
    var num_section:Int = 0
    
    var passedObject:Estates!
    

    var mang:[Estate] = []
    var mang2:[Estate] = []
    var mang3:[Estate] = []
    
    
    @IBOutlet weak var imgMore: UIImageView!
    
    var x:CGFloat = 0
    var y:CGFloat = 0
    
    var temp:String = ""
    
    var current_like = false
    var role:Int? // 0: buyer; 1: seller; 2: broker
    
    var test:String?
    var newEstates:Estates!
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var myTbv: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       // lblRole.text = temp
        self.navigationItem.title = "Bất động sản"

        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imgMoreTapped))
        imgMore.isUserInteractionEnabled = true
        imgMore.addGestureRecognizer(tap)
        
        loading.color = .black
        
        loading.isHidden = true
        
        parseUser(url: "http://rem-real-estate-manager.1d35.starter-us-east-1.openshiftapps.com/rem/rem_server/estate/getAll")
       
   //     print (x.listEstates[0].address)
       parseJSON()
        
        //sleep(5)
   // parseImage()
     //   print (mang[0].image)
        
        
        myTbv.dataSource = self
        myTbv.delegate = self
        
        
        
        
    }
    
    func parseUser(url: String)
    {
        var listFullEstates:[FullEstate] = []
      //  var newEstates:Estates!
        
        let req = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: req) { (d, u, e) in
            
            do
            {
                let json = try JSONSerialization.jsonObject(with: d!, options: .allowFragments) as AnyObject
                let listEstates = json["estates"] as! [AnyObject]
                for i in 0..<listEstates.count
                {
                    let user = listEstates[i]["owner"] as AnyObject
                    let email = user["email"] as! String
                    let password = user["password"] as! String
                    let address = user["address"] as! String
                    let typeID = user["typeId"] as! Int
                    let fullName = user["fullName"] as! String
                    let phone = user["phone"] as! String
                    let id = user["id"] as! Int
                    let name = user["name"] as! String
//
                    let newUser:User = User(email: email, password: password, address: address, typeID: typeID, fullName: fullName,phone: phone, id: id, name: name)
                    
                    let detailAddress = listEstates[i]["address"] as AnyObject
                    let city = detailAddress["city"] as! String
                    let district = detailAddress["district"] as! String
                    let ward = detailAddress["ward"] as! String
                    let address2 = detailAddress["city"] as! String
                    let id2 = detailAddress["id"] as! Int
                    
                    let newAdress:Address = Address(city: city, district: district, ward: ward, address: address2, id: id2)
                    
                    let detail = listEstates[i]["detail"] as AnyObject
                    let bathroom = detail["bathroom"] as! Int
                    let bedroom = detail["bedroom"] as! Int
                    let condition = detail["condition"] as! String
                    let description = detail["description"] as! String
                    let floor = detail["floor"] as! Int
                    let length = detail["length"] as! Double
                    let width = detail["width"] as! Double
                    let idDetail = detail["id"] as! Int
                    
                    let newDetail:Detail = Detail(bathroom: bathroom, bedroom: bedroom, condition: condition, description: description, floor: floor, length: length, width: width, id: id)
                    
               //    print (newDetail.description)
                    
                    
                    
                    let available = listEstates[i]["available"] as! Bool
                    let type = listEstates[i]["type"] as! String
                    let postTime = listEstates[i]["postTime"] as! String
                    let price = listEstates[i]["price"] as! Double
                    let area = listEstates[i]["area"] as! Double
                    let id3 = listEstates[i]["id"] as! Int
                    let name3 = listEstates[i]["name"] as! String
                    
                    let newFullEstate:FullEstate = FullEstate(owner: newUser, address: newAdress, detail: newDetail, available: available, type: type, postTime: postTime, price: price, area: area, id: id3, name: name3)
                    
                    
                    
                    
                  //  print (newFullEstate.address.street)
                    listFullEstates.append(newFullEstate)
                  //  print (listFullEstates[i].detail.floor)
                    
                    
                    

                }
                let statuskey = json["statuskey"] as! Bool
               // print (listFullEstates[1].postTime)
                DispatchQueue.main.async {
                      self.newEstates = Estates(listEstates: listFullEstates, statuskey: statuskey)
                   // print ( self.newEstates.statuskey)
                }
                
             //   Estates.statuskey = statuskey
                
                
                
            }catch{}
        }
        task.resume()
        
        
        
       }
    func parseJSON()
    {
        self.loading.isHidden = false
        self.loading.startAnimating()
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
                    
                   // print (id)
                    self.mang.append(new_estate)
                    self.mang2.append(new_estate)
                    self.mang3.append(new_estate)
                    
                    
                
                }
                
                
                DispatchQueue.main.async(execute: {
                    self.myTbv.reloadData()
                    self.parseImage()
                })
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
                    if (json["statuskey"] as! Bool)
                    {
                    let photo = json["photo"] as! String
                    //print (photo)
                    self.mang[i].image = photo
                
                    
                    DispatchQueue.main.async(execute: {
                        self.myTbv.reloadData()
                        self.loading.stopAnimating()
                        self.loading.isHidden = true
                    })
                    }
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
            return 3
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if ( section == 0)
//        {
//            if ( !isLogin )
//            {
//                return 1
//            }
//            return mang.count
//        }
//        else if ( section == 1)
//        {
//            return mang2.count
//        }
//        return mang3.count
        
        if ( role == 0)
        {
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
        if ( section == 0)
        {
            if (!isLogin)
            {
                return 1
            }
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
        
            if (section == 0)
            {
                return "Bất động sản đang quản lý"
            }
            else if (section == 1)
            {
                return "Bất động sản mới nhất"
            }
            return "Bất động sản được quan tâm nhiều"
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
//        if ( indexPath.section == 0)
//        {
//            
//            
//            if ( isLogin )
//            {
//                let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BatDongSanControllerTableViewCell
//                
//                
//                let data:Data = Data(base64Encoded: mang[indexPath.row].image)!
//                cell.myHouse.image = UIImage(data: data)
//                
//                cell.lblGia.text = String(mang[indexPath.row].gia) + "tỷ"
//                cell.lblDIenTich.text = String(mang[indexPath.row].dientich)
//                cell.lblQuan.text = mang[indexPath.row].quan
//                cell.lblDate.text = mang[indexPath.row].date
//                cell.lblTitle.text = mang[indexPath.row].title
//                
//                return cell
//            }
//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2")
//            return cell!
//  
//            
//        }
//        else if ( indexPath.section == 1)
//        {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BatDongSanControllerTableViewCell
//            //cell.myHouse.image = UIImage(named: mang2[indexPath.row].image + ".jpg")
//            let data:Data = Data(base64Encoded: mang2[indexPath.row].image)!
//            cell.myHouse.image = UIImage(data: data)
//            cell.lblGia.text = String(mang2[indexPath.row].gia)
//            cell.lblDIenTich.text = String(mang2[indexPath.row].dientich)
//            cell.lblQuan.text = mang2[indexPath.row].quan
//            cell.lblDate.text = mang2[indexPath.row].date
//            cell.lblTitle.text = mang2[indexPath.row].title
//            return cell
//        }
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BatDongSanControllerTableViewCell
//        //cell.myHouse.image = UIImage(named: mang3[indexPath.row].image + ".jpg")
//        let data:Data = Data(base64Encoded: mang3[indexPath.row].image)!
//        cell.myHouse.image = UIImage(data: data)
//        cell.lblGia.text = String(mang3[indexPath.row].gia)
//        cell.lblDIenTich.text = String(mang3[indexPath.row].dientich)
//        cell.lblQuan.text = mang3[indexPath.row].quan
//        cell.lblDate.text = mang3[indexPath.row].date
//        cell.lblTitle.text = mang3[indexPath.row].title
//        return cell
        
        if ( role == 0)
        {
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
                //cell.myHouse.image = UIImage(named: zzzsmang2[indexPath.row].image + ".jpg")
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
        if ( indexPath.section == 0)
        {
            if (!isLogin)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell2")
                return cell!
            }
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
        
        
//        if (indexPath.section == 0)
//        {
//            if ( !isLogin )
//            {
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let tabbar = storyboard.instantiateViewController(withIdentifier: "login") as! LogInViewController
//                
//                tabbar.storyboardID = "BDS"
//                self.navigationController?.pushViewController(tabbar, animated: true)
//            }
//            else
//            {
//                if ( role == 0)
//                {
//                    
//                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                    let tabbar = storyboard.instantiateViewController(withIdentifier: "EstateDetailBuyer") as! EstateDetailBuyerController
//                    tabbar.passObject = newEstates
//                    //   tabbar.status = temp!
//                    
//                    self.navigationController?.pushViewController(tabbar, animated: true)
//                }
//                else
//                {
//                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                    let tabbar = storyboard.instantiateViewController(withIdentifier: "EstateDetailOwner") as! EstateDetailOwnerViewController
//                    //   tabbar.status = temp!
//                    
//                    self.navigationController?.pushViewController(tabbar, animated: true)
//                }
//            }
//            
//        }
//        else
//        {
//            if ( role == 0)
//            {
//                
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let tabbar = storyboard.instantiateViewController(withIdentifier: "EstateDetailBuyer") as! EstateDetailBuyerController
//                tabbar.passObject = newEstates
//                //   tabbar.status = temp!
//                
//                self.navigationController?.pushViewController(tabbar, animated: true)
//            }
//            else
//            {
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let tabbar = storyboard.instantiateViewController(withIdentifier: "EstateDetailOwner") as! EstateDetailOwnerViewController
//                //   tabbar.status = temp!
//                
//                self.navigationController?.pushViewController(tabbar, animated: true)
//            }
//        }

        
        
        
        if ( role == 0)
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabbar = storyboard.instantiateViewController(withIdentifier: "EstateDetailBuyer") as! EstateDetailBuyerController
            tabbar.passObject = newEstates
            //   tabbar.status = temp!
            
            self.navigationController?.pushViewController(tabbar, animated: true)
        }
        
        else
        {
            if (indexPath.section == 0)
            {
                if (!isLogin)
                {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let tabbar = storyboard.instantiateViewController(withIdentifier: "login") as! LogInViewController
                    
                    tabbar.storyboardID = "BDS"
                    self.navigationController?.pushViewController(tabbar, animated: true)
                }
                else
                {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let tabbar = storyboard.instantiateViewController(withIdentifier: "EstateDetailOwner") as! EstateDetailOwnerController
                    
                    self.navigationController?.pushViewController(tabbar, animated: true)
                }
            }
            else
            {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let tabbar = storyboard.instantiateViewController(withIdentifier: "EstateDetailOwner") as! EstateDetailOwnerViewController
                
                self.navigationController?.pushViewController(tabbar, animated: true)
            }
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
    
    
    override func viewDidAppear(_ animated: Bool) {
        var nav = self.navigationController?.navigationBar
        // 2
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.yellow
        // 3
        
        // 5
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "edit3.png"), style: .done, target: self, action: #selector(DangBai))
        
        
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        // 4
        let image = UIImage(named: "swift2.png")
        imageView.image = image
        navigationItem.titleView = imageView
    }
    func DangBai()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabbar = storyboard.instantiateViewController(withIdentifier: "DangBai") as! DangBaiViewController
        self.navigationController?.pushViewController(tabbar, animated: true)
    }

    
    
    
}
