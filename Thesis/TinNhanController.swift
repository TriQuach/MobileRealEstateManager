//
//  TinNhanController.swift
//  Thesis
//
//  Created by TriQuach on 4/4/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
import UIKit

class TinNhanController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var lblTest: UILabel!
    var message:String!
    var mang:[Noti] = []
    @IBOutlet weak var myTbv: UITableView!
    var temp:String?
    var idUser:Int = 0
    var role:Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Thông báo"
        myTbv.dataSource = self
        myTbv.delegate = self
        loading.startAnimating()
        if (idUser==0)
        {
            
            do {
                let data = try String(contentsOfFile: "/Users/triquach/Documents/token.txt", encoding: .utf8)
                
                
                
                parseJsonToken(token: data)
                
                
                
                
            } catch {
                login()
            }
            
            
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mang.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
        "cell") as! TinNhanTableViewCell
        if (mang[indexPath.row].typeNoti == 1)
        {
            cell.lblMessage.text = "Yêu cầu cập nhập đã bán bất động sản " + mang[indexPath.row].nameEstate + " bởi người dùng " + mang[indexPath.row].userFullName
            self.message = "Yêu cầu cập nhập đã bán bất động sản " + mang[indexPath.row].nameEstate + " bởi người dùng " + mang[indexPath.row].userFullName
        }
        else if (mang[indexPath.row].typeNoti == 2)
        {
            cell.lblMessage.text = "Người dùng " + mang[indexPath.row].userFullName + " hỏi về BĐS " + mang[indexPath.row].nameEstate
        }
        let data:Data = Data(base64Encoded: mang[indexPath.row].avatar)!
        cell.myImg.image = UIImage(data: data)
        
        cell.myImg.layer.borderWidth = 1
        cell.myImg.layer.masksToBounds = false
        cell.myImg.layer.borderColor = UIColor.black.cgColor
        cell.myImg.layer.cornerRadius = cell.myImg.frame.height/2
        cell.myImg.clipsToBounds = true
        
        
        return cell
    }
    func getNotiList()
    {
        let req = URLRequest(url: URL(string: "http://35.194.220.127/rem/rem_server/user/getNoti/" + String(idUser))!)
        
        let task = URLSession.shared.dataTask(with: req) { (d, u, e) in
            
            
            do
            {
                
                let json = try JSONSerialization.jsonObject(with: d!, options: .allowFragments) as! AnyObject
                if (json["statuskey"] as! Bool)
                {
                    let notifications = json["notifications"] as! [AnyObject]
                    for i in 0..<notifications.count
                    {
                        let estate = notifications[i]["estate"] as! AnyObject
                        let name = estate["name"] as! String
                        let idEstate = estate["id"] as! Int
                        let user = notifications[i]["user"] as! AnyObject
                        let fullname = user["fullName"] as! String
                        let avatar = user["avatar"] as! String
                        let idNoti = notifications[i]["id"] as! Int
                        let requestUser = notifications[i]["requestUser"] as! AnyObject
                        let requestUserId = requestUser["id"] as! Int
                        let notiType = notifications[i]["notiType"] as! Int
                        let newNoti:Noti = Noti(nameEstate: name, userFullName: fullname, avatar: avatar, idNoti: idNoti, idRequestUser: requestUserId, idEstate: idEstate, typeNoti: notiType)
                        self.mang.append(newNoti)
                    }
                    DispatchQueue.main.async {
                        self.loading.isHidden = true
                        self.myTbv.reloadData()
                    }
                }
                else
                {
                    let alert = UIAlertController(title: "Lỗi", message: json["message"] as! String, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                
                
            }catch{}
        }
        task.resume()
    }
    func parseJsonToken(token: String)
    {
        print ("1")
        
        let url = "http://35.194.220.127/rem/rem_server/user/login/" + token
        print (url)
        let req = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: req) { (d, u, e) in
            
            do
            {
                
                let json = try JSONSerialization.jsonObject(with: d!, options: .allowFragments) as! AnyObject
                
                let typeId = json["typeId"] as! Int
                let id = json["id"] as! Int
                
                print (typeId)
                
                DispatchQueue.main.async {
                    
                    self.idUser = id
                    self.getNotiList()
                    if ( typeId == 1)
                    {
                        self.role = 0
                        
                        
                    }
                    else if ( typeId == 2)
                    {
                        self.role = 1
                        
                    }
                    //
                    
                    
                    
                    
                }
            }catch{}
        }
        task.resume()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (mang[indexPath.row].typeNoti == 1)
        {
            let alertController = UIAlertController(title: "Thông báo", message: self.message, preferredStyle: .alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: "Chấp nhận", style: UIAlertActionStyle.default) {
                UIAlertAction in
                self.loading.isHidden = false
                self.loading.startAnimating()
                self.deleNoti(notiID: self.mang[indexPath.row].idNoti, idEstate: self.mang[indexPath.row].idEstate)
            }
            let cancelAction = UIAlertAction(title: "Từ chối", style: UIAlertActionStyle.cancel) {
                UIAlertAction in
                self.loading.isHidden = false
                self.loading.startAnimating()
                self.reportSpam(idRequest: self.mang[indexPath.row].idRequestUser, idNoti: self.mang[indexPath.row].idNoti)
            }
            
            // Add the actions
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            // Present the controller
            self.present(alertController, animated: true, completion: nil)
        }
        else if (mang[indexPath.row].typeNoti == 2)
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let timkiem = storyboard.instantiateViewController(withIdentifier: "EstateDetailBuyer") as! EstateDetailBuyerController
            timkiem.idUser = idUser
            timkiem.isLogin = true
            timkiem.idEstate = mang[indexPath.row].idEstate
            timkiem.idOwner = mang[indexPath.row].idRequestUser
            timkiem.role = role
            self.navigationController?.pushViewController(timkiem, animated: true)
        }
    }
    func reportSpam(idRequest:Int, idNoti:Int)
    {
        let req = URLRequest(url: URL(string: "http://35.194.220.127/rem/rem_server/user/reportSpam/"  + String(idRequest) + "-" + String(idNoti))!)
        
        let task = URLSession.shared.dataTask(with: req) { (d, u, e) in
            
            
            do
            {
                
                let json = try JSONSerialization.jsonObject(with: d!, options: .allowFragments) as! AnyObject
                if (json["statuskey"] as! Bool)
                {
                    DispatchQueue.main.async {
                        
                        let alert = UIAlertController(title: "Thông báo", message: json["message"] as! String, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        self.mang = []
                        self.myTbv.reloadData()
                        self.getNotiList()
                    }
                }
                else
                {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Lỗi", message: json["message"] as! String, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                
                
            }catch{}
        }
        task.resume()
    }
    func deleNoti(notiID: Int, idEstate: Int)
    {
        let req = URLRequest(url: URL(string: "http://35.194.220.127/rem/rem_server/user/deleteNoti/"  + String(notiID))!)
        
        let task = URLSession.shared.dataTask(with: req) { (d, u, e) in
            
            
            do
            {
                
                let json = try JSONSerialization.jsonObject(with: d!, options: .allowFragments) as! AnyObject
                if (json["statuskey"] as! Bool)
                {
                    DispatchQueue.main.async {
                        self.mang = []
                        self.myTbv.reloadData()
                        self.getNotiList()
                        self.updateStatus(idEstate: idEstate, status: 2)
                        let alert = UIAlertController(title: "Thông báo", message: json["message"] as! String, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                else
                {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Lỗi", message: json["message"] as! String, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                
                
            }catch{}
        }
        task.resume()
    }
    func updateStatus(idEstate:Int, status: Int)
    {
        let req = URLRequest(url: URL(string: "http://35.194.220.127/rem/rem_server/user/updateStatus/"  + String(idEstate) + "-" + String(status))!)
        
        let task = URLSession.shared.dataTask(with: req) { (d, u, e) in
            
            
            do
            {
                
                let json = try JSONSerialization.jsonObject(with: d!, options: .allowFragments) as! AnyObject
                if (json["statuskey"] as! Bool)
                {
                    DispatchQueue.main.async {
                        
                        let alert = UIAlertController(title: "Thông báo", message: json["message"] as! String, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        self.loading.isHidden = true
                        
                    }
                }
                else
                {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Lỗi", message: json["message"] as! String, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                
                
            }catch{}
        }
        task.resume()
    }
    func login()
    {
        let alertController = UIAlertController(title: "Thông báo", message: "Bạn chưa đăng nhập", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "Đăng nhập", style: UIAlertActionStyle.default) {
            UIAlertAction in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabbar = storyboard.instantiateViewController(withIdentifier: "login") as! LogInViewController
            
            tabbar.storyboardID = "EstateDetailBuyer"
            self.navigationController?.pushViewController(tabbar, animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            self.loading.isHidden = true
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    
}
