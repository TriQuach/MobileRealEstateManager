//
//  CaiDatController.swift
//  Thesis
//
//  Created by TriQuach on 4/4/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
import UIKit

class CaiDatController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    var mang:[String] = ["Tài khoản","Lịch sử","Tác giả", "Liên hệ", "Feedback", "Rate","Đăng xuất"]
    var idUser:Int = 0
    var newUser:User!
    var isLogin:Bool!
    var role:Int!
    @IBOutlet weak var myTbv: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        do {
            let data = try String(contentsOfFile: "/Users/triquach/Documents/token.txt", encoding: .utf8)
            
            isLogin = true
            
            parseJsonToken(token: data)
            
            
            
            
        } catch {
            myTbv.dataSource = self
            myTbv.delegate = self
            isLogin = false
            login()
            mang[mang.count-1] = "Đăng nhập"
        }
        
        
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
            
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    func parseJsonToken(token: String)
    {
        
        let url = "http://35.189.190.170/rem/rem_server/user/login/" + token
        print (url)
        let req = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: req) { (d, u, e) in
            
            do
            {
                
                let json = try JSONSerialization.jsonObject(with: d!, options: .allowFragments) as! AnyObject
                
                let email = json["email"] as! String
                let password = json["password"] as! String
                let address = json["address"] as! String
                let fullName = json["fullName"] as! String
                let phone = json["phone"] as! String
                let name = json["name"] as! String
                let typeId = json["typeId"] as! Int
                let id = json["id"] as! Int
                let avatar = json["avatar"] as! String
                 let user:User = User(email: email, password: password, address: address, typeID: typeId, fullName: fullName, phone: phone, id: id, name: name, avatar: avatar)
                
                DispatchQueue.main.async {
                    
                    self.myTbv.dataSource = self
                    self.myTbv.delegate = self
                    self.myTbv.reloadData()
                    
                    self.idUser = id
                    self.newUser = user
                    if (typeId == 1)
                    {
                        self.role = 0
                    }
                    else if (typeId == 2)
                    {
                        self.role = 1
                    }
                    //
                    
                    
                    
                    
                }
            }catch{}
        }
        task.resume()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mang.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CaiDatTableViewCell
        cell.myLbl.text = mang[indexPath.row]
        if ( indexPath.row == mang.count - 1)
        {
            cell.myLbl.textColor = .red
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if ( indexPath.row == mang.count - 1)
        {
            let check = "true"
            do
            {
                try check.write(toFile: "/Users/triquach/Documents/check.txt", atomically: false, encoding: .utf8)
            }catch{}
            
            let alertController = UIAlertController(title: "Thông báo", message: "Bạn chắc chắn muốn đăng xuất? ", preferredStyle: .alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: "Đăng xuất", style: UIAlertActionStyle.default) {
                UIAlertAction in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let tabbar = storyboard.instantiateViewController(withIdentifier: "login") as! LogInViewController
                tabbar.storyboardID = "LogOut"
                self.navigationController?.pushViewController(tabbar, animated: true)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
                UIAlertAction in
                NSLog("Cancel Pressed")
            }
            
            // Add the actions
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            // Present the controller
            self.present(alertController, animated: true, completion: nil)
            
            
            
            
            
        }
        else if ( indexPath.row == 1 || indexPath.row == 5 )
        {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Thông báo", message: "Chức năng đang phát triển", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
            
        }
        else if ( indexPath.row == 0 )
        {
            if (!isLogin)
            {
                login()
               
            }
            else
            {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let tabbar = storyboard.instantiateViewController(withIdentifier: "CaiDatTaiKhoanViewController") as! CaiDatTaiKhoanViewController
                
                tabbar.user = newUser
                tabbar.role = self.role
                
                
                self.navigationController?.pushViewController(tabbar, animated: true)
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        
        return (self.view.frame.height / 9)
    }
    
    @IBAction func btnLogOut(_ sender: Any) {
        
        let check = "true"
        do
        {
            try check.write(toFile: "/Users/triquach/Documents/check.txt", atomically: false, encoding: .utf8)
        }catch{}
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabbar = storyboard.instantiateViewController(withIdentifier: "login") as! LogInViewController
        tabbar.storyboardID = "LogOut"
        self.navigationController?.pushViewController(tabbar, animated: true)
        
    }
    
    
}
