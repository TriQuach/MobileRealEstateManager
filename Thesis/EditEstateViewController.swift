//
//  EditEstateViewController.swift
//  Thesis
//
//  Created by Tri Quach on 7/9/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import UIKit

class EditEstateViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var edtEdit: UITextField!
    @IBOutlet weak var edtPostDate: UITextField!
    @IBOutlet weak var outletDatLichHen: UIButton!
    @IBOutlet weak var loading3: UIActivityIndicatorView!
    @IBOutlet weak var loading2: UIActivityIndicatorView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var tvNote: UITextView!
    @IBOutlet weak var edtTinhTrang: UITextField!
    @IBOutlet weak var edtMoTa: UITextField!
    @IBOutlet weak var edtSoPhongTam: UITextField!
    @IBOutlet weak var edtSoPhongNgu: UITextField!
    @IBOutlet weak var edtSoTang: UITextField!
    @IBOutlet weak var edtLoai: UITextField!
    @IBOutlet weak var edtRong: UITextField!
    @IBOutlet weak var passImg: UIImageView!
    @IBOutlet weak var edtDai: UITextField!
    @IBOutlet weak var edtDienTich: UITextField!
    @IBOutlet weak var edtAddress: UITextField!
    @IBOutlet weak var edtOwner: UITextField!
    @IBOutlet weak var edtTitle: UITextField!
    @IBOutlet weak var myClv: UICollectionView!
    @IBOutlet weak var myClv2: UICollectionView!
    var arrayImage:[UIImage]?
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        getAvatar()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionMap(_ sender: Any) {
        let alert = UIAlertController(title: "Thông báo", message: "Tính năng đang phát triển", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func getEstateBaseOnID()
    {
        
        let req = URLRequest(url: URL(string: "http://35.194.220.127/rem/rem_server/estate/getDetail/" + String(idEstate))!)
        
        let task = URLSession.shared.dataTask(with: req) { (d, u, e) in
            
            do
            {
                
                let json = try JSONSerialization.jsonObject(with: d!, options: .allowFragments) as! AnyObject
                DispatchQueue.main.async {
                    self.edtSoPhongTam.text = String(json["bathroom"] as! Int)
                    self.edtSoPhongNgu.text = String(json["bedroom"] as! Int)
                    self.edtTinhTrang.text = json["condition"] as! String
                    self.edtMoTa.text = json["description"] as! String
                    self.edtSoTang.text = String(json["floor"] as! Int)
                    self.edtDai.text = String(json["length"] as! Double)
                    self.edtMoTa.text = String(json["width"] as! Double)
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
                    self.mang.append(self.takenImage!)
                    self.myClv.reloadData()
                    
                }
                
                
            }catch{}
        }
        task.resume()
    }
    func parsePassEstate()
    {
        
        edtTitle.text = passEstate.title
        edtDienTich.text = String(passEstate.dientich)
        edtAddress.text = passAdress
        edtOwner.text = passOwner
        let data:Data = Data(base64Encoded: passEstate.image)!
        passImg.image = UIImage(data: data)
        
        
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyImage2CollectionViewCell
            cell.myImg.image = mang[indexPath.row]
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! ImageServer2CollectionViewCell
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        takenImage = (info[UIImagePickerControllerOriginalImage] as! UIImage?)!
        self.dismiss(animated: true, completion: nil)
        
        self.mang.remove(at: mang.count-1)
        self.mang.append(takenImage!)
        self.mang.append(UIImage(named: "add4.png")!)
        self.myClv.reloadData()
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
                    //  self.idOwner = newFullEstate.owner.id
                    self.outletDatLichHen.isEnabled = true
                    self.passFullEstate = newFullEstate
                    if (newFullEstate.detail.bathroom == 0 || newFullEstate.detail.bathroom == -1)
                    {
                        self.edtSoPhongTam.text = "Tất cả"
                    }
                    else
                    {
                        self.edtSoPhongTam.text = String(newFullEstate.detail.bathroom)
                    }
                    if (newFullEstate.detail.bedroom == 0 || newFullEstate.detail.bedroom == -1)
                    {
                        self.edtSoPhongNgu.text = "Tất cả"
                    }
                    else
                    {
                        self.edtSoPhongNgu.text = String(newFullEstate.detail.bedroom)
                    }
                    self.edtTinhTrang.text = newFullEstate.detail.condition
                    self.edtMoTa.text = newFullEstate.detail.description
                    if (newFullEstate.detail.floor == 0 || newFullEstate.detail.floor == -1)
                    {
                        self.edtSoTang.text = "Tất cả"
                    }
                    else
                    {
                        self.edtSoTang.text = String(newFullEstate.detail.floor)
                    }
                    if (newFullEstate.detail.length == 0 || newFullEstate.detail.length == -1)
                    {
                        self.edtDai.text = "Tất cả"
                    }
                    else
                    {
                        self.edtDai.text = String(newFullEstate.detail.length)
                    }
                    if (newFullEstate.detail.width == 0 || newFullEstate.detail.width == -1)
                    {
                        self.edtRong.text = "Tất cả"
                    }
                    else
                    {
                        self.edtRong.text = String(newFullEstate.detail.width)
                    }
                    self.edtTitle.text = newFullEstate.name
                    self.edtOwner.text = newFullEstate.owner.fullName
                    self.edtAddress.text = newFullEstate.address.city
                    self.edtPostDate.text = newFullEstate.postTime
                    self.edtEdit.text = newFullEstate.editTime
                    self.edtLoai.text = newFullEstate.type
                    //self.idOwner = newFullEstate.owner.id
                    if (newFullEstate.area == 0 || newFullEstate.area == -1)
                    {
                        self.edtDienTich.text = "Tất cả"
                    }
                    else
                    {
                        self.edtDienTich.text = String(newFullEstate.area) + " m2"
                    }
                    self.getPhotoList()
                    
                    
                })
            }catch{}
        }
        task.resume()
        
        
        
        
        
        
    }
    
}
