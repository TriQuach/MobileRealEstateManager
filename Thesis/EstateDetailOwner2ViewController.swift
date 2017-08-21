//
//  EstateDetailOwner2ViewController.swift
//  Thesis
//
//  Created by Tri Quach on 8/20/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import UIKit

class EstateDetailOwner2ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource,UIAlertViewDelegate, UITextFieldDelegate {

  
    
    let alert = UIAlertView()
    let alert2 = UIAlertView()
    var idBuyer:Int!
    var idOwner:Int!
    var idEstate2:Int!
    var nameBuyer:String!
    var isAnswered:Bool = false
    var idQuestion:Int!
    var index:Int!
    var fullEstate:FullEstate!
    
    
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

        myTbv.dataSource = self
        myTbv.delegate = self
        //  btnCapNhatGhiChu.ghostButton()
        navigationController?.delegate = self
        
       
        
        
        
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
        
        getAvatar()
        let tap2: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        
        view.addGestureRecognizer(tap2)
        
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func getAvatar()
    {
        let req = URLRequest(url: URL(string: "http://192.168.1.10:8080/rem/rem_server/estate/getRepresentPhoto/" + String(idEstate))!)
        
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
        
        let req = URLRequest(url: URL(string: "http://192.168.1.10:8080/rem/rem_server/estate/getByID/" + String(idEstate))!)
        
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
                self.fullEstate = newFullEstate
                
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
    func getPhotoList()
    {
        
        let req = URLRequest(url: URL(string: "http://192.168.1.10:8080/rem/rem_server/estate/getPhotoList/" + String(idEstate))!)
        
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
                    self.getCommentOwner()
                    
                }
                
                
            }catch{}
        }
        task.resume()
    }
    func getCommentOwner()
    {
        let req = URLRequest(url: URL(string: "http://192.168.1.10:8080/rem/rem_server/estate/getCommentOwner/" + String(idEstate) + "-" + String(idOwner))!)
        
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
                        self.loading.isHidden = true
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mangQuestion.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell5") as! CommentTableViewCell
        cell.lblBuyer.text = mangBuyer[indexPath.row]
        //cell.lblAnswer.text = mangAnswer[indexPath.row]
        cell.edtAnswer.delegate = self
        cell.edtAnswer.tag = indexPath.row
        cell.edtAnswer.text = mangAnswer[indexPath.row]
        cell.lblQuestion.text = mangQuestion[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mangImage.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! ImageServerCollectionViewCell
        let data:Data = Data(base64Encoded: mangImage[indexPath.row])!
        cell.myImg.image = UIImage(data: data)
        
        return cell
    }
    func getComment()
    {
        let req = URLRequest(url: URL(string: "http://192.168.1.10:8080/rem/rem_server/estate/getCommentBuyer/" + String(idEstate) + "-" + String(idUser))!)
        
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
    @IBAction func actionDaBan(_ sender: Any) {
        if (role == 0)
        {
            let alertController = UIAlertController(title: "Thông báo", message: "Bạn có muốn yêu cầu cập nhập đã bán bất động sản này? ", preferredStyle: .alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: "Đã bán", style: UIAlertActionStyle.default) {
                UIAlertAction in
                self.requestDaBanBuyer()
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
        else
        {
            if (idUser == idOwner)
            {
                let alertController = UIAlertController(title: "Thông báo", message: "Bạn có muốn yêu cầu cập nhập đã bán bất động sản này? ", preferredStyle: .alert)
                
                // Create the actions
                let okAction = UIAlertAction(title: "Đã bán", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                    self.requestDaBanOwner()
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
        }
        
        
    }
    func requestDaBanBuyer()
    {
        let req = URLRequest(url: URL(string: "http://192.168.1.10:8080/rem/rem_server/user/updateRequest/" + String(idUser) + "-" + String(idEstate))!)
        
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
        let req = URLRequest(url: URL(string: "http://192.168.1.10:8080/rem/rem_server/estate/updateStatus/" + String(self.idEstate) + "-" + String(2))!)
        
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
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        
//        mangAnswer[textField.tag] = textField.text!
//    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        mangAnswer[textField.tag] = textField.text!
        self.view.endEditing(true)
        apiPostAnswer(answer: textField.text!, id: mangIdQuestion[textField.tag], index: 0)
        return false
    }
    func apiPostAnswer(answer: String, id:Int, index:Int)
    {
        
        let answerPostNew:AnswerPostNew = AnswerPostNew(answer: answer, id: id)
        
        let json = JSONSerializer.toJson(answerPostNew)
        //    print (json)
        
        let jsonObject = convertToDictionary(text: json)
        
        //  print (jsonObject)
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject)
        
        var req = URLRequest(url: URL(string: "http://192.168.1.10:8080/rem/rem_server/estate/answerComment")!)
        
        
        
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
