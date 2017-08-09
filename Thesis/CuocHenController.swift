//
//  CuocHenController.swift
//  Thesis
//
//  Created by TriQuach on 4/4/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
class CuocHenController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var myTbv: UITableView!
    @IBOutlet weak var lblTest: UILabel!
    
    var mang:[SimpleAppointment] = []
    var numBadge:Int = 0
    var idUser:Int = 0
    var temp:Int?
    var role:Int!
    var idEstate:Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        myTbv.dataSource = self
        myTbv.delegate = self
        
        print ("iduser")
        print (idUser)
        
        loading.color = .black
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
        else
        {
            parseJosnGetAll()
        }
        let rightButtonItem = UIBarButtonItem.init(
            title: "Title",
            style: .done,
            target: self,
            action: "rightButtonAction:"
        )
        
        self.navigationItem.rightBarButtonItem = rightButtonItem
        
        
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
    func parseJosnGetAll()
    {
        
        
        let req = URLRequest(url: URL(string: "http://35.194.220.127/rem/rem_server/appointment/getAll/" + String(idUser))!)
        
        let task = URLSession.shared.dataTask(with: req) { (d, u, e) in
            
            do
            {
                
                let json = try JSONSerialization.jsonObject(with: d!, options: .allowFragments) as! AnyObject
                
                let appointments = json["appointments"] as! [AnyObject]
                for i in 0..<appointments.count
                {
                    let address = appointments[i]["address"] as! String
                    let name = appointments[i]["name"] as! String
                    let time = appointments[i]["time"] as! String
                    let status = appointments[i]["status"] as! Int
                    let note = appointments[i]["note"] as! String
                    let id  = appointments[i]["id"] as! Int
                    let estate = appointments[i]["estate"] as! Int
                    let user1 = appointments[i]["user1"] as! AnyObject
                    
                    let newUser1Name = user1["fullName"] as! String
                    
                    let user2 = appointments[i]["user2"] as! AnyObject
                    
                    let newUser2Name = user2["fullName"] as! String
                    
                    
                    
                    let newSimpleAppointment:SimpleAppointment = SimpleAppointment(address: address, time: time, status: status, name: name, user1: newUser1Name, user2: newUser2Name, note: note, estate: estate, id: id)
     
                    
                    self.mang.append(newSimpleAppointment)
                    
                //    self.mang2.append(new_estate)
                    
                    
                }
                
              
                
                
                DispatchQueue.main.async(execute: {
                    self.myTbv.reloadData()
                    self.getBadge()
                    let tabItems = self.tabBarController?.tabBar.items as NSArray!
                    let tabItem = tabItems?[2] as! UITabBarItem
                    tabItem.badgeValue = String(self.numBadge)
                    self.appBadge()
                    self.loading.stopAnimating()
                    self.loading.isHidden = true
                    
              //      self.parseImageGetNew()
                })
            }catch{}
        }
        task.resume()
    }
    func getBadge()
    {
        for i in 0..<mang.count
        {
            if (mang[i].status == 1 || mang[i].status == 2)
            {
                self.numBadge += 1
            }
        }
    }
    func appBadge()
    {
        
        
        let application = UIApplication.shared
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
            // Enable or disable features based on authorization.
        }
        application.registerForRemoteNotifications()
        application.applicationIconBadgeNumber = numBadge
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
                    self.parseJosnGetAll()
                    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DetailCuocHenTableViewCell
        cell.lblDiaChi.text = mang[indexPath.row].address
        cell.lblTieuDe.text = mang[indexPath.row].name
        cell.lblThoiGian.text = changeFormatDateAfterParse(x: mang[indexPath.row].time)
        if (mang[indexPath.row].status == 1)
        {
            cell.tinhTrang.text = "Đang chờ"
        }
        else if (mang[indexPath.row].status == 2)
        {
            cell.tinhTrang.text = "Chấp nhận"
        }
        else if (mang[indexPath.row].status == 3)
        {
            cell.tinhTrang.text = "Từ chối"
        }
        else if (mang[indexPath.row].status == 5)
        {
            cell.tinhTrang.text = "Đã hủy"
        }
        else
        {
            cell.tinhTrang.text = "Đã xong"
        }
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabbar = storyboard.instantiateViewController(withIdentifier: "DetailCuocHen") as! DetailCuocHenViewController
        tabbar.passAppoint = mang[indexPath.row]
        tabbar.role = self.role
        tabbar.idUser = idUser
        tabbar.idEstate = mang[indexPath.row].estate
        tabbar.name = mang[indexPath.row].name
        self.navigationController?.pushViewController(tabbar, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let xoa = UITableViewRowAction(style: .default, title: "xoa") { (action:UITableViewRowAction, index:IndexPath) in
            print ("fuck")
            
            self.myTbv.deleteRows(at: [index], with: .fade)
        }
        return [xoa]
    }
//    override func viewDidAppear(_ animated: Bool) {
//        var nav = self.navigationController?.navigationBar
//        // 2
//        nav?.barStyle = UIBarStyle.black
//        nav?.tintColor = UIColor.yellow
//        // 3
//        
//        // 5
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "edit3.png"), style: .done, target: self, action: #selector(DangBai))
//        
//        
//        
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//        imageView.contentMode = .scaleAspectFit
//        // 4
//        let image = UIImage(named: "swift2.png")
//        imageView.image = image
//        navigationItem.titleView = imageView
//    }
//    func DangBai()
//    {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let tabbar = storyboard.instantiateViewController(withIdentifier: "DangBai") as! DangBaiViewController
//        self.navigationController?.pushViewController(tabbar, animated: true)
//    }
    func changeFormatDateAfterParse(x: String) -> String
    {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "MMM dd, yyyy hh:mm:ss aa"
        let showDate = inputFormatter.date(from: x)
        inputFormatter.dateFormat = "hh:mm:ss aa dd/MM/yyyy"
        let resultString = inputFormatter.string(from: showDate!)
        return resultString
    }
    
    
}
