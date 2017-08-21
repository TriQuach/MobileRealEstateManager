//
//  SeemoreViewController.swift
//  Thesis
//
//  Created by Tri Quach on 7/1/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import UIKit

class SeemoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var loading: UIActivityIndicatorView!
    var role:Int! // 0: Quan tâm 1: Quản lý 2: GetNew
    var idUser:Int!
    var mang:[Estate] = []
    var url:String = ""
    var mang3:[Estate] = []
    var mang2:[Estate] = []
    @IBOutlet weak var myTbv: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTbv.dataSource = self
        myTbv.delegate = self
        loading.startAnimating()

        if ( role == 0)
        {
            
            parseJSONgetInterested()
        }
        else if ( role == 1)
        {
            parseJsonGetByOwnerID()
            
        }
        else
        {
            parseJSONGetNew()
        }
       
        
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (role == 0)
        {
            return mang.count
        }
        else if (role == 1)
        {
            return mang3.count
        }
        return mang2.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if (self.role == 0)
        {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SeemoreTableViewCell
        let data:Data = Data(base64Encoded: mang[indexPath.row].image)!
        cell.myHouse.image = UIImage(data: data)
        cell.lblGia.text = String(mang[indexPath.row].gia) + "tỷ"
        cell.lblDIenTich.text = String(mang[indexPath.row].dientich)
        cell.lblQuan.text = mang[indexPath.row].quan
        cell.lblDate.text = mang[indexPath.row].date
        cell.lblTitle.text = mang[indexPath.row].title
        return cell
        
        }
        else if (role == 1)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SeemoreTableViewCell
            
            
            let data:Data = Data(base64Encoded: mang3[indexPath.row].image)!
            cell.myHouse.image = UIImage(data: data)
            
            cell.lblGia.text = String(mang3[indexPath.row].gia) + "tỷ"
            cell.lblDIenTich.text = String(mang3[indexPath.row].dientich)
            cell.lblQuan.text = mang3[indexPath.row].quan
            cell.lblDate.text = mang3[indexPath.row].date
            cell.lblTitle.text = mang3[indexPath.row].title
            
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SeemoreTableViewCell
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
    
    
        func parseJSONgetInterested()
        {
            
            let req = URLRequest(url: URL(string: "http://192.168.1.10:8080/rem/rem_server/user/getInterested/" + String(idUser))!)
            
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
                        
                        
                        
                        let owner = estates[i]["owner"] as!     AnyObject
                        let idOwner = owner["id"] as! Int
                        let new_estate = Estate(ID: id,image: "", title: title, gia: price, dientich: area, quan: district, date: date, idOwner: idOwner)
                        
                        
                        
                        
                        
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
        
        let req = URLRequest(url: URL(string: "http://192.168.1.10:8080/rem/rem_server/estate/getByOwnerID/" + String(idUser))!)
        
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
                    
                    
                    let new_estate = Estate(ID: id,image: "", title: title, gia: price, dientich: area, quan: district, date: date, idOwner: idOwner)
                    
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
    func parseImageGetByOwnerID()
    {
        for i in 0..<mang3.count
        {
            let id = mang3[i].ID
            let req = URLRequest(url: URL(string: "http://192.168.1.10:8080/rem/rem_server/estate/getRepresentPhoto/" + String(id))!)
            
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
    func parseImageInterested()
    {
        
        
        for i in 0..<mang.count
        {
            let id = mang[i].ID
            let req = URLRequest(url: URL(string: "http://192.168.1.10:8080/rem/rem_server/estate/getRepresentPhoto/" + String(id))!)
            
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
    func getJsonEstate()
    {
        
        let req = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: req) { (d, u, e) in
            
            
            do
            {
                
                let json = try JSONSerialization.jsonObject(with: d!, options: .allowFragments) as! AnyObject
                
                let user = json["owner"] as AnyObject
                let email = user["email"] as! String
                let password = user["password"] as! String
                let address = user["address"] as! String
                let typeID = user["typeId"] as! Int
                let fullName = user["fullName"] as! String
                let phone = user["phone"] as! String
                let id = user["id"] as! Int
                let name = user["name"] as! String
                //
                let newUser:User = User(email: email, password: password, address: address, typeID: typeID, fullName: fullName,phone: phone, id: id, name: name, avatar: "")
                
                let detailAddress = json["address"] as AnyObject
                let city = detailAddress["city"] as! String
                let district = detailAddress["district"] as! String
                let ward = detailAddress["ward"] as! String
                let address2 = detailAddress["address"] as! String
                let id2 = detailAddress["id"] as! Int
                
                let newAdress:Address = Address(city: city, district: district, ward: ward, address: address2, id: id2)
                
                let detail = json["detail"] as AnyObject
                let bathroom = detail["bathroom"] as! Int
                let bedroom = detail["bedroom"] as! Int
                let condition = detail["condition"] as! String
                let description = detail["description"] as! String
                let floor = detail["floor"] as! Int
                let length = detail["length"] as! Double
                let width = detail["width"] as! Double
                let longitude = detail["longitude"] as! Double
                let latitude = detail["latitude"] as! Double
                let idDetail = detail["id"] as! Int
                
                let newDetail:Detail = Detail(bathroom: bathroom, bedroom: bedroom, condition: condition, description: description, floor: floor, length: length, width: width, longitude: longitude, latitude: latitude, id: idDetail)
                
                //    print (newDetail.description)
                
                
                
                let available = json["available"] as! Bool
                let type = json["type"] as! String
                let postTime = json["postTime"] as! String
                let price = json["price"] as! Double
                let area = json["area"] as! Double
                let id3 = json["id"] as! Int
                let name3 = json["name"] as! String
                
                let _:FullEstate = FullEstate(owner: newUser, address: newAdress, detail: newDetail, available: available, type: type, postTime: postTime, editTime: "", price: price, area: area, id: id3, name: name3)
                
             //   self.mang.append(newFullEstate)
               
                
                
                
                
                DispatchQueue.main.async(execute: {
                    self.myTbv.delegate = self
                    self.myTbv.dataSource = self
                    self.myTbv.reloadData()
                    
                    
                })
            }catch{}
        }
        task.resume()
        
        
        
        
        
        
    }
    func parseJSONGetNew()
    {
        
        let req = URLRequest(url: URL(string: "http://192.168.1.10:8080/rem/rem_server/estate/getNew/4")!)
        
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
                    let new_estate = Estate(ID: id,image: "", title: title, gia: price, dientich: area, quan: district, date: date, idOwner: idOwner)
                    
                    self.mang2.append(new_estate)
                    
                   
                    
                }
                
                
                DispatchQueue.main.async(execute: {
                    self.myTbv.reloadData()
                    
                    self.parseImageGetNew()
                })
            }catch{}
        }
        task.resume()
    }
    func parseImageGetNew()
    {
        
        
        for i in 0..<mang2.count
        {
            let id = mang2[i].ID
            let req = URLRequest(url: URL(string: "http://192.168.1.10:8080/rem/rem_server/estate/getRepresentPhoto/" + String(id))!)
            
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
                            self.loading.isHidden = true
                            
                            
                        })
                    }
                }catch{}
            }
            task.resume()
        }
        
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabbar = storyboard.instantiateViewController(withIdentifier: "EstateDetailBuyer") as! EstateDetailBuyerController
        
        if (role == 0)
        {
            tabbar.idEstate = mang[indexPath.row].ID
            tabbar.isLogin = true
            tabbar.idUser = self.idUser
        }
        else if ( role == 1)
        {
            tabbar.idEstate = mang3[indexPath.row].ID
            tabbar.isLogin = true
            tabbar.idUser = self.idUser
        }
        else
        {
            tabbar.idEstate = mang2[indexPath.row].ID
            tabbar.isLogin = true
            tabbar.idUser = self.idUser
        }
        self.navigationController?.pushViewController(tabbar, animated: true)
    }

}
