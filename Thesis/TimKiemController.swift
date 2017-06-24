//
//  TimKiemController.swift
//  Thesis
//
//  Created by TriQuach on 4/9/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
import UIKit
import Dropper
import DropDown
class TimKiemController: UIViewController {
    
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    let dropDown = DropDown()
    let dropDown2 = DropDown()
    let dropDown3 = DropDown()
    let dropDown4 = DropDown()
    let dropDown5 = DropDown()
    let dropDown6 = DropDown()
    let dropDown7 = DropDown()
    let dropDown8 = DropDown()
    let dropDown9 = DropDown()
    let dropDown10 = DropDown()
    @IBOutlet weak var edtDiaChi: UITextField!
    
    @IBOutlet weak var dropThanhPho: UIView!
    
    @IBOutlet weak var dropQuan: UIView!
    @IBOutlet weak var dropPhuong: UIView!
    @IBOutlet weak var lblThanhPho: UILabel!
    @IBOutlet weak var lblQuan: UILabel!
    @IBOutlet weak var lblPhuong: UILabel!
    @IBOutlet weak var loading2: UIActivityIndicatorView!
    @IBOutlet weak var dropLoai: UIView!
    @IBOutlet weak var dropDienTich: UIView!
    @IBOutlet weak var dropGia: UIView!
    @IBOutlet weak var dropSoTang: UIView!
    @IBOutlet weak var dropSoPhongNgu: UIView!
    @IBOutlet weak var dropSoPhongTam: UIView!
    @IBOutlet weak var dropHuongNha: UIView!
    @IBOutlet weak var lblLoai: UILabel!
    @IBOutlet weak var lblDienTich: UILabel!
    @IBOutlet weak var lblGia: UILabel!
    @IBOutlet weak var lblSoTang: UILabel!
    @IBOutlet weak var lblSoPhongNgu: UILabel!
    @IBOutlet weak var lblSoPhongTam: UILabel!
    @IBOutlet weak var lblHuongNha: UILabel!
    
    var indexDienTich:Int!
    var indexGia:Int!
    var indexSoTang:Int!
    var indexSoPhongNgu:Int!
    var indexSoPhongTam:Int!
    
    var mangWard:[String] = []
    var mangDistrict:[String] = [
        "Không xác định",
        "Quận 1",
        "Quận 2",
        "Quận 3",
        "Quận 4",
        "Quận 5",
        "Quận 6",
        "Quận 7",
        "Quận 8",
        "Quận 9",
        "Quận 10",
        "Quận 11",
        "Quận 12",
        "Quận Thủ Đức",
        "Quận Gò Vấp",
        "Quận Bình Thạnh",
        "Quận Tân Bình",
        "Quận Tân Phú",
        "Quận Phú Nhuận",
        "Quận Bình Tân",
        "Huyện Củ Chi",
        "Huyện Hóc Môn",
        "Huyện Bình Chánh",
        "Huyện Nhà Bè",
        "Huyện Cần Giờ"
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
    
//    var spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
//    
//    var mang:[String] = ["asdsad","asdsad","asdsad","asdsad","asdsad","asdsad","asdsad","asdsad","asdsad","asdsad","asdsad","asdsad","asdsad"]
//    let dropper = Dropper(width: 75, height: 200)
       override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initDropDown(x: dropThanhPho)
        initDropDown(x: dropQuan)
        initDropDown(x: dropPhuong)
        initDropDown(x: dropLoai)
        initDropDown(x: dropDienTich)
        initDropDown(x: dropGia)
        initDropDown(x: dropSoTang)
        initDropDown(x: dropSoPhongNgu)
        initDropDown(x: dropSoPhongTam)
        initDropDown(x: dropHuongNha)
        
        
        loading2.isHidden = true
        loading.isHidden = true
               
        
//        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: self.view.frame.width, height: CGFloat(44))
        
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return mang.count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        print (indexPath.row)
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TimKiemTableViewCell
//        if ( indexPath.row == mang.count - 1)
//        {
//            
//            spinner.startAnimating()
//            
//            
//           
//            
//         //   self.myTbv.tableFooterView = spinner
//         //   self.myTbv.tableFooterView?.isHidden = false
//        }
//        return cell
//    }
    
    
    func initDropDown(x:UIView)
    {
        
        x.layer.borderWidth = 1
        x.layer.borderColor = UIColor.black.cgColor
        
        if ( x.tag == 1)
        {
            dropDown.anchorView = x // UIView or UIBarButtonItem
            
            dropDown.dataSource = [
                "Không xác định",
                "Thành phố Hồ Chí Minh"
            ]
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                self.lblThanhPho.text = item
                
            }
            
            let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imgMoreTapped))
            x.isUserInteractionEnabled = true
            x.addGestureRecognizer(tap)
        }
        else if (x.tag == 2)
        {
            dropDown2.anchorView = x // UIView or UIBarButtonItem
            
            dropDown2.dataSource = self.mangDistrict
            
            
            
            
            
            
            
            
            dropDown2.selectionAction = { [unowned self] (index: Int, item: String) in
                
                print ("index:::" + String(index))
                self.lblQuan.text = item
                self.sendRequestGetWard(idWard: index)
            }
            
            let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imgMoreTapped2))
            x.isUserInteractionEnabled = true
            x.addGestureRecognizer(tap)
        }
        else if (x.tag == 3)
        {
            dropDown3.anchorView = x
            dropDown3.dataSource = self.mangWard
            dropDown3.selectionAction = { [unowned self] (index: Int, item: String) in
                
                self.lblPhuong.text = item
                
            }
            
            let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imgMoreTapped3))
            x.isUserInteractionEnabled = true
            x.addGestureRecognizer(tap)
        }
        else if (x.tag == 4)
        {
            dropDown4.anchorView = x
            dropDown4.dataSource = self.mangLoai
            dropDown4.selectionAction = { [unowned self] (index: Int, item: String) in
                
                self.lblLoai.text = item
                
            }
            
            let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imgMoreTapped4))
            x.isUserInteractionEnabled = true
            x.addGestureRecognizer(tap)
        }
        else if (x.tag == 5)
        {
            dropDown5.anchorView = x
            dropDown5.dataSource = self.mangDienTich
            dropDown5.selectionAction = { [unowned self] (index: Int, item: String) in
                
                self.lblDienTich.text = item
                self.indexDienTich = index
                
            }
            
            let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imgMoreTapped5))
            x.isUserInteractionEnabled = true
            x.addGestureRecognizer(tap)
        }
        else if (x.tag == 6)
        {
            dropDown6.anchorView = x
            dropDown6.dataSource = self.mangGia
            dropDown6.selectionAction = { [unowned self] (index: Int, item: String) in
                
                self.lblGia.text = item
                self.indexGia = index
                
            }
            
            let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imgMoreTapped6))
            x.isUserInteractionEnabled = true
            x.addGestureRecognizer(tap)
        }
        else if (x.tag == 7)
        {
            dropDown7.anchorView = x
            dropDown7.dataSource = self.mangSoTang
            dropDown7.selectionAction = { [unowned self] (index: Int, item: String) in
                
                self.lblSoTang.text = item
                self.indexSoTang = index
                
            }
            
            let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imgMoreTapped7))
            x.isUserInteractionEnabled = true
            x.addGestureRecognizer(tap)
        }
        else if (x.tag == 8)
        {
            dropDown8.anchorView = x
            dropDown8.dataSource = self.mangSoPhongNgu
            dropDown8.selectionAction = { [unowned self] (index: Int, item: String) in
                
                self.lblSoPhongNgu.text = item
                self.indexSoPhongNgu = index
            }
            
            let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imgMoreTapped8))
            x.isUserInteractionEnabled = true
            x.addGestureRecognizer(tap)
        }
        else if (x.tag == 9)
        {
            dropDown9.anchorView = x
            dropDown9.dataSource = self.mangSoPhongTam
            dropDown9.selectionAction = { [unowned self] (index: Int, item: String) in
                
                self.lblSoPhongTam.text = item
                self.indexSoPhongTam = index
            }
            
            let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imgMoreTapped9))
            x.isUserInteractionEnabled = true
            x.addGestureRecognizer(tap)
        }
        else if (x.tag == 10)
        {
            dropDown10.anchorView = x
            dropDown10.dataSource = self.mangHuongNha
            dropDown10.selectionAction = { [unowned self] (index: Int, item: String) in
                
                self.lblHuongNha.text = item
                
            }
            
            let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imgMoreTapped10))
            x.isUserInteractionEnabled = true
            x.addGestureRecognizer(tap)
        }
      
    }
    
    func imgMoreTapped()
    {
        dropDown.show()
    }
    func imgMoreTapped2()
    {
        dropDown2.show()
    }
    func imgMoreTapped3()
    {
        dropDown3.show()
    }
    func imgMoreTapped4()
    {
        dropDown4.show()
    }
    func imgMoreTapped5()
    {
        dropDown5.show()
    }
    func imgMoreTapped6()
    {
        dropDown6.show()
    }
    func imgMoreTapped7()
    {
        dropDown7.show()
    }
    func imgMoreTapped8()
    {
        dropDown8.show()
    }
    func imgMoreTapped9()
    {
        dropDown9.show()
    }
    func imgMoreTapped10()
    {
        dropDown10.show()
    }
    
    func sendRequestGetWard(idWard: Int)
    {
        self.lblPhuong.text = ""
        self.mangWard = []
        self.mangWard.append("Không xác định")
        self.loading2.isHidden = false
        self.loading2.startAnimating()
        let url = "http://rem-real-estate-manager.1d35.starter-us-east-1.openshiftapps.com/rem/rem_server/data/getWard/" + String(idWard)
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
                    self.loading2.isHidden = true
                    self.initDropDown(x: self.dropPhuong)
                }
            }catch{
                print ("catch:")
                print (error)
                
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
    
   
    @IBAction func actionSearch(_ sender: Any) {
        loading.isHidden = false
        loading.startAnimating()
        var city = lblThanhPho.text
        var district = lblQuan.text
        var ward = lblPhuong.text
        var address = edtDiaChi.text
        
        
        var bathroom = indexSoPhongTam
        var bedroom = indexSoPhongNgu
        var condition = lblHuongNha.text
        var floor = indexSoTang
        
        
        
        var type = lblLoai.text
        var price = indexGia
        var area = indexDienTich
        
        if (city == "Không xác định")
        {
            city = ""
        }
        if ( district == "Không xác định")
        {
            district = ""
        }
        if ( ward == "Không xác định")
        {
            ward = ""
        }
        if ( type == "Không xác định")
        {
           type = ""
        }
        if ( condition == "Không xác định")
        {
           condition = ""
        }
        if (bathroom == 0)
        {
            bathroom = -1
        }
        if (bedroom == 0)
        {
            bedroom = -1
        }
        if ( floor == 0)
        {
            floor = -1
        }
        if ( price == 0)
        {
            price = -1
        }
        if ( area == 0)
        {
            area = -1
        }
        
        let addressSearch:AddressSearch = AddressSearch(city: city!, district: district!, ward: ward!, address: address!)

        
        let detail:DetailSearch = DetailSearch(bathroom: bathroom!, bedroom: bedroom!, condition: condition!, floor: floor!)
        
        let postNewSearch:PostNewSearch = PostNewSearch(address: addressSearch, detail: detail, type: type!, price: price!, area: area!)
        
        
        let json2 = JSONSerializer.toJson(postNewSearch)
        
        
            print (json2)
        
        let jsonObject = convertToDictionary(text: json2)
        
        //  print (jsonObject)
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject)
        
        
        var req = URLRequest(url: URL(string: "http://rem-real-estate-manager.1d35.starter-us-east-1.openshiftapps.com/rem/rem_server/estate/search/0")!)
        
        
        
        
        req.httpMethod = "POST"
        req.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            
            
            do
            {
               // print ("asdasd")
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as AnyObject
                
                if ( json["statuskey"] as! Bool)
                {
                    DispatchQueue.main.async {
                        self.loading.isHidden = true
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let tabbar = storyboard.instantiateViewController(withIdentifier: "ResultSearchEstateViewController") as! ResultSearchEstateViewController
                        
                        tabbar.json = json2
                        
                        
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
