//
//  SearchNewViewController.swift
//  Thesis
//
//  Created by Tri Quach on 7/7/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import UIKit
import CoreLocation
import M13Checkbox
class SearchNewViewController: UIViewController,CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var cbTimQuanhDay: M13Checkbox!
    @IBOutlet weak var cbTimDiaChi: M13Checkbox!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var myTbv: UITableView!
    @IBOutlet weak var edtAddress: UITextField!
    let locationManager = CLLocationManager()
    var lat:Double!
    var long:Double!
    var check:Bool = true
    var index2:Int = 0
    var mangWard:[String] = []
    var idWard:Int!
    var idUser:Int!
    var role:Int!
    var mangFristLabel:[String] = [
        "Tỉnh/Thành phố",
        "Quận/huyện",
        "Phường/xã",
        "Loại nhà đất",
        "Diện tích",
        "Mức giá(triệu VND)",
        "Số tầng",
        "Số phòng ngủ",
        "Số phòng tắm",
        "Hướng nhà"
    ]
    var mangSecondLabel:[String] = [
        ">",
        ">",
        ">",
        ">",
        ">",
        ">",
        ">",
        ">",
        ">",
        ">"
    ]
    var mangIndex:[Int] = [
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0,
        0
    ]
    var mangCity:[String] = [
        "Không xác định",
        "Hồ Chí Minh"
    ]
    
    var mangDistrict:[String] = [
        "Không xác định",
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
        "Bình Tân",
        "Củ Chi",
        "Hóc Môn",
        "Bình Chánh",
        "Nhà Bè",
        "Cần Giờ"
    ]
    
    var mangLoai:[String] = [
        "Không xác định",
        "Căn hộ chung cư",
        "Nhà riêng",
        "Biệt thự",
        "Nhà mặt phố",
        "Đất",
        "Đất nền dự án",
        "Trang trại",
        "Khu nghỉ dưỡng",
        "Kho, xưởng"
        
    ]
    var mangDienTich:[String] = [
        "Không xác định",
        "< 30",
        "30 - 50",
        "50 - 80",
        "80 - 120",
        "120 - 200",
        "200 - 300",
        "300 - 500",
        "> 500"
    ]
    var mangGia:[String] = [
        "Không xác định",
        "< 500",
        "500 - 800",
        "800 - 1200",
        "1200 - 2000",
        "2000 - 3000",
        "3000 - 5000",
        "5000 - 7000",
        "7000 - 10000",
        "10000 - 20000",
        "> 20000"
    ]
    
    var mangSoTang:[String] = [
        "Không xác định",
        "0",
        "1",
        "1+",
        "2+",
        "3+",
        "4+",
        "5+"
    ]
    var mangSoPhongNgu:[String] = [
        "Không xác định",
        "1",
        "1+",
        "2+",
        "3+",
        "4+",
        "5+"
    ]
    var mangSoPhongTam:[String] = [
        "Không xác định",
        "1",
        "1+",
        "2+",
        "3+",
        "4+",
        "5+"
    ]
    var mangHuongNha:[String] = [
        "Không xác định",
        "Đông",
        "Tây",
        "Nam",
        "Bắc",
        "Đông-Bắc",
        "Tây-Bắc",
        "Tây-Nam",
        "Đông-Nam"
    ]
    var mangBanKinh:[String] = [
        "2-5km",
        "6-10km"
    ]
    var mang:[Estate] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        myTbv.delegate = self
        myTbv.dataSource = self
        
        loading.isHidden = true
        cbTimQuanhDay.checkState = .checked

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        myTbv.reloadData()
        //print ("index2 will Appear:" + String(index2))
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
      //  print ("index2 Did Appear:" + String(index2))
        if (index2 == 1)
        {
            index2 = 0
            loading.isHidden = false
            loading.startAnimating()
            sendRequestGetWard(idWard: idWard)
        }
        print ("start")
        for i in 0..<mangIndex.count
        {
            
            print (mangIndex[i])
            
        }
        print ("end")
    }
    

    @IBAction func locateGPS(_ sender: Any) {
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print ("1")
        var locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        lat = locValue.latitude
        long = locValue.longitude
        if (check)
        {
            check = false
            self.getLocationGoogleApi()
        }
        
    }
    func getLocationGoogleApi()
    {
        let url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=" + String(lat) + "," + String(long) + "&key=AIzaSyBQrSLHhtVml0KSdfz7px3fmwwlH-XdauA"
        // print (url)
        let req = URLRequest(url: URL(string: url)!)
        
        
        let task = URLSession.shared.dataTask(with: req) { (d, u, e) in
            
            
            do
            {
                
                let json = try JSONSerialization.jsonObject(with: d!, options: .allowFragments) as! AnyObject
                
                let results = json["results"] as! [AnyObject]
                let formatted_address = results[0]["formatted_address"] as! String
                print (formatted_address)
                DispatchQueue.main.async {
                    self.searchGPS(address: formatted_address)
                    self.edtAddress.text = formatted_address
                }
                
                
                
                
            }catch{}
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mangFristLabel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SearchNewTableViewCell
        cell.lblFirst.text = mangFristLabel[indexPath.row]
        cell.lblSecond.text = mangSecondLabel[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     //   index2 = indexPath.row
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabbar = storyboard.instantiateViewController(withIdentifier: "SearchValueViewController") as! SearchValueViewController
        tabbar.index = indexPath.row
        if (indexPath.row == 2)
        {
            tabbar.mangWard = self.mangWard
        }
        self.navigationController?.pushViewController(tabbar, animated: true)
    }
    func sendRequestGetWard(idWard: Int)
    {
       
        self.mangWard = []
        self.mangWard.append("Không xác định")
        
        let url = "http://rem-bt.azurewebsites.net/rem/rem_server/data/getWard/" + String(idWard)
        print (url)
        let req = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: req) { (d, u, e) in
            
            do
            {
                
                let json = try JSONSerialization.jsonObject(with: d!, options: .allowFragments) as! AnyObject
                
                let wards = json["wards"] as! [AnyObject]
                
                for i in 0..<wards.count
                {
                    let ward = wards[i]["name"] as! String
                    self.mangWard.append(ward)
                }
                
                for i in 0..<self.mangWard.count
                {
                    print (self.mangWard[i])
                }
                DispatchQueue.main.async {
                    self.loading.isHidden = true
                }
            }catch{
                print ("catch:")
                print (error)
                
            }
        }
        task.resume()
    }
    @IBAction func actionSearch(_ sender: Any) {
        loading.isHidden = false
        loading.startAnimating()
        mang = []
        if (cbTimDiaChi.checkState == .checked)
        {
            
            var ward:String!
            var city = mangCity[mangIndex[0]]
            var district = mangDistrict[mangIndex[1]]
            if (mangWard.count == 0)
            {
                ward = "Không xác định"
            }
            else
            {
                ward = mangWard[mangIndex[2]]
            }
            var address = ""
            
            
            var bathroom = mangIndex[8]
            var bedroom = mangIndex[7]
            var condition = mangHuongNha[mangIndex[9]]
            var floor = mangIndex[6]
            
            
            
            var type = mangLoai[mangIndex[3]]
            var price = mangIndex[5]
            var area = mangIndex[4]
            
            if (city == "Không xác định" )
            {
                city = ""
            }
            if ( district == "Không xác định" )
            {
                district = ""
            }
            if ( ward == "Không xác định" )
            {
                ward = ""
            }
            if ( type == "Không xác định" )
            {
                type = ""
            }
            if ( condition == "Không xác định" )
            {
                condition = ""
            }
            if (bathroom == 0 )
            {
                bathroom = -1
            }
            if (bedroom == 0 )
            {
                bedroom = -1
            }
            if ( floor == 0 )
            {
                floor = -1
            }
            if ( price == 0 )
            {
                price = -1
            }
            if ( area == 0 )
            {
                area = -1
            }
            
            let addressSearch:AddressSearch = AddressSearch(city: city, district: district, ward: ward, address: address)
            
            
            let detail:DetailSearch = DetailSearch(bathroom: bathroom, bedroom: bedroom, condition: condition, floor: floor)
            
            let postNewSearch:PostNewSearch = PostNewSearch(address: addressSearch, detail: detail, type: type, price: price, area: area)
            
            
            let json2 = JSONSerializer.toJson(postNewSearch)
            
            
            print (json2)
            
            let jsonObject = convertToDictionary(text: json2)
            
            //  print (jsonObject)
            
            
            let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject)
            
            
            var req = URLRequest(url: URL(string: "http://rem-bt.azurewebsites.net/rem/rem_server/estate/search/0")!)
            
            
            
            
            req.httpMethod = "POST"
            req.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
                
                
                do
                {
                    // print ("asdasd")
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as AnyObject
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
                        
                        let new_estate = Estate(ID: id,image: "", title: title, gia: price, dientich: area, quan: district, date: date, idOwner: 0)
                        
                        let owner = estates[i]["owner"] as! AnyObject
                        let idOwner = owner["id"] as! Int
                        
                        
                        
                        
                        
                        
                        self.mang.append(new_estate)
                        
                    }
                    
                    
                    //                DispatchQueue.main.async(execute: {
                    //                    self.myTbv.reloadData()
                    //
                    //                    self.parseImageInterested()
                    //                    //   self.parseImage()
                    //                })
                    
                    if ( json["statuskey"] as! Bool)
                    {
                        DispatchQueue.main.async {
                            self.loading.isHidden = true
                            
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let tabbar = storyboard.instantiateViewController(withIdentifier: "ResultSearchEstateViewController") as! ResultSearchEstateViewController
                            
                            tabbar.json = json2
                            tabbar.mang = self.mang
                            tabbar.idUser = self.idUser
                            tabbar.typeSearch = 0
                            tabbar.role = self.role
                            
                            self.navigationController?.pushViewController(tabbar, animated: true)
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
                    print ("catch")
                    print (error)
                }
                
                
            }
            task.resume()
        }
        else
        {
            locationManager.delegate = self;
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            //getLocationGoogleApi()
            
        }
        
        
    }
    @IBAction func actionTimQuanhDay(_ sender: Any) {
        cbTimDiaChi.setCheckState(.unchecked, animated: true)
        
    }
    
    @IBAction func actionTimDiaChi(_ sender: Any) {
        cbTimQuanhDay.setCheckState(.unchecked, animated: true)
        
    }
    func searchGPS(address: String)
    {
        let searchGPS:SearchGPS = SearchGPS(address: address)
        
        
        let json2 = JSONSerializer.toJson(searchGPS)
        
        
        print (json2)
        
        let jsonObject = self.convertToDictionary(text: json2)
        
        //  print (jsonObject)
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject)
        
        
        
        //  print (postString)
        var req = URLRequest(url: URL(string: "http://rem-bt.azurewebsites.net/rem/rem_server/estate/searchGPS/0")!)
        
        req.httpMethod = "POST"
        req.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            
            
            do
            {
                // print ("asdasd")
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as AnyObject
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
                        self.loading.isHidden = true
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let tabbar = storyboard.instantiateViewController(withIdentifier: "ResultSearchEstateViewController") as! ResultSearchEstateViewController
                        
                        tabbar.json = json2
                        tabbar.mang = self.mang
                        tabbar.idUser = self.idUser
                        tabbar.typeSearch = 1
                        tabbar.role = self.role
                        self.navigationController?.pushViewController(tabbar, animated: true)
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
                print ("catch")
                print (error)
            }
            
            
        }
        task.resume()
    }
}
