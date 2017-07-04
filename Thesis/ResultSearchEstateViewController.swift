//
//  ResultSearchEstateViewController.swift
//  Thesis
//
//  Created by Tri Quach on 6/24/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import UIKit

class ResultSearchEstateViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var loading: UIActivityIndicatorView!
    var spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    var json:String!
    var mang:[Estate]!
    var pages:Int = 1
    var loadingData = false
    var idUser:Int!
    var url:String!
    var typeSearch:Int! // 0: search thuong  1:GPS
    var role:Int!
    @IBOutlet weak var myTbv: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTbv.dataSource = self
        myTbv.delegate = self
        
       spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: self.view.frame.width, height: CGFloat(44))
        
        print ("json:" + json)
        loading.startAnimating()
        if (typeSearch == 0)
        {
            url = "http://rem-bt.azurewebsites.net/rem/rem_server/estate/search/"
        }
        else
        {
            url = "http://rem-bt.azurewebsites.net/rem/rem_server/estate/searchGPS/"
        }
        parseImageInterested()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mang.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ResultSearchTableViewCell
        
        print ("indexPath.row:" + String(indexPath.row))
        print ("mang.count:" + String(mang.count))
        
        let data:Data = Data(base64Encoded: mang[indexPath.row].image)!
        cell.myHouse.image = UIImage(data: data)
        
        cell.lblTitle.text = mang[indexPath.row].title
        cell.lblGia.text = String(mang[indexPath.row].gia) + " tỷ"
        cell.lblDIenTich.text = String(mang[indexPath.row].dientich) + " m2"
        cell.lblQuan.text = "Quận " + mang[indexPath.row].quan
        cell.lblPostDate.text = mang[indexPath.row].date
        
        if ( !self.loadingData && indexPath.row == mang.count - 1)
        {
            self.loadingData = true
            spinner.startAnimating()
            self.myTbv.tableFooterView = spinner
            self.myTbv.tableFooterView?.isHidden = false
            self.requestSearchPage(url: url)
        }
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabbar = storyboard.instantiateViewController(withIdentifier: "EstateDetailBuyer") as! EstateDetailBuyerController
        
       
            tabbar.idEstate = mang[indexPath.row].ID
            tabbar.isLogin = true
            tabbar.idUser = self.idUser
        tabbar.role = self.role
        
        self.navigationController?.pushViewController(tabbar, animated: true)
    }
    func parseImageInterested()
    {
        
        
        for i in 0..<mang.count
        {
            let id = mang[i].ID
            let req = URLRequest(url: URL(string: "http://rem-bt.azurewebsites.net/rem/rem_server/estate/getRepresentPhoto/" + String(id))!)
            
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
                                self.loading.isHidden = true
                                
                            })
                        }
                    
                }catch{}
            }
            task.resume()
        }
        
        
        
    }
    func requestSearchPage(url:String)
    {
        
        
        print ("pages:" + String(pages))
        let jsonObject = convertToDictionary(text: json)
        
        //  print (jsonObject)
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject)
        
        
        var req = URLRequest(url: URL(string: url + String(pages))!)
        
        
        
        
        req.httpMethod = "POST"
        req.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            
            
            
       
             if ( data != nil)
             {
            do
            {
                // print ("asdasd")
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as AnyObject
                let estates = json["estates"] as! [AnyObject]
                if (estates.count != 0)
                {
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
                        
                        let new_estate = Estate(ID: id,image: "", title: title, gia: price, dientich: area, quan: district, date: date, idOwner: 0)
                        
                        let owner = estates[i]["owner"] as! AnyObject
                        let idOwner = owner["id"] as! Int
                        
                        self.mang.append(new_estate)
                        
                    }
                    for i in 0..<self.mang.count
                    {
                        print (self.mang[i].title)
                    }
                    if ( json["statuskey"] as! Bool)
                    {
                        DispatchQueue.main.async {
                            self.pages += 1
                            self.myTbv.reloadData()
                            self.loadingData = false
                            self.parseImageInterested()
                        }
                        
                    }
                    else
                    {
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Alert", message: json["message"] as! String, preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                            
                        }
                    }
                    
                }
                else
                {
                    DispatchQueue.main.async {
                        self.spinner.isHidden = true
                   //     self.myTbv.tableFooterView = spinner
                        self.myTbv.tableFooterView?.isHidden = true
                        self.loadingData = false
                        //self.myTbv.reloadData()
                    }
                }
                
            }catch{
                print ("catch")
                print (error)
                
                
            }
            }
        }
        task.resume()
        
        
    }
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
   

}
