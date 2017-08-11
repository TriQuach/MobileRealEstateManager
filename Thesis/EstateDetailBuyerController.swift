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
class EstateDetailBuyerController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource,UIAlertViewDelegate {
    
    let alert = UIAlertView()
    let alert2 = UIAlertView()
    var idBuyer:Int!
    var idOwner:Int!
    var idEstate2:Int!
    var nameBuyer:String!
    var isAnswered:Bool = false
    var idQuestion:Int!
    var index:Int!
    
    @IBOutlet weak var lblRong2: UILabel!
    @IBOutlet weak var lblDai2: UILabel!
    @IBOutlet weak var myTbv: UITableView!
    @IBOutlet weak var btnNote: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var lblNote: UILabel!
    @IBOutlet weak var lblDienTich: UILabel!
    @IBOutlet weak var lblGia: UILabel!
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
    //var passFullEstate:FullEstate!
    var idOwner2:Int!
    var idUser: Int!
    var idEstate:Int!
    var mangBuyer:[String] = []
    var mangQuestion:[String] = []
    var mangAnswer:[String] = []
    var mangIdQuestion:[Int] = []
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
    var isInterested:Bool!
    var isShownNote:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  btnDaBan.ghostButton()
       myTbv.dataSource = self
        myTbv.delegate = self
      //  btnCapNhatGhiChu.ghostButton()
        navigationController?.delegate = self
        
        myClv.delegate = self
        myClv.dataSource = self
        tvNote.isHidden = true
        
        //lblNote.isHidden = true
        tvNote.layer.borderWidth = 1
        tvNote.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        if ( !isLogin )
        {
            tvNote.isEditable = false
        }
        
        loading3.isHidden = true
        outletDatLichHen.isEnabled = false
        
        arrayImage = []
        self.mang.append(UIImage(named: "add4.png")!)
    //    parsePassedFullEstate()
        
        print ("owner" + String(idOwner))
        print ("User" + String(idUser))
        
        print ("idEstate:" + String(idEstate))
        loading.startAnimating()
        self.title = "Chi tiết BĐS"
        
        if (self.role == 1 || self.role == 2)
        {
            if (idUser != idOwner)
            {
                self.btnDaBan.isEnabled = false
            }
        }
        
       checkInterested()
        
    }
    
    func getEstateBaseOnID()
    {
        
        let req = URLRequest(url: URL(string: "http://35.194.220.127/rem/rem_server/estate/getDetail/" + String(idEstate))!)
        
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
        
        let req = URLRequest(url: URL(string: "http://35.194.220.127/rem/rem_server/estate/getPhotoList/" + String(idEstate))!)
        
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
        //btnGia.setTitle(String(passEstate.gia), for: .normal)
        lblGia.text = String(passEstate.gia)
       // btnDienTich.setTitle(String(passEstate.dientich), for: .normal)
        lblDienTich.text = String(passEstate.dientich)
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
        
        
        self.mang.append(takenImage!)
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
            if ( indexPath.row == 0)
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
                if (indexPath.row == 0)
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
                navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "edit9.png"), style: .done, target: self, action: #selector(DangBai))
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
        
        var req = URLRequest(url: URL(string: "http://35.194.220.127/rem/rem_server/user/updateNote")!)
        
        
        
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
        
        var req = URLRequest(url: URL(string: "http://35.194.220.127/rem/rem_server/user/upPhotoNote")!)
        
        
        
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
        for i in 1..<mang.count
        {
            let string = mang[i].base64(format: .jpeg(0.01))
            let photo:Photo = Photo(photo: string!)
            self.photos.append(photo)
        }
    }
    func getNote()
    {
        let req = URLRequest(url: URL(string: "http://35.194.220.127/rem/rem_server/user/getNote/" + String(idUser) + "-" + String(idEstate))!)
        
        let task = URLSession.shared.dataTask(with: req) { (d, u, e) in
            
            do
            {
                
                let json = try JSONSerialization.jsonObject(with: d!, options: .allowFragments) as! AnyObject
                let note = json["note"] as! String
                
                
                DispatchQueue.main.async {
                    self.tvNote.text = note
                    self.lblNote.text = note
                    self.getPhotoNote()
                }
                
                
            }catch{}
        }
        task.resume()
    }
    func getPhotoNote()
    {
       // self.mang = []
        
        let req = URLRequest(url: URL(string: "http://35.194.220.127/rem/rem_server/user/getPhotoNote/" + String(idUser) + "-" + String(idEstate))!)
        
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
                 //   self.mang.append(self.takenImage!)
                   self.myClv.reloadData()
                    if (self.role == 0)
                    {
                        self.getComment()
                    }
                    else if ( self.role == 1 )
                    {
                        self.getCommentOwner()
                    }
                    
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
        
        let req = URLRequest(url: URL(string: "http://35.194.220.127/rem/rem_server/estate/getByID/" + String(idEstate))!)
        
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
                let newUser:User = User(email: email, password: password, address: address, typeID: typeID, fullName: fullName,phone: phone, id: id, name: name, avatar: "")
                
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
                    if (newFullEstate.available == false)
                    {
//                      //  self.btnCapNhatGhiChu.isEnabled = false
                        self.tvNote.isEditable = false
                        self.myClv.allowsSelection = false
                        self.btnDaBan.isEnabled = false
                    }
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
                        self.lblDai.textColor = UIColor(cgColor: #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1).cgColor)
                    }
                    else
                    {
                    self.lblDai.text = String(newFullEstate.detail.length)
                    }
                    if (newFullEstate.detail.width == 0 || newFullEstate.detail.width == -1)
                    {
                        self.lblRong.text = "Không xác định"
                        self.lblRong.textColor = UIColor(cgColor: #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1).cgColor)
                    }
                    else
                    {
                    self.lblRong.text = String(newFullEstate.detail.width)
                    }
                    if (newFullEstate.available == false)
                    {
                        self.lblName.text = "Đã bán " + newFullEstate.name
                    }
                    else
                    {
                        self.lblName.text = newFullEstate.name
                    }
                    self.lblOwner.text = newFullEstate.owner.fullName
                    self.lblAdressEstate.text = newFullEstate.address.address + " " + newFullEstate.address.ward + " " + newFullEstate.address.district + " " + newFullEstate.address.city
                  //  self.lblPosdate.text = newFullEstate.postTime
                    
                    self.lblEdit.text = newFullEstate.editTime
                    self.lblLoai.text = newFullEstate.type
                    //self.idOwner = newFullEstate.owner.id
                    if (newFullEstate.area == 0 || newFullEstate.area == -1)
                    {
                        self.lblDienTich.text = "Không xác định"
                    }
                    else
                    {
                        self.lblDienTich.text = String(newFullEstate.area) + " m2"
                    }
                    if (newFullEstate.price == 0 || newFullEstate.price == -1)
                    {
                        self.lblGia.text = "Không xác định"
                    }
                    else
                    {
                        self.lblGia.text = String(newFullEstate.price) + " triệu"
                    }
                        self.getPhotoList()
                    
                    
                })
            }catch{}
        }
        task.resume()
        
        
        
        
        
        
    }
    func getAvatar()
    {
        let req = URLRequest(url: URL(string: "http://35.194.220.127/rem/rem_server/estate/getRepresentPhoto/" + String(idEstate))!)
        
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
        self.loading.isHidden = false
        self.loading.startAnimating()
        if (isInterested)
        {
            isInterested = false
            self.btnLike.setImage(UIImage(named: "like8.png"), for: .normal)
            likeRequest(index: 0)
        }
        else
        {
            isInterested = true
            self.btnLike.setImage(UIImage(named: "like9.png"), for: .normal)
            likeRequest(index: 3)
        }
        
    }
    func likeRequest(index: Int)
    {
        let req = URLRequest(url: URL(string: "http://35.194.220.127/rem/rem_server/user/setInterested/" + String(idUser) + "-" + String(idEstate) + "-" + String(index))!)
        
        let task = URLSession.shared.dataTask(with: req) { (d, u, e) in
            
            
            do
            {
                
                let json = try JSONSerialization.jsonObject(with: d!, options: .allowFragments) as! AnyObject
                if (json["statuskey"] as! Bool)
                {
                    DispatchQueue.main.async {
                        self.loading.isHidden = true
                    }
                }
                else
                {
                    let alert = UIAlertController(title: "Lỗi", message: json["message"] as! String, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                DispatchQueue.main.async {
                    self.getAvatar()
                }
                
            }catch{}
        }
        task.resume()
    }
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        print ("clicked")
        
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        print ("will disapear")
    }
    func checkInterested()
    {
        let req = URLRequest(url: URL(string: "http://35.194.220.127/rem/rem_server/user/checkInterested/"  + String(idUser) + "-" + String(idEstate))!)
        
        let task = URLSession.shared.dataTask(with: req) { (d, u, e) in
            
            
            do
            {
                
                let json = try JSONSerialization.jsonObject(with: d!, options: .allowFragments) as! AnyObject
                if (json["statuskey"] as! Bool)
                {
                    DispatchQueue.main.async {
                        if (json["interested"] as! Bool)
                        {
                            self.isInterested = true
                            self.btnLike.setImage(UIImage(named: "like9.png"), for: .normal)
                        }
                        else
                        {
                            self.isInterested = false
                            self.btnLike.setImage(UIImage(named: "like8.png"), for: .normal)
                        }
                    }
                }
                else
                {
                    let alert = UIAlertController(title: "Lỗi", message: json["message"] as! String, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                DispatchQueue.main.async {
                    self.getAvatar()
                }
                
            }catch{}
        }
        task.resume()
    }
    @IBAction func actionDaBan(_ sender: Any) {
        if (role == 0)
        {
            requestDaBanBuyer()
        }
        else
        {
            if (idUser == idOwner)
            {
                requestDaBanOwner()
            }
        }
        
        
    }
    func requestDaBanBuyer()
    {
        let req = URLRequest(url: URL(string: "http://35.194.220.127/rem/rem_server/user/updateRequest/" + String(idUser) + "-" + String(idEstate))!)
        
        let task = URLSession.shared.dataTask(with: req) { (d, u, e) in
            
            
            do
            {
                
                let json = try JSONSerialization.jsonObject(with: d!, options: .allowFragments) as! AnyObject
                if (json["statuskey"] as! Bool)
                {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Thông báo", message: json["message"] as! String, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                else
                {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Lỗi", message: json["message"] as! String, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                
                
            }catch{}
        }
        task.resume()
    }
    func requestDaBanOwner()
    {
        
    }
    
    @IBAction func actionTakeNote(_ sender: Any) {
        
        if (!isShownNote)
        {
            tvNote.isHidden = false
            lblNote.isHidden = true
            isShownNote = true
            self.btnNote.setImage(UIImage(named: "check.png"), for: .normal)
        }
        else
        {
            
            tvNote.isHidden = true
            lblNote.isHidden = false
            lblNote.text = tvNote.text
            self.btnNote.setImage(UIImage(named: "edit8.png"), for: .normal)
            isShownNote = false
            self.themGhiChu()
        }
    }
    
    @IBAction func actionSave(_ sender: Any) {
        tvNote.isHidden = true
        lblNote.isHidden = false
        lblNote.text = tvNote.text
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
    func themGhiChu()
    {
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
            
            var req = URLRequest(url: URL(string: "http://35.194.220.127/rem/rem_server/user/updateNote")!)
            
            
            
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mangQuestion.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell5") as! CommentTableViewCell
            cell.lblBuyer.text = mangBuyer[indexPath.row]
            cell.lblAnswer.text = mangAnswer[indexPath.row]
            cell.lblQuestion.text = mangQuestion[indexPath.row]
            return cell
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (role == 1)
        {
            self.idQuestion = mangIdQuestion[indexPath.row]
            self.index = indexPath.row
            alert2.title = "Trả lời"
            alert2.addButton(withTitle: "Hoàn tất")
            alert2.alertViewStyle = UIAlertViewStyle.plainTextInput
            alert2.addButton(withTitle: "Cancel")
            alert2.delegate = self
            alert2.show()
        }
    }
    func getComment()
    {
        let req = URLRequest(url: URL(string: "http://35.194.220.127/rem/rem_server/estate/getCommentBuyer/" + String(idEstate) + "-" + String(idUser))!)
        
        let task = URLSession.shared.dataTask(with: req) { (d, u, e) in
            
            
            do
            {
                
                let json = try JSONSerialization.jsonObject(with: d!, options: .allowFragments) as! AnyObject
                if (json["statuskey"] as! Bool)
                {
                    let comments = json["comments"] as! [AnyObject]
                    for i in 0..<comments.count
                    {
                        var answer:String = ""
                        if let x = comments[i]["answer"] {
                            if let a = x {
                                answer = a as! String
                            }
                        }
                        
                        let question = comments[i]["question"] as! String
                        
                        let buyer = comments[i]["buyer"] as! String
                        self.nameBuyer = buyer
                        self.idBuyer = comments[i]["buyerId"] as! Int
                        self.idOwner2 = comments[i]["ownerId"] as! Int
                        self.idEstate2 = comments[i]["estateId"] as! Int
                        self.mangBuyer.append(buyer)
                        self.mangQuestion.append(question)
                        self.mangAnswer.append(answer)
                    }
                    DispatchQueue.main.async {
                        self.myTbv.reloadData()
                    }
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
    func getCommentOwner()
    {
        let req = URLRequest(url: URL(string: "http://35.194.220.127/rem/rem_server/estate/getCommentOwner/" + String(idEstate) + "-" + String(idOwner))!)
        
        let task = URLSession.shared.dataTask(with: req) { (d, u, e) in
            
            
            do
            {
                
                let json = try JSONSerialization.jsonObject(with: d!, options: .allowFragments) as! AnyObject
                if (json["statuskey"] as! Bool)
                {
                    let comments = json["comments"] as! [AnyObject]
                    for i in 0..<comments.count
                    {
                        var answer:String = ""
                        if let x = comments[i]["answer"] {
                            if let a = x {
                                answer = a as! String
                            }
                        }
                        
                        let question = comments[i]["question"] as! String
                        let idQuestion = comments[i]["id"] as! Int
                        let buyer = comments[i]["buyer"] as! String
                        self.nameBuyer = buyer
                        self.idBuyer = comments[i]["buyerId"] as! Int
                        self.idOwner2 = comments[i]["ownerId"] as! Int
                        self.idEstate2 = comments[i]["estateId"] as! Int
                        self.mangBuyer.append(buyer)
                        self.mangQuestion.append(question)
                        self.mangAnswer.append(answer)
                        self.mangIdQuestion.append(idQuestion)
                    }
                    DispatchQueue.main.async {
                        self.myTbv.reloadData()
                    }
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
    func changeFormatDateAfterParse(x: String) -> String
    {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "MMM d, yyyy"
        let showDate = inputFormatter.date(from: x)
        inputFormatter.dateFormat = "dd/MM/yyyy"
        let resultString = inputFormatter.string(from: showDate!)
        return resultString
    }
    
    @IBAction func actionPostComment(_ sender: Any) {
        alert.title = "Đặt câu hỏi"
        alert.addButton(withTitle: "Xong")
        alert.alertViewStyle = UIAlertViewStyle.plainTextInput
        alert.addButton(withTitle: "Cancel")
        alert.delegate = self
        alert.show()
    }
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        
        let buttonTitle = alertView.buttonTitle(at: buttonIndex)
        print("\(buttonTitle) pressed")
        if buttonTitle == "Xong" {
            // This is not recommended behavior.  The user will interpret this as a crash.
            print ("fuck")
            let textField = alert.textField(at: 0)
            apiPostComment(x: (textField?.text)!)
        }
        if buttonTitle == "Hoàn tất" {
            // This is not recommended behavior.  The user will interpret this as a crash.
            print ("fuck2")
            let textField = alert2.textField(at: 0)
            apiPostAnswer(answer: (textField?.text)!, id: idQuestion, index: self.index)
        
        }
        
    }
    func apiPostComment(x: String)
    {
        
        let commentPostNew:CommentPostNew = CommentPostNew(question: x, buyerId: self.idUser, ownerId: self.idOwner, estateId: self.idEstate)
        
        let json = JSONSerializer.toJson(commentPostNew)
        //    print (json)
        
        let jsonObject = convertToDictionary(text: json)
        
        //  print (jsonObject)
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject)
        
        var req = URLRequest(url: URL(string: "http://35.194.220.127/rem/rem_server/estate/comment")!)
        
        
        
        req.httpMethod = "POST"
        req.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            
            
            //   print (data)
            do
            {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as AnyObject
                
                //   print (json["statuskey"])
                // print (json["name"])
                
                
                DispatchQueue.main.async {
                    if (json["statuskey"] as! Bool)
                    {
                        let alert = UIAlertController(title: "Thông báo", message: json["message"] as! String, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        self.mangBuyer.append(self.nameBuyer)
                        self.mangQuestion.append(x)
                        self.mangAnswer.append("")
                        self.myTbv.reloadData()
                        
                        
                    }
                    else
                    {
                        let alert = UIAlertController(title: "Lỗi", message: json["message"] as! String, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    
                    
                }
                
                
            }catch{}
            
            
        }
        task.resume()
    }
    func apiPostAnswer(answer: String, id:Int, index:Int)
    {
        
        let answerPostNew:AnswerPostNew = AnswerPostNew(answer: answer, id: id)
        
        let json = JSONSerializer.toJson(answerPostNew)
        //    print (json)
        
        let jsonObject = convertToDictionary(text: json)
        
        //  print (jsonObject)
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject)
        
        var req = URLRequest(url: URL(string: "http://35.194.220.127/rem/rem_server/estate/answerComment")!)
        
        
        
        req.httpMethod = "POST"
        req.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            
            
            //   print (data)
            do
            {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as AnyObject
                
                //   print (json["statuskey"])
                // print (json["name"])
                
                
                DispatchQueue.main.async {
                    if (json["statuskey"] as! Bool)
                    {
                        let alert = UIAlertController(title: "Thông báo", message: json["message"] as! String, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                       // self.mangBuyer.append(self.nameBuyer)
                    //    self.mangQuestion.append(x)
                        self.mangAnswer[index] = answer
                        self.myTbv.reloadData()
                        
                        
                    }
                    else
                    {
                        let alert = UIAlertController(title: "Lỗi", message: json["message"] as! String, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    
                    
                }
                
                
            }catch{}
            
            
        }
        task.resume()
    }
}
