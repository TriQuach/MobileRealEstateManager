//
//  BatDongSanController.swift
//  Thesis
//
//  Created by TriQuach on 4/2/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
import UIKit

class BatDongSanController: UIViewController, UITableViewDataSource,UITableViewDelegate, UISearchBarDelegate{
    
    @IBOutlet weak var mySearchBar: UISearchBar!
    var isLogin:Bool = false
    
    var count2 = 3
    var count:Int = 0
    var num_section:Int = 0
    
    var passedObject:Estates!
    var idUser:Int = 0

    var mang:[Estate] = []
    var mang2:[Estate] = []
    var mang3:[Estate] = []
    var mang4:[Estate] = [] // mang quick search
    var mang_id1:[Int] = []
    var mang_id2:[Int] = []
    
    var nameOwner:[String] = []
    var addressOwner:[String] = []
    
    var nameOwner2:[String] = []
    var addressOwner2:[String] = []
    
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
    
    @IBOutlet weak var imgMore: UIImageView!
    
    var x:CGFloat = 0
    var y:CGFloat = 0
    
    var temp:String = ""
    
    var current_like = false
    var role:Int = 0 // 0: buyer; 1: seller; 2: broker
    
    var test:String?
    var newEstates:Estates!
    
    @IBOutlet weak var btnDangBai: UIButton!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var myTbv: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       // lblRole.text = temp
        
        navigationController?.navigationBar.barTintColor = UIColor(cgColor: #colorLiteral(red: 0.2352941176, green: 0.3529411765, blue: 0.6078431373, alpha: 1).cgColor)
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(cgColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor)]
        
        
        self.navigationItem.title = "Bất động sản"
        mySearchBar.delegate = self
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imgMoreTapped))
        imgMore.isUserInteractionEnabled = true
        imgMore.addGestureRecognizer(tap)
        
        loading.color = .black
        
        loading.startAnimating()
        
       
        loadAfterGetAll()
        
        
       
   //     print (x.listEstates[0].address)
        
    //    parseJSONGetTopRate()
        
        
        //sleep(5)
   // parseImage()
     //   print (mang[0].image)
        
        
       
        
        
        
        
        
    }
    
    func loadAfterGetAll()
    {
        do {
            let data = try String(contentsOfFile: "/Users/triquach/Documents/token.txt", encoding: .utf8)
            
            isLogin = true
            
            parseJsonToken(token: data)
            print ("idUser:" + String(idUser))
            
            
            
            
        } catch {
            //            print("2")
            //            self.window = UIWindow(frame: UIScreen.main.bounds)
            //
            //            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //
            //            let initialViewController = storyboard.instantiateViewController(withIdentifier: "start")
            //
            //            self.window?.rootViewController = initialViewController
            //            self.window?.makeKeyAndVisible()
            
            myTbv.dataSource = self
            myTbv.delegate = self
        }
        
        
        
        
        parseJSONGetNew()
        
        
        if ( isLogin )
        {
            var secondTab = self.tabBarController?.viewControllers?[2] as! CuocHenController
            secondTab.idUser = idUser
            secondTab.role = self.role
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print (mySearchBar.text!)
        mang4 = []
        self.mySearchBar.endEditing(true)
        self.loading .isHidden = false
        self.loading.startAnimating()
        let urlString = "http://rem-bt.azurewebsites.net/rem/rem_server/estate/searchText/" + mySearchBar.text! + "/0"
        print (urlString)
        
        let escapedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: escapedString!)
        let req = URLRequest(url: url!)
        
        //let req = URLRequest(url: URL(string: urlString)!)
        
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
                    
                    
                    
                    
                    self.mang4.append(new_estate)
                    
                }
                for i in 0..<self.mang4.count
                {
                    print (self.mang4[i].title)
                }
                
                
                
                if ( json["statuskey"] as! Bool)
                {
                    DispatchQueue.main.async {
                        self.loading.isHidden = true
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let tabbar = storyboard.instantiateViewController(withIdentifier: "ResultSearchEstateViewController") as! ResultSearchEstateViewController
                        
                        tabbar.mang = self.mang4
                        tabbar.idUser = self.idUser
                        tabbar.typeSearch = 2
                        tabbar.role = self.role
                        tabbar.query = self.mySearchBar.text!
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
    
    func parseJsonToken(token: String)
    {
        print ("1")
        
        let url = "http://rem-bt.azurewebsites.net/rem/rem_server/user/login/" + token
        print (url)
        let req = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: req) { (d, u, e) in
            
            do
            {
                print ("error:")
                print (e)
                let json = try JSONSerialization.jsonObject(with: d!, options: .allowFragments) as! AnyObject
                
                
                if (json["statuskey"] as! Bool)
                {
                    let typeId = json["typeId"] as! Int
                    let id = json["id"] as! Int
                    
                    print (typeId)
                    
                    DispatchQueue.main.async {
                        
                        if ( typeId == 1)
                        {
                            self.role = 0
                            self.idUser = id
                            self.parseJSONgetInterested()
                            self.myTbv.dataSource = self
                            self.myTbv.delegate = self
                            self.myTbv.reloadData()
                            var secondTab = self.tabBarController?.viewControllers?[2] as! CuocHenController
                            secondTab.idUser = self.idUser
                            secondTab.role = 0
                            self.btnDangBai.isEnabled = false
                            
                        }
                        else if ( typeId == 2)
                        {
                            self.role = 1
                            self.idUser = id
                            self.parseJsonGetByOwnerID()
                            self.myTbv.dataSource = self
                            self.myTbv.delegate = self
                            var secondTab = self.tabBarController?.viewControllers?[2] as! CuocHenController
                            secondTab.idUser = self.idUser
                            secondTab.role = 1
                        }
                        
                        
                        //
                        
                        
                        
                        
                    }
                }
                else
                {
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(title: "Thông báo", message: json["message"] as! String, preferredStyle: .alert)
                        
                        // Create the actions
                        let okAction = UIAlertAction(title: "Đăng nhập", style: UIAlertActionStyle.default) {
                            UIAlertAction in
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let tabbar = storyboard.instantiateViewController(withIdentifier: "login") as! LogInViewController
                            
                            tabbar.storyboardID = "EstateDetailBuyer"
                            self.navigationController?.pushViewController(tabbar, animated: true)
                        }
                        
                        
                        // Add the actions
                        alertController.addAction(okAction)
                       
                        
                        // Present the controller
                        self.present(alertController, animated: true, completion: nil)
                        self.loading.stopAnimating()
                        self.loading.isHidden = true
                    }
                }
                
                
            }catch{
                print ("catch:")
                print (error)
                
            }
        }
        task.resume()
    }
    
    func parseUser(url: String)
    {
        var listFullEstates:[FullEstate] = []
      //  var newEstates:Estates!
        
        let req = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: req) { (d, u, e) in
            
            do
            {
                let json = try JSONSerialization.jsonObject(with: d!, options: .allowFragments) as AnyObject
                let listEstates = json["estates"] as! [AnyObject]
                for i in 0..<listEstates.count
                {
                    let user = listEstates[i]["owner"] as AnyObject
                    let email = user["email"] as! String
                    let password = user["password"] as! String
                    let address = user["address"] as! String
                    let typeID = user["typeId"] as! Int
                    let fullName = user["fullName"] as! String
                    let phone = user["phone"] as! String
                    let id = user["id"] as! Int
                    let name = user["name"] as! String
//
                    let newUser:User = User(email: email, password: password, address: address, typeID: typeID, fullName: fullName,phone: phone, id: id, name: name)
                    
                    let detailAddress = listEstates[i]["address"] as AnyObject
                    let city = detailAddress["city"] as! String
                    let district = detailAddress["district"] as! String
                    let ward = detailAddress["ward"] as! String
                    let address2 = detailAddress["address"] as! String
                    let id2 = detailAddress["id"] as! Int
                    
                    let newAdress:Address = Address(city: city, district: district, ward: ward, address: address2, id: id2)
                    
                    let detail = listEstates[i]["detail"] as AnyObject
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
                    
                    let newDetail:Detail = Detail(bathroom: bathroom, bedroom: bedroom, condition: condition, description: description, floor: floor, length: length, width: width, longitude: longitude, latitude: latitude, id: id)
                    
               //    print (newDetail.description)
                    
                    
                    
                    let available = listEstates[i]["available"] as! Bool
                    let type = listEstates[i]["type"] as! String
                    let postTime = listEstates[i]["postTime"] as! String
                    let price = listEstates[i]["price"] as! Double
                    let area = listEstates[i]["area"] as! Double
                    let id3 = listEstates[i]["id"] as! Int
                    let name3 = listEstates[i]["name"] as! String
                    
                    let newFullEstate:FullEstate = FullEstate(owner: newUser, address: newAdress, detail: newDetail, available: available, type: type, postTime: postTime, editTime: "", price: price, area: area, id: id3, name: name3)
                    
                    
                    
                    
                  //  print (newFullEstate.address.street)
                    listFullEstates.append(newFullEstate)
                  //  print (listFullEstates[i].detail.floor)
                    
                    
                    

                }
                let statuskey = json["statuskey"] as! Bool
               // print (listFullEstates[1].postTime)
                DispatchQueue.main.async {
                      self.newEstates = Estates(listEstates: listFullEstates, statuskey: statuskey)
                    self.loadAfterGetAll()
                   // print ( self.newEstates.statuskey)
                }
                
             //   Estates.statuskey = statuskey
                
                
                
            }catch{}
        }
        task.resume()
        
        
        
       }
    func parseJSONGetNew()
    {
       
        let req = URLRequest(url: URL(string: "http://rem-bt.azurewebsites.net/rem/rem_server/estate/getNew/0")!)
        
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
                    self.mang_id2.append(idOwner)
                    
                    self.mang2.append(new_estate)
                   
                    self.nameOwner2.append(owner["fullName"] as! String)
                    self.addressOwner2.append(owner["address"] as! String)
                
                }
                
                
                DispatchQueue.main.async(execute: {
                    self.myTbv.reloadData()
                    
                    self.parseImageGetNew()
                })
            }catch{}
        }
        task.resume()
    }
    
    func parseJSONgetInterested()
    {
       
        let req = URLRequest(url: URL(string: "http://rem-bt.azurewebsites.net/rem/rem_server/user/getInterested/" + String(idUser))!)
        
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
                    self.mang_id1.append(idOwner)
                    self.nameOwner.append(owner["fullName"] as! String)
                    self.addressOwner.append(owner["address"] as! String)
                    
                    
                    
                    
                  
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
        
        let req = URLRequest(url: URL(string: "http://rem-bt.azurewebsites.net/rem/rem_server/estate/getByOwnerID/" + String(idUser))!)
        
        let task = URLSession.shared.dataTask(with: req) { (d, u, e) in
            
            do
            {
                
                let json = try JSONSerialization.jsonObject(with: d!, options: .allowFragments) as! AnyObject
                
                if (json["statuskey"] as! Bool)
                {
                    
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
                        self.loading.stopAnimating()
                        self.loading.isHidden = true
                    })
                    }
                }catch{}
            }
            task.resume()
        }
        
        
       
    }
    
    func parseImageGetByOwnerID()
    {
        if (mang3.count == 0)
        {
            self.loading.isHidden = true
        }
        for i in 0..<mang3.count
        {
            let id = mang3[i].ID
            let req = URLRequest(url: URL(string: "http://rem-bt.azurewebsites.net/rem/rem_server/estate/getRepresentPhoto/" + String(id))!)
            
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
    func parseImageGetNew()
    {
        
        
        for i in 0..<mang2.count
        {
            let id = mang2[i].ID
            let req = URLRequest(url: URL(string: "http://rem-bt.azurewebsites.net/rem/rem_server/estate/getRepresentPhoto/" + String(id))!)
            
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
                            if (!self.isLogin)
                            {
                                self.loading.stopAnimating()
                                self.loading.isHidden = true
                            }
                            
                        })
                    }
                }catch{}
            }
            task.resume()
        }
        
        
        
    }
    
    func imgMoreTapped()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let timkiem = storyboard.instantiateViewController(withIdentifier: "SearchNewViewController") as! SearchNewViewController
        timkiem.idUser = idUser
        timkiem.role = self.role
        
        self.navigationController?.pushViewController(timkiem, animated: true)
    }
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailBuyer = storyboard.instantiateViewController(withIdentifier: "EstateDetailBuyer") as! EstateDetailBuyerController
        
        self.navigationController?.pushViewController(detailBuyer, animated: true)
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
            return 2
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        
        if ( role == 0)
        {
            if ( section == 0)
            {
                if ( !isLogin )
                {
                    return 1
                }
                return mang.count
            }
            
                return mang2.count
           
            
        }
        if ( section == 0)
        {
            if (!isLogin)
            {
                return 1
            }
            return mang3.count
        }
        
            return mang2.count
        
       
    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if (role == 0)
//        {
//            if (section == 0)
//            {
//                return "Bất động sản đang quan tâm"
//            }
//            else if (section == 1)
//            {
//                return "Bất động sản mới nhất"
//            }
//            return "Bất động sản được quan tâm nhiều"
//        }
//        
//            if (section == 0)
//            {
//                return "Bất động sản đang quản lý"
//            }
//        
//                return "Bất động sản mới nhất"
//            
//        
//        
//    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        
        
        
        
        view.backgroundColor = UIColor(cgColor: #colorLiteral(red: 0.9395621827, green: 0.9395621827, blue: 0.9395621827, alpha: 1).cgColor)
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 16)
        if (role == 0)
        {
            if (section == 0)
            {
                title.text = "Bất động sản đang quan tâm"
            }
            else if (section == 1)
            {
                title.text = "Bất động sản mới nhất"
            }
        }
        else
        {
            if ( section == 0)
            {
                title.text = "Bất động sản đang quản lý"
            }
            else
            {
                title.text = "Bất động sản mới nhất"
            }
        }
        title.frame = CGRect(x: 5, y: 5, width: self.view.frame.width * 0.75, height: 15)
        view.addSubview(title)
        
        
        let more = UILabel()
        more.text = ">"
        more.frame = CGRect(x: self.view.frame.width - 20, y: 5, width: 10, height: 15)
        view.addSubview(more)
        
        if (section == 0)
        {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
       // tapRecognizer.delegate = self
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tapRecognizer)
        }
        else
        {
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap2))
            // tapRecognizer.delegate = self
            tapRecognizer.numberOfTapsRequired = 1
            tapRecognizer.numberOfTouchesRequired = 1
            view.addGestureRecognizer(tapRecognizer)
        }
        return view
        
        
    }
    func handleTap(gestureRecognizer: UIGestureRecognizer)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabbar = storyboard.instantiateViewController(withIdentifier: "SeemoreViewController") as! SeemoreViewController
        if (role == 0)
        {
            tabbar.role = 0
        }
        else if (role == 1)
        {
            tabbar.role = 1
        }
        tabbar.idUser = idUser
        self.navigationController?.pushViewController(tabbar, animated: true)
    }
    func handleTap2(gestureRecognizer: UIGestureRecognizer)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabbar = storyboard.instantiateViewController(withIdentifier: "SeemoreViewController") as! SeemoreViewController
        tabbar.role = 2
        tabbar.idUser = idUser
        self.navigationController?.pushViewController(tabbar, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if ( role == 0)
        {
            if ( indexPath.section == 0)
            {
                if (isLogin)
                {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BatDongSanControllerTableViewCell
                    
                    
                    let data:Data = Data(base64Encoded: mang[indexPath.row].image)!
                    cell.myHouse.image = UIImage(data: data)
                    
                    cell.lblGia.text = String(mang[indexPath.row].gia) + " triệu"
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
                    cell.lblDate.text = String(x) + " ngày trước"
                    cell.lblTitle.text = mang[indexPath.row].title
                    
                    return cell
                }
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell3") as! ChuaLogInBuyerTableViewCell
                
                
              
                
                return cell
                
                
                
            }
            
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BatDongSanControllerTableViewCell
                //cell.myHouse.image = UIImage(named: zzzsmang2[indexPath.row].image + ".jpg")
                let data:Data = Data(base64Encoded: mang2[indexPath.row].image)!
                cell.myHouse.image = UIImage(data: data)
                cell.lblGia.text = String(mang2[indexPath.row].gia) + " triệu"
                cell.lblDIenTich.text = String(mang2[indexPath.row].dientich) + " m2"
            if (check(x: mang2[indexPath.row].quan))
            {
                cell.lblQuan.text = "Quận " + mang2[indexPath.row].quan
            }
            else
            {
                cell.lblQuan.text = "Huyện " + mang2[indexPath.row].quan
            }
            
            let parsed = parseDateTime(str: mang2[indexPath.row].date)
            let start = changeFormatDateAfterParse(x: parsed)
            let end = getCurrentDate()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let first:NSDate = dateFormatter.date(from: start) as! NSDate
            let second:NSDate = dateFormatter.date(from: end) as! NSDate
            let x = daysBetween(start: first as Date, end: second as Date)
            cell.lblDate.text = String(x) + " ngày trước"
                cell.lblTitle.text = mang2[indexPath.row].title
                return cell
            
           
            
        }
        
       
       
        if ( indexPath.section == 0)
        {
            if (!isLogin)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell2")
                return cell!
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BatDongSanControllerTableViewCell
            
            
            let data:Data = Data(base64Encoded: mang3[indexPath.row].image)!
            cell.myHouse.image = UIImage(data: data)
            
            cell.lblGia.text = String(mang3[indexPath.row].gia) + " triệu"
            cell.lblDIenTich.text = String(mang3[indexPath.row].dientich) + " m2"
            if (check(x: mang3[indexPath.row].quan))
            {
                cell.lblQuan.text = "Quận " + mang3[indexPath.row].quan
            }
            else
            {
                cell.lblQuan.text = "Huyện " + mang3[indexPath.row].quan
            }
           // cell.lblDate.text = mang3[indexPath.row].date
            let parsed = parseDateTime(str: mang3[indexPath.row].date)
            let start = changeFormatDateAfterParse(x: parsed)
            let end = getCurrentDate()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let first:NSDate = dateFormatter.date(from: start) as! NSDate
            let second:NSDate = dateFormatter.date(from: end) as! NSDate
            let x = daysBetween(start: first as Date, end: second as Date)
            cell.lblDate.text = String(x) + " ngày trước"
            cell.lblTitle.text = mang3[indexPath.row].title
            
            return cell
            
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BatDongSanControllerTableViewCell
        //cell.myHouse.image = UIImage(named: mang2[indexPath.row].image + ".jpg")
        let data:Data = Data(base64Encoded: mang2[indexPath.row].image)!
        cell.myHouse.image = UIImage(data: data)
        cell.lblGia.text = String(mang2[indexPath.row].gia)
        cell.lblDIenTich.text = String(mang2[indexPath.row].dientich)
        cell.lblQuan.text = mang2[indexPath.row].quan
        let parsed = parseDateTime(str: mang2[indexPath.row].date)
        let start = changeFormatDateAfterParse(x: parsed)
        let end = getCurrentDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let first:NSDate = dateFormatter.date(from: start) as! NSDate
        let second:NSDate = dateFormatter.date(from: end) as! NSDate
        let x = daysBetween(start: first as Date, end: second as Date)
        cell.lblDate.text = String(x) + " ngày trước"
        cell.lblTitle.text = mang2[indexPath.row].title
        return cell
        
        
       
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if ( role == 0)
        {
            if ( indexPath.section == 0)
            {
                if (!isLogin)
                {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let tabbar = storyboard.instantiateViewController(withIdentifier: "login") as! LogInViewController
                    
                    tabbar.storyboardID = "EstateDetailBuyer"
                    self.navigationController?.pushViewController(tabbar, animated: true)
                }
                else
                {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let tabbar = storyboard.instantiateViewController(withIdentifier: "EstateDetailBuyer") as! EstateDetailBuyerController
                    tabbar.idOwner = mang[indexPath.row].idOwner
                    tabbar.idEstate = mang[indexPath.row].ID
                    tabbar.idUser = idUser
                    tabbar.passEstate = mang[indexPath.row]
                    tabbar.passOwner = nameOwner[indexPath.row]
                    tabbar.passAdress = addressOwner[indexPath.row]
                    tabbar.isLogin = isLogin
                    tabbar.role = self.role
                   
                    
                    
                    self.navigationController?.pushViewController(tabbar, animated: true)
                }
            }
            else
            {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let tabbar = storyboard.instantiateViewController(withIdentifier: "EstateDetailBuyer") as! EstateDetailBuyerController
                tabbar.idOwner = mang2[indexPath.row].idOwner
                tabbar.idEstate = mang2[indexPath.row].ID
                tabbar.idUser = idUser
                //   tabbar.status = temp!
                tabbar.passEstate = mang2[indexPath.row]
                tabbar.passOwner = nameOwner2[indexPath.row]
                tabbar.passAdress = addressOwner2[indexPath.row]
                tabbar.isLogin = self.isLogin
                tabbar.role = role
                
                self.navigationController?.pushViewController(tabbar, animated: true)
            }
        }
        
        else
        {
            if (indexPath.section == 0)
            {
                if (!isLogin)
                {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let tabbar = storyboard.instantiateViewController(withIdentifier: "login") as! LogInViewController
                    
                    tabbar.storyboardID = "BDS"
                    self.navigationController?.pushViewController(tabbar, animated: true)
                }
                else
                {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let tabbar = storyboard.instantiateViewController(withIdentifier: "EstateDetailBuyer") as! EstateDetailBuyerController
                    
                    tabbar.idEstate = mang3[indexPath.row].ID
                    tabbar.isLogin = self.isLogin
                    tabbar.idUser = idUser
                    tabbar.role = role
                    tabbar.idOwner = mang3[indexPath.row].idOwner
                    
                    self.navigationController?.pushViewController(tabbar, animated: true)
                }
            }
            else
            {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let tabbar = storyboard.instantiateViewController(withIdentifier: "EstateDetailBuyer") as! EstateDetailBuyerController
                
                tabbar.idEstate = mang2[indexPath.row].ID
                tabbar.idOwner = mang2[indexPath.row].idOwner
                tabbar.isLogin = self.isLogin
                tabbar.idUser = idUser
                tabbar.role = role
                
                self.navigationController?.pushViewController(tabbar, animated: true)
            }
        }
        
        
    
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let xoa = UITableViewRowAction(style: .default, title: "xoa") { (action:UITableViewRowAction, index:IndexPath) in
           // print ("fuck")
            
            if (index.section == 0)
            {
                self.mang.remove(at: index.row)
                self.myTbv.deleteRows(at: [index], with: .fade)
            }
            else if (index.section == 1)
            {
                self.mang2.remove(at: index.row)
                self.myTbv.deleteRows(at: [index], with: .fade)
            }
            
           
            
        }
        
        return [xoa]
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
//        var navigationBarAppearace = UINavigationBar.appearance()
//        
//        navigationBarAppearace.barTintColor = UIColor(cgColor: #colorLiteral(red: 0.2352941176, green: 0.3529411765, blue: 0.6078431373, alpha: 1).cgColor)
//        navigationBarAppearace.tintColor = UIColor(cgColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor)
        // 3
        
        // 5
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "edit3.png"), style: .done, target: self, action: #selector(DangBai))
        
        
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        // 4
        let image = UIImage(named: "swift2.png")
        imageView.image = image
        navigationItem.titleView = imageView
    }
    func DangBai()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabbar = storyboard.instantiateViewController(withIdentifier: "DangBai") as! DangBaiViewController
        self.navigationController?.pushViewController(tabbar, animated: true)
    }
    
    @IBAction func actionDangBai(_ sender: Any) {
        if (isLogin)
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabbar = storyboard.instantiateViewController(withIdentifier: "DangMoi") as! DangMoiViewController
            
            tabbar.idOwner = idUser
            
            self.navigationController?.pushViewController(tabbar, animated: true)
        }
        else
        {
            login()
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
            NSLog("Cancel Pressed")
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
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
    
    
    
}
