//
//  DangMoiViewController.swift
//  Thesis
//
//  Created by Tri Quach on 5/27/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import UIKit

import M13Checkbox
import DropDown
class DangMoiViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var loading2: UIActivityIndicatorView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    var check:Int = 9999
    var loai:Int!
    var lat:Double!
    var lng:Double!
    var idOwner:Int!
    var mangPhotos:[Photo] = []
    var mangWard:[String] = []
    var mangDistrict:[String] = [
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
    var idEstate:Int = 0
    @IBOutlet weak var myClv: UICollectionView!
    @IBOutlet weak var btnThanhPho: UIButton!
    
    
    @IBOutlet var isBroker: M13Checkbox!
    @IBOutlet weak var lblLoai: UILabel!
    @IBOutlet weak var dropLoai: UIView!
    @IBOutlet weak var edtSoNha: UITextField!
    @IBOutlet weak var lblThanhPho: UILabel!
    @IBOutlet weak var dropThanhPho: UIView!
    @IBOutlet weak var edtTieuDe: UITextField!
    @IBOutlet weak var edtGia: UITextField!
    @IBOutlet weak var dropQuan: UIView!
    @IBOutlet weak var dropPhuong: UIView!
    @IBOutlet weak var lblQuan: UILabel!
    @IBOutlet weak var lblPhuong: UILabel!
    
    @IBOutlet weak var edtDienTich: UITextField!
    
    @IBOutlet weak var edtChieuDai: UITextField!
    @IBOutlet weak var edtChieuRong: UITextField!
    @IBOutlet weak var edtSoTang: UITextField!
    @IBOutlet weak var edtSoPhongNgu: UITextField!
    @IBOutlet weak var edtSoPhongTam: UITextField!
    @IBOutlet weak var edtTinhTrang: UITextField!
    @IBOutlet weak var edtMoTa: UITextField!
    @IBOutlet weak var img: UIImageView!
    var flag:Bool = false
    
    @IBOutlet weak var innerView: UIView!
    
    let dropDown = DropDown()
    let dropDown2 = DropDown()
    let dropDown3 = DropDown()
    let dropDown4 = DropDown()
    var flag2:Int = 0
    var takenImage = UIImage(named: "add2.png")
    var mang:[UIImage] = []
    var mang2:[UIImage] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        initDropDown(x: dropThanhPho)
        initDropDown(x: dropQuan)
        initDropDown(x: dropPhuong)
        initDropDown(x: dropLoai)
        
   

        myClv.delegate = self
        myClv.dataSource = self
        
        if(flag2 != 0)
        {
        self.navigationItem.setHidesBackButton(true, animated: true)
        }
        mang.append(takenImage!)
        mang2.append(takenImage!)
        
//        print (img.bounds.size.width)
//        print (img.bounds.size.height)
//        print ((self.navigationController?.navigationBar.frame.height)!)
//    
//        let btnCamera = UIButton(frame: CGRect(x: UIScreen.main.bounds.width * 0.8, y: img.bounds.size.height * 0.9, width: 20, height: 20))
//        
//        btnCamera.setImage(UIImage(named: "camera.png"), for: .normal)
//        
//        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imgMoreTapped))
//          btnCamera.isUserInteractionEnabled = true
//           btnCamera.addGestureRecognizer(tap)
//        
//        let btnPhoto = UIButton(frame: CGRect(x: UIScreen.main.bounds.width * 0.9, y: img.bounds.size.height * 0.9, width: 20, height: 20))
//        
//        btnPhoto.setImage(UIImage(named: "picture.png"), for: .normal)
//        
//        let tap2:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imgMoreTapped))
//        btnPhoto.isUserInteractionEnabled = true
//        btnPhoto.addGestureRecognizer(tap2)
//        
//        innerView.addSubview(btnCamera)
//        innerView.addSubview(btnPhoto)

        
        loading.isHidden = true
        loading2.isHidden = true
        
        
        
        
    }
    
    func initDropDown(x:UIView)
    {
        
        x.layer.borderWidth = 1
        x.layer.borderColor = UIColor.black.cgColor
        
        if ( x.tag == 0)
        {
            dropDown.anchorView = x // UIView or UIBarButtonItem
            
            dropDown.dataSource = [
                "Thành phố Hồ Chí Minh"
            ]
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                self.lblThanhPho.text = item
                
            }
            
            let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imgMoreTapped2))
            x.isUserInteractionEnabled = true
            x.addGestureRecognizer(tap)
        }
        else if (x.tag == 1)
        {
            dropDown2.anchorView = x // UIView or UIBarButtonItem
            
            dropDown2.dataSource = self.mangDistrict
            
            
            
            
            
            
            
            
            dropDown2.selectionAction = { [unowned self] (index: Int, item: String) in
                
                print ("index:::" + String(index))
                self.lblQuan.text = item
                self.sendRequestGetWard(idWard: index)
            }
            
            let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imgMoreTapped3))
            x.isUserInteractionEnabled = true
            x.addGestureRecognizer(tap)
        }
        else if (x.tag == 2)
        {
            dropDown3.anchorView = x
            dropDown3.dataSource = self.mangWard
            dropDown3.selectionAction = { [unowned self] (index: Int, item: String) in
                
                self.lblPhuong.text = item
                
            }
            
            let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imgMoreTapped4))
            x.isUserInteractionEnabled = true
            x.addGestureRecognizer(tap)
        }
        else if (x.tag == 3)
        {
            dropDown4.anchorView = x
            dropDown4.dataSource = self.mangLoai
            dropDown4.selectionAction = { [unowned self] (index: Int, item: String) in
                self.lblLoai.text = item
                self.loai = index + 1
                
            }
            
            let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imgMoreTapped5))
            x.isUserInteractionEnabled = true
            x.addGestureRecognizer(tap)
        }
    }
    func showDrop(dropDown: DropDown, x:UIView, lbl:UILabel)
    {
        
    }
    func imgMoreTapped()
    {
        let myPicker = UIImagePickerController()
        myPicker.delegate = self
        myPicker.sourceType = .photoLibrary
        present(myPicker, animated: true, completion: nil)
        flag = true
        
    }
    func imgMoreTapped2()
    {
        dropDown.show()
    }
    func imgMoreTapped3()
    {
        dropDown2.show()
    }
    func imgMoreTapped4()
    {
        dropDown3.show()
    }
    func imgMoreTapped5()
    {
        dropDown4.show()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    override func viewDidAppear(_ animated: Bool) {
//        var navigationBarAppearace = UINavigationBar.appearance()
//        
//        navigationBarAppearace.barTintColor = UIColor(cgColor: #colorLiteral(red: 0.2352941176, green: 0.3529411765, blue: 0.6078431373, alpha: 1).cgColor)
//        navigationBarAppearace.tintColor = UIColor(cgColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor)
        // 3
        
        // 5
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "tick3.png"), style: .done, target: self, action: #selector(DangBai))
        
        
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        // 4
        let image = UIImage(named: "swift2.png")
        imageView.image = image
        navigationItem.titleView = imageView
    }
    func DangBai()
    {
        self.loading.isHidden = false
        self.loading.startAnimating()
        print ("asdasdasdasd")
        
        
        
      getLatLong()
        
        

        
   
        
        
        
        
    }
    func getLatLong()
    {
        
        
        let urlString = "https://maps.googleapis.com/maps/api/geocode/json?address=" + edtSoNha.text! + ", " + lblPhuong.text! + ", " + lblQuan.text! + ", " + lblThanhPho.text! + ", " + "Viet Nam"  + "&key=AIzaSyBQrSLHhtVml0KSdfz7px3fmwwlH-XdauA"
        let escapedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: escapedString!)
        let req = URLRequest(url: url!)
       
        
        
        //let req = URLRequest(url: URL(string: "https://maps.googleapis.com/maps/api/geocode/json?address=" + edtSoNha.text! + ", " + lblPhuong.text! + ", " + lblQuan.text! + ", " + lblThanhPho.text! + ", " + "Viet Nam"  + "&key=AIzaSyBQrSLHhtVml0KSdfz7px3fmwwlH-XdauA")!)
        
        let task = URLSession.shared.dataTask(with: req) { (d, u, e) in
            
            
            do
            {
                
                let json = try JSONSerialization.jsonObject(with: d!, options: .allowFragments) as! AnyObject
                
                
                let results = json["results"] as! [AnyObject]
                let geometry = results[0]["geometry"] as! AnyObject
                let location = geometry["location"] as! AnyObject
                let lat = location["lat"] as! Double
                let lng = location["lng"] as! Double
                
                DispatchQueue.main.async(execute: {
                    self.lat = lat
                    self.lng = lng
                    print ("lat:" + String(self.lat))
                    self.postEstate()
                    
                })
            }catch{}
        }
        task.resume()
    }
    func postEstate()
    {
        
        let owner:UserEstatePostNew = UserEstatePostNew(id: idOwner)
        
        let address:Address = Address(city: self.lblThanhPho.text!, district: self.lblQuan.text!, ward: self.lblPhuong.text!, address: self.edtSoNha.text!, id: 0)
        
        let detail:Detail = Detail(bathroom: Int(self.edtSoPhongNgu.text!)!, bedroom: Int(self.edtSoPhongTam.text!)!, condition: self.edtTinhTrang.text!, description: self.edtMoTa.text!, floor: Int(self.edtSoTang.text!)!, length: Double(self.edtChieuDai.text!)!, width: Double(self.edtChieuRong.text!)!, longitude: lng, latitude: lat, id: 0)
        
        
        let type = self.loai
        let price = Double(self.edtGia.text!)
        let area = Double(self.edtDienTich.text!)
        let name = self.edtTieuDe.text
        
        let estatePostNew:EstatePostNew = EstatePostNew(owner: owner, address: address, detail: detail, type: type!, price: price!, area: area!, name: name!, broker: self.isBroker.isEnabled)
        
        
        let json = JSONSerializer.toJson(estatePostNew)
        //    print (json)
        
        let jsonObject = convertToDictionary(text: json)
        
        //  print (jsonObject)
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject)
        
        var req = URLRequest(url: URL(string: "http://35.189.190.170/rem/rem_server/estate/post")!)
        
        
        
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
                    self.idEstate = json["id"] as! Int
                    self.parseImageToArray()
                    
                    self.sendRequestImageApi()
                    
                    
                    
                    
                    
                    
                    
                }
                
                
            }catch{}
            
            
        }
        task.resume()
    }
    
    func sendRequestImageApi()
    {
        
        print ("self.idEstate")
        print (self.idEstate)
        print ("mangPhotos")
        print (self.mangPhotos)
        let photoPostNew:PhotoPostNew = PhotoPostNew(id: self.idEstate, photos: self.mangPhotos, avatar: self.check)
        
        print ("photoPostNew")
        print (photoPostNew)
        
        let json = JSONSerializer.toJson(photoPostNew)
        //    print (json)
        
        let jsonObject = convertToDictionary(text: json)
        
        //  print (jsonObject)
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject)
        
        var req = URLRequest(url: URL(string: "http://35.189.190.170/rem/rem_server/estate/upPhotoList")!)
        
        
        
        
        req.httpMethod = "POST"
        req.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
           
        
            do
            {
                print ("asdasd")
                let json2 = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as AnyObject
                
                   print (json2["message"] as! String)
                 print (json2["statuskey"] as! Bool)
                
                DispatchQueue.main.async {
                    self.loading.isHidden = true
                    self.loading.stopAnimating()
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let tabbar = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
                    let login : BatDongSanController = tabbar.viewControllers?[0] as! BatDongSanController;
                    login.isLogin = true
                    login.role = 1
                    self.navigationController?.pushViewController(tabbar, animated: true)
                }
               
                
                
            }catch{
                print ("catch")
                print (error)
            }
            
            
        }
        task.resume()
    }
    
    func sendRequestGetWard(idWard: Int)
    {
        self.mangWard = []
        self.loading2.isHidden = false
        self.loading2.startAnimating()
        let url = "http://35.189.190.170/rem/rem_server/data/getWard/" + String(idWard + 1)
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

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mang.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if ( indexPath.row != check && indexPath.row != mang.count - 1)
        {
            
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DangMoiCollectionViewCell
            cell.myImg.image = mang[indexPath.row]
           
            return cell
        }
        if (indexPath.row == mang.count - 1)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath)
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! DangMoi2CollectionViewCell
        cell.myImg.image = mang2[indexPath.row]
        cell.myCb.stateChangeAnimation = .fill
        cell.myCb.setCheckState(.checked, animated: true)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 2.5
        let hardCodedPadding:CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        takenImage = (info[UIImagePickerControllerOriginalImage] as! UIImage?)!
        self.dismiss(animated: true, completion: nil)
        
        if (flag)
        {
            img.image = takenImage
        }
        else
        {
            self.mang.remove(at: mang.count-1)
            self.mang.append(takenImage!)
            self.mang.append(UIImage(named: "add4.png")!)
            self.mang2.remove(at: mang2.count-1)
            self.mang2.append(takenImage!)
            self.mang2.append(UIImage(named: "add4.png")!)
            self.myClv.reloadData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        flag = false
        if (indexPath.row != mang.count - 1 && check != indexPath.row)
        {
        self.check = indexPath.row
            self.myClv.reloadData()
        }
        
        
        
        if (indexPath.row == mang.count - 1)
        {
            let myPicker = UIImagePickerController()
            myPicker.delegate = self
            myPicker.sourceType = .photoLibrary
            present(myPicker, animated: true, completion: nil)
        }
        
        
     
        
    }
    func parseImage(image: UIImage) -> String
    {
        let imageData:NSData = UIImagePNGRepresentation(image)! as NSData
        
        let strBase64 = imageData.base64EncodedString(options: .endLineWithLineFeed)
        
        return strBase64
    }
    func parseImageToArray()
    {
        for i in 0..<mang.count - 1
        {
            let stringData = mang[i].base64(format: .jpeg(0.2))
            let photo:Photo = Photo(photo: stringData!)
            mangPhotos.append(photo)
        //    print (stringData)
        }
    }
    
    
    
    
   

}
