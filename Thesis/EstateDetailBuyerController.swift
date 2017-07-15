//
//  EstateDetailBuyerController.swift
//  Thesis
//
//  Created by TriQuach on 4/6/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
import UIKit
import M13Checkbox
class EstateDetailBuyerController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var btnDienTich: UIButton!
    @IBOutlet weak var btnGia: UIButton!
    @IBOutlet weak var btnCapNhatGhiChu: UIButton!
    @IBOutlet weak var btnDaBan: UIButton!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var outletDatLichHen: UIButton!
    @IBOutlet weak var edtNote: UITextField!
    @IBOutlet weak var tvNote: UITextView!
    @IBOutlet weak var loading3: UIActivityIndicatorView!
    
    @IBOutlet weak var lblEdit: UILabel!
    @IBOutlet weak var lblPosdate: UILabel!
    @IBOutlet weak var passImg: UIImageView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var lblLoai: UILabel!
    @IBOutlet weak var lblMoTa: UILabel!
    @IBOutlet weak var lblTinhTrang: UILabel!
    @IBOutlet weak var lblSoPhongTam: UILabel!
    @IBOutlet weak var lblSoPhongNgu: UILabel!
    @IBOutlet weak var lblSoTang: UILabel!
    @IBOutlet weak var lblRong: UILabel!
    @IBOutlet weak var lblDai: UILabel!
    @IBOutlet weak var lblDienTich: UILabel!
    @IBOutlet weak var lblAdressEstate: UILabel!
    @IBOutlet weak var lblOwner: UILabel!
    @IBOutlet weak var lblName: UILabel!
  //  var passFullEstate:FullEstate!
    @IBOutlet weak var myClv2: UICollectionView!
    @IBOutlet weak var myClv: UICollectionView!
    var arrayImage:[UIImage]?
    @IBOutlet weak var lblGhiChu: UILabel!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var lbl: UILabel!
    var idOwner:Int!
    var idUser: Int!
    var idEstate:Int!
    var mangImage:[String] = []
    var photos:[Photo] = []
    var isLogin:Bool!
    var role:Int!
    var takenImage = UIImage(named: "add2.png")
    let estates = ["house1", "house2","house3"]
    let descrip = ["abc","xyx","asd"]
    var count:Int = 0
    var name_house:String?
    var mang:[UIImage] = []
    var passFullEstate:FullEstate!
    
    var passEstate:Estate!
    var passOwner:String!
    var passAdress:String!
    var clickImgView:UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnDaBan.ghostButton()
        btnDienTich.ghostButton()
        btnGia.ghostButton()
        btnCapNhatGhiChu.ghostButton()
        navigationController?.delegate = self
        myClv.delegate = self
        myClv.dataSource = self
        
        tvNote.layer.borderWidth = 1
        tvNote.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        if ( !isLogin )
        {
            tvNote.isEditable = false
        }
        
        loading3.isHidden = true
        outletDatLichHen.isEnabled = false
        
        arrayImage = []
    //    parsePassedFullEstate()
        
        print ("owner" + String(idOwner))
        print ("User" + String(idUser))
        
        print ("idEstate:" + String(idEstate))
        loading.startAnimating()
        self.title = "Chi tiết BĐS"
       
       getAvatar()
        
    }
    
    func getEstateBaseOnID()
    {
        
        let req = URLRequest(url: URL(string: "http://rem-bt.azurewebsites.net/rem/rem_server/estate/getDetail/" + String(idEstate))!)
        
        let task = URLSession.shared.dataTask(with: req) { (d, u, e) in
            
            do
            {
                
                let json = try JSONSerialization.jsonObject(with: d!, options: .allowFragments) as! AnyObject
                DispatchQueue.main.async {
                    self.lblSoPhongTam.text = String(json["bathroom"] as! Int)
                    self.lblSoPhongNgu.text = String(json["bedroom"] as! Int)
                    self.lblTinhTrang.text = json["condition"] as! String
                    self.lblMoTa.text = json["description"] as! String
                    self.lblSoTang.text = String(json["floor"] as! Int)
                    self.lblDai.text = String(json["length"] as! Double)
                    self.lblRong.text = String(json["width"] as! Double)
                    self.parsePassEstate()
                    self.getPhotoList()
                }
                
                
            }catch{}
        }
        task.resume()
    }
    func getPhotoList()
    {
        
        let req = URLRequest(url: URL(string: "http://rem-bt.azurewebsites.net/rem/rem_server/estate/getPhotoList/" + String(idEstate))!)
        
        let task = URLSession.shared.dataTask(with: req) { (d, u, e) in
            
            do
            {
                
                let json = try JSONSerialization.jsonObject(with: d!, options: .allowFragments) as! AnyObject
                let photos = json["photos"] as! [AnyObject]
                for i in 0..<photos.count
                {
                    let photo = photos[i]["photo"] as! String
                    self.mangImage.append(photo)
                }
                
                DispatchQueue.main.async {
                    
                    self.myClv2.delegate = self
                    self.myClv2.dataSource = self
                    self.myClv2.reloadData()
                    self.getNote()
                }
                
                
            }catch{}
        }
        task.resume()
    }
    
    func parsePassEstate()
    {

        
        lblName.text = passEstate.title
        btnGia.setTitle(String(passEstate.gia), for: .normal)
        btnDienTich.setTitle(String(passEstate.dientich), for: .normal)
        lblAdressEstate.text = passAdress
        lblOwner.text = passOwner
        let data:Data = Data(base64Encoded: passEstate.image)!
        passImg.image = UIImage(data: data)
        
    
    }
    
   
    @IBAction func btnHen(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabbar = storyboard.instantiateViewController(withIdentifier: "login") as! LogInViewController
        tabbar.id = "EstateDetailBuyer"
        self.navigationController?.pushViewController(tabbar, animated: true)
        
    }
    
    
    
    
    
    
    
    @IBAction func btnActionCamera(_ sender: Any) {
        
        
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        takenImage = (info[UIImagePickerControllerOriginalImage] as! UIImage?)!
        self.dismiss(animated: true, completion: nil)
        
        self.mang.remove(at: mang.count-1)
        self.mang.append(takenImage!)
        self.mang.append(UIImage(named: "add4.png")!)
        self.myClv.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        if ( collectionView.tag == 0)
        {
            return mang.count
        }
        return mangImage.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     //   print(arrayImage?.count)
            
      //  print(arrayImage?[indexPath.row])
        if ( collectionView.tag == 0)
        {
            if ( indexPath.row == mang.count - 1)
            {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath)
                return cell
            }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyImageCollectionViewCell
        cell.myImg.image = mang[indexPath.row]
        return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! ImageServerCollectionViewCell
        let data:Data = Data(base64Encoded: mangImage[indexPath.row])!
        cell.myImg.image = UIImage(data: data)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 2.5
        let hardCodedPadding:CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if ( collectionView.tag == 0)
        {
            if ( self.isLogin )
            {
                if (indexPath.row == mang.count - 1)
                {
                    let myPicker = UIImagePickerController()
                    myPicker.delegate = self
                    myPicker.sourceType = .photoLibrary
                    present(myPicker, animated: true, completion: nil)
                }
                else
                {
                    let newImageView = UIImageView(image: self.mang[indexPath.row])
                    
                    
                    newImageView.frame = UIScreen.main.bounds
                    
                    newImageView.backgroundColor = .black
                    newImageView.contentMode = .scaleAspectFit
                    newImageView.isUserInteractionEnabled = true
                    let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
                    newImageView.addGestureRecognizer(tap)
                    self.view.addSubview(newImageView)
                    self.navigationController?.isNavigationBarHidden = true
                    self.tabBarController?.tabBar.isHidden = true
                }
            }
            else
            {
                self.login()
            }
        }
        else
        {
            let data:Data = Data(base64Encoded: mangImage[indexPath.row])!
            let newImageView = UIImageView(image: UIImage(data: data))
            newImageView.frame = UIScreen.main.bounds
            
            newImageView.backgroundColor = .black
            newImageView.contentMode = .scaleAspectFit
            newImageView.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
            newImageView.addGestureRecognizer(tap)
            self.view.addSubview(newImageView)
            self.navigationController?.isNavigationBarHidden = true
            self.tabBarController?.tabBar.isHidden = true
        }
        
    }
    func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    override func viewDidAppear(_ animated: Bool) {
//        var nav = self.navigationController?.navigationBar
//        // 2
//        nav?.barStyle = UIBarStyle.black
//        nav?.tintColor = UIColor.white
        // 3
        
        // 5
        if (self.role == 1 || self.role == 2)
        {
            if (idUser == idOwner)
            {
                navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "edit3.png"), style: .done, target: self, action: #selector(DangBai))
            }
        }
        
        
        
    }
    func DangBai()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabbar = storyboard.instantiateViewController(withIdentifier: "EditEstateViewController") as! EditEstateViewController
        tabbar.idUser = idUser
        tabbar.idOwner = idOwner
        tabbar.role = role
        tabbar.isLogin = isLogin
        tabbar.idEstate = idEstate
        
        self.navigationController?.pushViewController(tabbar, animated: true)
    }
    @IBAction func btnDatLichHen(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabbar = storyboard.instantiateViewController(withIdentifier: "DatHen") as! DatHenViewController
        
        if ( isLogin )
        {
            //  tabbar.owner = passFullEstate.owner.fullName
            tabbar.idUser = idUser
            tabbar.idOwner = idOwner
            tabbar.role = self.role
            tabbar.owner = self.passFullEstate.owner.fullName
            tabbar.datLichHen = passFullEstate.name
            tabbar.passAdress = passFullEstate.address.address + " " + passFullEstate.address.ward + " " + passFullEstate.address.district + " " + passFullEstate.address.city
            tabbar.idEstate = idEstate
            self.navigationController?.pushViewController(tabbar, animated: true)
        }
        else
        {
//            let alert = UIAlertController(title: "Lỗi", message: "Bạn phải đăng nhập!", preferredStyle: UIAlertControllerStyle.alert)
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
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
    @IBAction func actionThemGhiChu(_ sender: Any) {
        if (isLogin)
        {
        loading3.isHidden = false
        loading3.startAnimating()
        let Note = self.tvNote.text
        print ("note:" + Note!)
        let noteUpdate:NoteUpdate = NoteUpdate(userId: idUser, estateId: idEstate, note: Note!)
        
    //    let json = JSONSerializer.toJson(noteUpdate)
        
        
        var jsonObject = Dictionary<String, Any>()
        jsonObject["UserID"] = idUser
        jsonObject["EstateID"] = idEstate
        jsonObject["Note"] = Note
        
        
        
        
        print (jsonObject)
        
       // let jsonObject = convertToDictionary(text: json)
        
      //  print (jsonObject)
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject)
        
        var req = URLRequest(url: URL(string: "http://rem-bt.azurewebsites.net/rem/rem_server/user/updateNote")!)
        
        
        
        req.httpMethod = "POST"
        req.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            
            
            do
            {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as AnyObject
                
                print (json["message"] as! String)
                
                DispatchQueue.main.async {
                    //self.loading3.isHidden = true
                    self.photoNote()
                }
                
                
                
                
            }catch{}
            
            
        }
        task.resume()
        
        }
        else
        {
            login()
        }
        
    }
    func photoNote()
    {
        self.parseImageNote()
        let photoNote:PhotoNote = PhotoNote(UserID: idUser, EstateID: idEstate, photos: photos)
        
        let json = JSONSerializer.toJson(photoNote)
        print (json)
        
        let jsonObject = convertToDictionary(text: json)
        
        //  print (jsonObject)
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject)
        
        var req = URLRequest(url: URL(string: "http://rem-bt.azurewebsites.net/rem/rem_server/user/upPhotoNote")!)
        
        
        
        req.httpMethod = "POST"
        req.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            
            
            do
            {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as AnyObject
                
                print (json["message"] as! String)
                
                DispatchQueue.main.async {
                    self.loading3.isHidden = true
                    
                }
                
                
                
                
            }catch{}
            
            
        }
        task.resume()
        
    }
    func parseImageNote()
    {
        for i in 0..<mang.count-1
        {
            let string = mang[i].base64(format: .jpeg(0.01))
            let photo:Photo = Photo(photo: string!)
            self.photos.append(photo)
        }
    }
    func getNote()
    {
        let req = URLRequest(url: URL(string: "http://rem-bt.azurewebsites.net/rem/rem_server/user/getNote/" + String(idUser) + "-" + String(idEstate))!)
        
        let task = URLSession.shared.dataTask(with: req) { (d, u, e) in
            
            do
            {
                
                let json = try JSONSerialization.jsonObject(with: d!, options: .allowFragments) as! AnyObject
                let note = json["note"] as! String
                
                
                DispatchQueue.main.async {
                    self.tvNote.text = note
                    self.getPhotoNote()
                }
                
                
            }catch{}
        }
        task.resume()
    }
    func getPhotoNote()
    {
       // self.mang = []
        
        let req = URLRequest(url: URL(string: "http://rem-bt.azurewebsites.net/rem/rem_server/user/getPhotoNote/" + String(idUser) + "-" + String(idEstate))!)
        
        let task = URLSession.shared.dataTask(with: req) { (d, u, e) in
            
            do
            {
                
                let json = try JSONSerialization.jsonObject(with: d!, options: .allowFragments) as! AnyObject
                let photos = json["photos"] as! [AnyObject]
                for i in 0..<photos.count
                {
                    let string = photos[i]["photo"] as! String
                    let data:Data = Data(base64Encoded: string)!
                    let photo:UIImage = UIImage(data: data)!
                    self.mang.append(photo)
                }
                
                DispatchQueue.main.async {
                    self.loading.isHidden = true
                    self.mang.append(self.takenImage!)
                   self.myClv.reloadData()
                    
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
    func getJsonEstate()
    {
        
        let req = URLRequest(url: URL(string: "http://rem-bt.azurewebsites.net/rem/rem_server/estate/getByID/" + String(idEstate))!)
        
        let task = URLSession.shared.dataTask(with: req) { (d, u, e) in
            
            
            do
            {
                
                let json = try JSONSerialization.jsonObject(with: d!, options: .allowFragments) as! AnyObject
                
                let user = json["owner"] as AnyObject
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
                
                let detailAddress = json["address"] as AnyObject
                let city = detailAddress["city"] as! String
                let district = detailAddress["district"] as! String
                let ward = detailAddress["ward"] as! String
                let address2 = detailAddress["address"] as! String
                let id2 = detailAddress["id"] as! Int
                
                let newAdress:Address = Address(city: city, district: district, ward: ward, address: address2, id: id2)
                
                let detail = json["detail"] as AnyObject
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
                
                let newDetail:Detail = Detail(bathroom: bathroom, bedroom: bedroom, condition: condition, description: description, floor: floor, length: length, width: width, longitude: longitude, latitude: latitude, id: idDetail)
                
                //    print (newDetail.description)
                
                
                
                let available = json["available"] as! Bool
                let type = json["type"] as! String
                let postTime = json["postTime"] as! String
                let editTime = json["editTime"] as! String
                let price = json["price"] as! Double
                let area = json["area"] as! Double
                let id3 = json["id"] as! Int
                let name3 = json["name"] as! String
                
                let newFullEstate:FullEstate = FullEstate(owner: newUser, address: newAdress, detail: newDetail, available: available, type: type, postTime: postTime, editTime: editTime, price: price, area: area, id: id3, name: name3)
                
                //   self.mang.append(newFullEstate)
                
                
                
                
                
                DispatchQueue.main.async(execute: {
                  //  self.idOwner = newFullEstate.owner.id
                    self.outletDatLichHen.isEnabled = true
                    self.passFullEstate = newFullEstate
                    if (newFullEstate.detail.bathroom == 0 || newFullEstate.detail.bathroom == -1)
                    {
                        self.lblSoPhongTam.text = "Không xác định"
                    }
                    else
                    {
                    self.lblSoPhongTam.text = String(newFullEstate.detail.bathroom)
                    }
                    if (newFullEstate.detail.bedroom == 0 || newFullEstate.detail.bedroom == -1)
                    {
                        self.lblSoPhongNgu.text = "Không xác định"
                    }
                    else
                    {
                    self.lblSoPhongNgu.text = String(newFullEstate.detail.bedroom)
                    }
                    self.lblTinhTrang.text = newFullEstate.detail.condition
                    self.lblMoTa.text = newFullEstate.detail.description
                    if (newFullEstate.detail.floor == 0 || newFullEstate.detail.floor == -1)
                    {
                        self.lblSoTang.text = "Không xác định"
                    }
                    else
                    {
                    self.lblSoTang.text = String(newFullEstate.detail.floor)
                    }
                    if (newFullEstate.detail.length == 0 || newFullEstate.detail.length == -1)
                    {
                        self.lblDai.text = "Không xác định"
                    }
                    else
                    {
                    self.lblDai.text = String(newFullEstate.detail.length)
                    }
                    if (newFullEstate.detail.width == 0 || newFullEstate.detail.width == -1)
                    {
                        self.lblRong.text = "Không xác định"
                    }
                    else
                    {
                    self.lblRong.text = String(newFullEstate.detail.width)
                    }
                        self.lblName.text = newFullEstate.name
                    self.lblOwner.text = newFullEstate.owner.fullName
                    self.lblAdressEstate.text = newFullEstate.address.city
                    self.lblPosdate.text = newFullEstate.postTime
                    self.lblEdit.text = newFullEstate.editTime
                    self.lblLoai.text = newFullEstate.type
                    //self.idOwner = newFullEstate.owner.id
                    if (newFullEstate.area == 0 || newFullEstate.area == -1)
                    {
                        self.btnDienTich.setTitle("Không xác định", for: .normal)
                    }
                    else
                    {
                        self.btnDienTich.setTitle(String(newFullEstate.area) + " m2", for: .normal)
                    }
                    if (newFullEstate.price == 0 || newFullEstate.price == -1)
                    {
                        self.btnGia.setTitle("Không xác định", for: .normal)
                    }
                    else
                    {
                        self.btnGia.setTitle(String(newFullEstate.price) + " triệu", for: .normal)
                    }
                        self.getPhotoList()
                    
                    
                })
            }catch{}
        }
        task.resume()
        
        
        
        
        
        
    }
    func getAvatar()
    {
        let req = URLRequest(url: URL(string: "http://rem-bt.azurewebsites.net/rem/rem_server/estate/getRepresentPhoto/" + String(idEstate))!)
        
        let task = URLSession.shared.dataTask(with: req) { (d, u, e) in
            
            
            do
            {
                
                let json = try JSONSerialization.jsonObject(with: d!, options: .allowFragments) as! AnyObject
                
                let string = json["photo"] as! String
                
                
                
                DispatchQueue.main.async(execute: {
                    let data:Data = Data(base64Encoded: string)!
                    self.passImg.image = UIImage(data: data)
                    self.getJsonEstate()
                })
            }catch{}
        }
        task.resume()
    }
    @IBAction func actionMap(_ sender: Any) {
        let alert = UIAlertController(title: "Thông báo", message: "Tính năng đang phát triển", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func remove(_ sender: Any) {
        
    }
    @IBAction func actionLike(_ sender: Any) {
        if (btnLike.isEnabled == true)
        {
            btnLike.isEnabled = false
        }
        else
        {
            btnLike.isEnabled = true
        }
    }
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
       
       
    }
}
