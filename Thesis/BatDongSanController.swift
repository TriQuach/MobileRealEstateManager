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
    var idUser:Int = 0

    var mang:[Estate] = []
    var mang2:[Estate] = []
    var mang3:[Estate] = []
    
    var mang_id1:[Int] = []
    var mang_id2:[Int] = []
    
    var nameOwner:[String] = []
    var addressOwner:[String] = []
    
    var nameOwner2:[String] = []
    var addressOwner2:[String] = []
    
    
    @IBOutlet weak var imgMore: UIImageView!
    
    var x:CGFloat = 0
    var y:CGFloat = 0
    
    var temp:String = ""
    
    var current_like = false
    var role:Int = 0 // 0: buyer; 1: seller; 2: broker
    
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
        
        loading.startAnimating()
        
       
        loadAfterGetAll()
        
        
       
   //     print (x.listEstates[0].address)
        
    //    parseJSONGetTopRate()
        
        
        //sleep(5)
   // parseImage()
     //   print (mang[0].image)
        
        
       
        
        
        
        
        
    }
    
    func loadAfterGetAll()
    {
        do {
            let data = try String(contentsOfFile: "/Users/triquach/Documents/token.txt", encoding: .utf8)
            
            isLogin = true
            
            parseJsonToken(token: data)
            print ("idUser:" + String(idUser))
            
            
            
            
        } catch {
            //            print("2")
            //            self.window = UIWindow(frame: UIScreen.main.bounds)
            //
            //            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //
            //            let initialViewController = storyboard.instantiateViewController(withIdentifier: "start")
            //
            //            self.window?.rootViewController = initialViewController
            //            self.window?.makeKeyAndVisible()
            
            myTbv.dataSource = self
            myTbv.delegate = self
        }
        
        
        
        
        parseJSONGetNew()
        
        
        if ( isLogin )
        {
            var secondTab = self.tabBarController?.viewControllers?[2] as! CuocHenController
            secondTab.idUser = idUser
            secondTab.role = self.role
        }
    }
    
    func parseJsonToken(token: String)
    {
        print ("1")
        
        let url = "http://rem-real-estate-manager.1d35.starter-us-east-1.openshiftapps.com/rem/rem_server/user/login/" + token
        print (url)
        let req = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: req) { (d, u, e) in
            
            do
            {
                print ("error:")
                print (e)
                let json = try JSONSerialization.jsonObject(with: d!, options: .allowFragments) as! AnyObject
                
                
                if (json["statuskey"] as! Bool)
                {
                    let typeId = json["typeId"] as! Int
                    let id = json["id"] as! Int
                    
                    print (typeId)
                    
                    DispatchQueue.main.async {
                        
                        if ( typeId == 1)
                        {
                            self.role = 0
                            self.idUser = id
                            self.parseJSONgetInterested()
                            self.myTbv.dataSource = self
                            self.myTbv.delegate = self
                            var secondTab = self.tabBarController?.viewControllers?[2] as! CuocHenController
                            secondTab.idUser = self.idUser
                            secondTab.role = 0
                            
                        }
                        else if ( typeId == 2)
                        {
                            self.role = 1
                            self.idUser = id
                            self.parseJsonGetByOwnerID()
                            self.myTbv.dataSource = self
                            self.myTbv.delegate = self
                            var secondTab = self.tabBarController?.viewControllers?[2] as! CuocHenController
                            secondTab.idUser = self.idUser
                            secondTab.role = 1
                        }
                        
                        
                        //
                        
                        
                        
                        
                    }
                }
                else
                {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Alert", message: json["message"] as! String, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        self.loading.stopAnimating()
                        self.loading.isHidden = true
                    }
                }
                
                
            }catch{
                print ("catch:")
                print (error)
                
            }
        }
        task.resume()
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
                    let address2 = detailAddress["address"] as! String
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
                    self.loadAfterGetAll()
                   // print ( self.newEstates.statuskey)
                }
                
             //   Estates.statuskey = statuskey
                
                
                
            }catch{}
        }
        task.resume()
        
        
        
       }
    func parseJSONGetNew()
    {
       
        let req = URLRequest(url: URL(string: "http://rem-real-estate-manager.1d35.starter-us-east-1.openshiftapps.com/rem/rem_server/estate/getNew/4")!)
        
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
                 
                    let owner = estates[i]["owner"] as! AnyObject
                    let idOwner = owner["id"] as! Int
                    self.mang_id2.append(idOwner)
                    
                    self.mang2.append(new_estate)
                   
                    self.nameOwner2.append(owner["fullName"] as! String)
                    self.addressOwner2.append(owner["address"] as! String)
                
                }
                
                
                DispatchQueue.main.async(execute: {
                    self.myTbv.reloadData()
                    
                    self.parseImageGetNew()
                })
            }catch{}
        }
        task.resume()
    }
    
    func parseJSONgetInterested()
    {
       
        let req = URLRequest(url: URL(string: "http://rem-real-estate-manager.1d35.starter-us-east-1.openshiftapps.com/rem/rem_server/user/getInterested/" + String(idUser))!)
        
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
                    
                    let owner = estates[i]["owner"] as! AnyObject
                    let idOwner = owner["id"] as! Int
                    self.mang_id1.append(idOwner)
                    self.nameOwner.append(owner["fullName"] as! String)
                    self.addressOwner.append(owner["address"] as! String)
                    
                    
                    
                    
                  
                    self.mang.append(new_estate)
                    
                                 }
                
                
                DispatchQueue.main.async(execute: {
                    self.myTbv.reloadData()
                    
                    self.parseImageInterested()
                 //   self.parseImage()
                })
            }catch{}
        }
        task.resume()
    }
    func parseJsonGetByOwnerID()
    {
        
        let req = URLRequest(url: URL(string: "http://rem-real-estate-manager.1d35.starter-us-east-1.openshiftapps.com/rem/rem_server/estate/getByOwnerID/" + String(idUser))!)
        
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
                    
                    let owner = estates[i]["owner"] as! AnyObject
                    let idOwner = owner["id"] as! Int
                   
                    
                    let new_estate = Estate(ID: id,image: "", title: title, gia: price, dientich: area, quan: district, date: date)
                    
                    // print (id)
                    //  self.mang.append(new_estate)
                    self.mang3.append(new_estate)
                    
                    //  self.mang3.append(new_estate)
                    
                    
                    
                }
                
                for i in 0..<self.mang3.count{
                    print (self.mang3[i].quan)
                }
                
                
                DispatchQueue.main.async(execute: {
                    self.myTbv.reloadData()
                    self.parseImageGetByOwnerID()
                    //self.parseImageInterested()
                    //   self.parseImage()
                })
            }catch{}
        }
        task.resume()
    }
    
    func parseImageInterested()
    {
  
        
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
    func parseImageGetByOwnerID()
    {
        for i in 0..<mang3.count
        {
            let id = mang3[i].ID
            let req = URLRequest(url: URL(string: "http://rem-real-estate-manager.1d35.starter-us-east-1.openshiftapps.com/rem/rem_server/estate/getRepresentPhoto/" + String(id))!)
            
            let task = URLSession.shared.dataTask(with: req) { (d, u, e) in
                
                do
                {
                    
                    let json = try JSONSerialization.jsonObject(with: d!, options: .allowFragments) as! AnyObject
                    if (json["statuskey"] as! Bool)
                    {
                        let photo = json["photo"] as! String
                        //print (photo)
                        
                        self.mang3[i].image = photo
                        
                        
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
    func parseImageGetNew()
    {
        
        
        for i in 0..<mang2.count
        {
            let id = mang2[i].ID
            let req = URLRequest(url: URL(string: "http://rem-real-estate-manager.1d35.starter-us-east-1.openshiftapps.com/rem/rem_server/estate/getRepresentPhoto/" + String(id))!)
            
            let task = URLSession.shared.dataTask(with: req) { (d, u, e) in
                
                do
                {
                    
                    let json = try JSONSerialization.jsonObject(with: d!, options: .allowFragments) as! AnyObject
                    if (json["statuskey"] as! Bool)
                    {
                        let photo = json["photo"] as! String
                        //print (photo)
                        
                        self.mang2[i].image = photo
                        
                        
                        DispatchQueue.main.async(execute: {
                            self.myTbv.reloadData()
                            
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
            return 2
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        
        if ( role == 0)
        {
            if ( section == 0)
            {
                if ( !isLogin )
                {
                    return 1
                }
                return mang.count
            }
            
                return mang2.count
           
            
        }
        if ( section == 0)
        {
            if (!isLogin)
            {
                return 1
            }
            return mang3.count
        }
        
            return mang2.count
        
       
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
        
                return "Bất động sản mới nhất"
            
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if ( role == 0)
        {
            if ( indexPath.section == 0)
            {
                if (isLogin)
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
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell3") as! ChuaLogInBuyerTableViewCell
                
                
              
                
                return cell
                
                
                
            }
            
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
        
       
       
        if ( indexPath.section == 0)
        {
            if (!isLogin)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell2")
                return cell!
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BatDongSanControllerTableViewCell
            
            
            let data:Data = Data(base64Encoded: mang3[indexPath.row].image)!
            cell.myHouse.image = UIImage(data: data)
            
            cell.lblGia.text = String(mang3[indexPath.row].gia) + "tỷ"
            cell.lblDIenTich.text = String(mang3[indexPath.row].dientich)
            cell.lblQuan.text = mang3[indexPath.row].quan
            cell.lblDate.text = mang3[indexPath.row].date
            cell.lblTitle.text = mang3[indexPath.row].title
            
            return cell
            
        }
      
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if ( role == 0)
        {
            if ( indexPath.section == 0)
            {
                if (!isLogin)
                {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let tabbar = storyboard.instantiateViewController(withIdentifier: "login") as! LogInViewController
                    
                    tabbar.storyboardID = "EstateDetailBuyer"
                    self.navigationController?.pushViewController(tabbar, animated: true)
                }
                else
                {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let tabbar = storyboard.instantiateViewController(withIdentifier: "EstateDetailBuyer") as! EstateDetailBuyerController
                    tabbar.idOwner = mang_id1[indexPath.row]
                    tabbar.idEstate = mang[indexPath.row].ID
                    tabbar.idUser = idUser
                    tabbar.passEstate = mang[indexPath.row]
                    tabbar.passOwner = nameOwner[indexPath.row]
                    tabbar.passAdress = addressOwner[indexPath.row]
                    
                   
                    
                    
                    self.navigationController?.pushViewController(tabbar, animated: true)
                }
            }
            else
            {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let tabbar = storyboard.instantiateViewController(withIdentifier: "EstateDetailBuyer") as! EstateDetailBuyerController
                tabbar.idOwner = mang_id2[indexPath.row]
                tabbar.idEstate = mang2[indexPath.row].ID
                tabbar.idUser = idUser
                //   tabbar.status = temp!
                tabbar.passEstate = mang2[indexPath.row]
                tabbar.passOwner = nameOwner2[indexPath.row]
                tabbar.passAdress = addressOwner2[indexPath.row]
                
                
                self.navigationController?.pushViewController(tabbar, animated: true)
            }
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
                    let tabbar = storyboard.instantiateViewController(withIdentifier: "EstateDetailOwner") as! EstateDetailOwnerViewController
                    
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
