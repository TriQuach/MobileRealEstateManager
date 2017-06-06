//
//  CuocHenController.swift
//  Thesis
//
//  Created by TriQuach on 4/4/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
import UIKit

class CuocHenController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var myTbv: UITableView!
    @IBOutlet weak var lblTest: UILabel!
    
    var mang:[SimpleAppointment] = []
    
    var idUser:Int = 0
    var temp:Int?
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
             //   myTbv.dataSource = self
               // myTbv.delegate = self
            }
            
            
        }
        else
        {
            print ("vo day")
            parseJosnGetAll()
        }
        
    }
    func parseJosnGetAll()
    {
        
        
        let req = URLRequest(url: URL(string: "http://rem-real-estate-manager.1d35.starter-us-east-1.openshiftapps.com/rem/rem_server/appointment/getAll/" + String(idUser))!)
        
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
                    
                    let newSimpleAppointment:SimpleAppointment = SimpleAppointment(address: address, time: time, status: status, name: name)
     
                    
                    self.mang.append(newSimpleAppointment)
                    
                //    self.mang2.append(new_estate)
                    
                    
                }
                
              
                
                
                DispatchQueue.main.async(execute: {
                    self.myTbv.reloadData()
                    self.loading.stopAnimating()
                    self.loading.isHidden = true
              //      self.parseImageGetNew()
                })
            }catch{}
        }
        task.resume()
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
        cell.lblThoiGian.text = mang[indexPath.row].time
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
        else
        {
            cell.tinhTrang.text = "Đã xong"
        }
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabbar = storyboard.instantiateViewController(withIdentifier: "DetailCuocHen") as! DetailCuocHenViewController
                
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
    
    
}
