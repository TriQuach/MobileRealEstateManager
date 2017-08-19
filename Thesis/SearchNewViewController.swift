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
class SearchNewViewController: UIViewController,CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var myClv: UICollectionView!
    @IBOutlet weak var btnTimKiem: UIButton!
    @IBOutlet weak var outletSliderBanKinh: UISlider!
    @IBOutlet weak var lblBanKinh: UILabel!
    @IBOutlet weak var cbTimQuanhDay: M13Checkbox!
    @IBOutlet weak var cbTimDiaChi: M13Checkbox!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var myTbv: UITableView!
    @IBOutlet weak var edtAddress: UITextField!
    var formatted_address:String!
    let locationManager = CLLocationManager()
    var lat:Double!
    var long:Double!
    var check:Bool = true
    var index2:Int = 0
    var mangWard:[String] = []
    var idWard:Int!
    var idUser:Int!
    var role:Int!
    var indexCheck:Int = 99
    var mangBanKinh:[String] = [
        "1",
        "2",
        "3",
        "4",
        "5",
        "6"
    ]
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
        "Tất cả",
        "Hồ Chí Minh"
    ]
    
    var mangDistrict:[String] = [
        "Tất cả",
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
        "Tất cả",
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
        "Tất cả",
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
        "Tất cả",
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
        "Tất cả",
        "0",
        "1",
        "1+",
        "2+",
        "3+",
        "4+",
        "5+"
    ]
    var mangSoPhongNgu:[String] = [
        "Tất cả",
        "1",
        "1+",
        "2+",
        "3+",
        "4+",
        "5+"
    ]
    var mangSoPhongTam:[String] = [
        "Tất cả",
        "1",
        "1+",
        "2+",
        "3+",
        "4+",
        "5+"
    ]
    var mangHuongNha:[String] = [
        "Tất cả",
        "Đông",
        "Tây",
        "Nam",
        "Bắc",
        "Đông-Bắc",
        "Tây-Bắc",
        "Tây-Nam",
        "Đông-Nam"
    ]
    
    var mang:[Estate] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        myTbv.delegate = self
        myTbv.dataSource = self
        
        loading.isHidden = true
        cbTimQuanhDay.checkState = .checked
        myTbv.allowsSelection = false
        btnTimKiem.ghostButton()
        myClv.dataSource = self
        myClv.delegate = self
     //   myTbv.isHidden = true

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
            
            if (idWard != 999)
            {
                sendRequestGetWard(idWard: idWard)
            }
            else
            {
                loading.isHidden = true
            }
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
                    //self.searchGPS(address: formatted_address)
                    self.formatted_address = formatted_address
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
        if (cbTimDiaChi.checkState == .checked)
        {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabbar = storyboard.instantiateViewController(withIdentifier: "SearchValueViewController") as! SearchValueViewController
            tabbar.index = indexPath.row
            tabbar.nameTitle = mangFristLabel[indexPath.row]
            if (indexPath.row == 2)
            {
                tabbar.mangWard = self.mangWard
            }
            self.navigationController?.pushViewController(tabbar, animated: true)
        }
       
    }
    func sendRequestGetWard(idWard: Int)
    {
       
        self.mangWard = []
        self.mangWard.append("Tất cả")
        
        let url = "http://35.194.220.127/rem/rem_server/data/getWard/" + String(idWard)
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
                ward = "Tất cả"
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
            
            if (city == "Tất cả" )
            {
                city = ""
            }
            if ( district == "Tất cả" )
            {
                district = ""
            }
            if ( ward == "Tất cả" )
            {
                ward = ""
            }
            if ( type == "Tất cả" )
            {
                type = ""
            }
            if ( condition == "Tất cả" )
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
            
            let postNewSearch:PostNewSearch = PostNewSearch(address: addressSearch, detail: detail, type: type, price: price, area: area, userID: idUser)
            
            
            let json2 = JSONSerializer.toJson(postNewSearch)
            
            
            print (json2)
            
            let jsonObject = convertToDictionary(text: json2)
            
            //  print (jsonObject)
            
            
            let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject)
            
            
            var req = URLRequest(url: URL(string: "http://35.194.220.127/rem/rem_server/estate/search/0")!)
            
            
            
            
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
                        
                        
                        
                        let owner = estates[i]["owner"] as! AnyObject
                        let idOwner = owner["id"] as! Int
                        
                        
                        let new_estate = Estate(ID: id,image: "", title: title, gia: price, dientich: area, quan: district, date: date, idOwner: idOwner)
                        
                        
                        
                        self.mang.append(new_estate)
                        
                    }
                    
                    
                    //                DispatchQueue.main.async(execute: {
                    //                    self.myTbv.reloadData()
                    //
                    //                    self.parseImageInterested()
                    //                    //   self.parseImage()
                    //                })
                    if (self.mang.count > 0)
                    {
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
                    }
                    else
                    {
                        let alert = UIAlertController(title: "Lỗi", message: "Không tìm thấy BĐS nào!", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        self.loading.isHidden = true
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
            self.searchGPS(address: formatted_address)
            //getLocationGoogleApi()
            
        }
        
        
    }
    @IBAction func actionTimQuanhDay(_ sender: Any) {
        cbTimDiaChi.setCheckState(.unchecked, animated: true)
        myTbv.allowsSelection = false
    }
    
    @IBAction func actionTimDiaChi(_ sender: Any) {
        cbTimQuanhDay.setCheckState(.unchecked, animated: true)
        myTbv.allowsSelection = true
        
    }
    func searchGPS(address: String)
    {
        
        let searchGPS:SearchGPS = SearchGPS(latitude: lat, longitude: long, distance: Int(mangBanKinh[indexCheck])!)
        
        
        let json2 = JSONSerializer.toJson(searchGPS)
        
        
        print (json2)
        
        let jsonObject = self.convertToDictionary(text: json2)
        
        //  print (jsonObject)
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject)
        
        
        
        //  print (postString)
        var req = URLRequest(url: URL(string: "http://35.194.220.127/rem/rem_server/estate/searchGPS/0")!)
        
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
                    if (self.mang.count > 0)
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
                        let alert = UIAlertController(title: "Lỗi", message: "Không tìm thấy BĐS nào!", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        self.loading.isHidden = true
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
    @IBAction func sliderBanKinh(_ sender: Any) {
        lblBanKinh.text = String(Int(outletSliderBanKinh.value)) + " km"
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.row != indexCheck)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BanKinhCollectionViewCell
            cell.layer.borderWidth = 1.0
            cell.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1).cgColor
            cell.layer.cornerRadius = 5
            if (indexPath.row == mangBanKinh.count - 1)
            {
            cell.lblBanKinh2.text = mangBanKinh[indexPath.row] + "+"
            }
            else
            {
                cell.lblBanKinh2.text = mangBanKinh[indexPath.row]
            }
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! BanKinh2CollectionViewCell
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1).cgColor
        cell.layer.cornerRadius = 5
        if (indexPath.row == mangBanKinh.count - 1)
        {
            cell.lblBanKinh3.text = mangBanKinh[indexPath.row] + "+"
        }
        else
        {
            cell.lblBanKinh3.text = mangBanKinh[indexPath.row]
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.indexCheck = indexPath.row
        self.myClv.reloadData()
        
    }
    @IBAction func actionSearchMap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabbar = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        tabbar.idUser = idUser
        tabbar.role = role
        
        self.navigationController?.pushViewController(tabbar, animated: true)
    }
}
