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
    var query:String!
    var mangDistrict:[String] = [
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        "10",
        "11",
        "12",
        "Thủ Đức",
        "Gò Vấp",
        "Bình Thạnh",
        "Tân Bình",
        "Tân Phú",
        "Phú Nhuận",
        "Bình Tân"
    ]
    @IBOutlet weak var myTbv: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTbv.dataSource = self
        myTbv.delegate = self
        
       spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: self.view.frame.width, height: CGFloat(44))
        
       // print ("json:" + json)
        loading.startAnimating()
        if (typeSearch == 0)
        {
            url = "http://35.194.220.127/rem/rem_server/estate/search/"
        }
        else if (typeSearch == 1)
        {
            url = "http://35.194.220.127/rem/rem_server/estate/searchGPS/"
        }
        else if (typeSearch == 2) // quick search
        {
            url = "http://35.194.220.127/rem/rem_server/estate/searchText/" + query + "/"
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
        if (mang[indexPath.row].gia < 1000)
        {
            cell.lblGia.text = String(mang[indexPath.row].gia) + " triệu"
        }
        else
        {
            cell.lblGia.text = String(mang[indexPath.row].gia / 1000) + " tỷ"
        }
        cell.lblDIenTich.text = String(mang[indexPath.row].dientich) + " m2"
        if (check(x: mang[indexPath.row].quan))
        {
            cell.lblQuan.text = "Quận " + mang[indexPath.row].quan
        }
        else
        {
            cell.lblQuan.text = "Huyện " + mang[indexPath.row].quan
        }
        let parsed = parseDateTime(str: mang[indexPath.row].date)
        let start = changeFormatDateAfterParse(x: parsed)
        let end = getCurrentDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let first:NSDate = dateFormatter.date(from: start) as! NSDate
        let second:NSDate = dateFormatter.date(from: end) as! NSDate
        let x = daysBetween(start: first as Date, end: second as Date)
        cell.lblPostDate.text = String(x) + " ngày trước"
        
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
        tabbar.idOwner = mang[indexPath.row].idOwner
        tabbar.role = self.role
        
        self.navigationController?.pushViewController(tabbar, animated: true)
    }
    func parseImageInterested()
    {
        
        
        for i in 0..<mang.count
        {
            let id = mang[i].ID
            let req = URLRequest(url: URL(string: "http://35.194.220.127/rem/rem_server/estate/getRepresentPhoto/" + String(id))!)
            
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
                    else
                        {
                            DispatchQueue.main.async(execute: {
                                
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
        
        
        var req:URLRequest!
        if ( typeSearch == 0 || typeSearch == 1)
        {
             req = URLRequest(url: URL(string: url + String(pages))!)
        
        }
        else if (typeSearch == 2)
        {
            let url2 = url + String(pages)
            let escapedString = url2.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let url3 = URL(string: escapedString!)
            req = URLRequest(url: url3!)
        }
        
        if (typeSearch == 0 || typeSearch == 1)
        {
            let jsonObject = convertToDictionary(text: json)
            
            //  print (jsonObject)
            
            
            let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject)
            req.httpMethod = "POST"
            req.httpBody = jsonData
        }
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
                        
                        
                        
                        let owner = estates[i]["owner"] as! AnyObject
                        let idOwner = owner["id"] as! Int
                        let new_estate = Estate(ID: id,image: "", title: title, gia: price, dientich: area, quan: district, date: date, idOwner: idOwner)
                        
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
    func parseDateTime(str: String) -> String
    {
        var count = 0
        var str2:String = ""
        for i in 0..<str.characters.count
        {
            let index = str.index(str.startIndex, offsetBy: i)
            if (str[index] == " ")
            {
                count += 1
            }
            if (count == 3)
            {
                break
            }
            str2.append(str[index])
        }
        return str2
    }
    func daysBetween(start: Date, end: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: start, to: end).day!
    }
    func changeFormatDateAfterParse(x: String) -> String
    {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "MMM d, yyyy"
        let showDate = inputFormatter.date(from: x)
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let resultString = inputFormatter.string(from: showDate!)
        return resultString
    }
    func getCurrentDate() -> String
    {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let end = formatter.string(from: date)
        return end
    }
    func check(x:String) -> Bool
    {
        for i in 0..<mangDistrict.count
        {
            if (x == mangDistrict[i])
            {
                return true
                
            }
        }
        return false
    }
   

}
