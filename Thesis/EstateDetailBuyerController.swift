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
import FaveButton
import PopupDialog
import ReadMoreTextView
class EstateDetailBuyerController: UIViewController,FaveButtonDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
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
    var passFullEstate:FullEstate!
    @IBOutlet weak var myClv2: UICollectionView!
    @IBOutlet weak var myClv: UICollectionView!
    var arrayImage:[UIImage]?
    @IBOutlet weak var lblGhiChu: UILabel!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var lbl: UILabel!
    var idOwner:Int = 0
    var idUser: Int = 0
    var idEstate:Int = 0
    var mangImage:[String] = []
    
    
    
    var takenImage = UIImage(named: "add2.png")
    let estates = ["house1", "house2","house3"]
    let descrip = ["abc","xyx","asd"]
    var count:Int = 0
    var name_house:String?
    var mang:[UIImage] = []
    
    var passEstate:Estate!
    var passOwner:String!
    var passAdress:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        mang.append(takenImage!)
        
        myClv.delegate = self
        myClv.dataSource = self
        
        
        arrayImage = []
    //    parsePassedFullEstate()
        
        print ("owner" + String(idOwner))
        print ("User" + String(idUser))
        
        print ("idEstate:" + String(idEstate))
        loading.startAnimating()
       
       getEstateBaseOnID()
        
    }
    
    func getEstateBaseOnID()
    {
        
        let req = URLRequest(url: URL(string: "http://rem-real-estate-manager.1d35.starter-us-east-1.openshiftapps.com/rem/rem_server/estate/getDetail/" + String(idEstate))!)
        
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
        
        let req = URLRequest(url: URL(string: "http://rem-real-estate-manager.1d35.starter-us-east-1.openshiftapps.com/rem/rem_server/estate/getPhotoList/" + String(idEstate))!)
        
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
                    self.loading.isHidden = true
                    self.myClv2.delegate = self
                    self.myClv2.dataSource = self
                    self.myClv2.reloadData()
                }
                
                
            }catch{}
        }
        task.resume()
    }
    
    func parsePassEstate()
    {

        lblName.text = passEstate.title
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
    
    
    func faveButton(_ faveButton: FaveButton, didSelected selected: Bool) {
        
    }
    
    @IBAction func btnXemChiTiet(_ sender: Any) {
        let title = "THIS IS THE DIALOG TITLE"
        let message = "This is the message section of the popup dialog default view"
        let image = UIImage(named: "house1.jpg")
        
        // Create the dialog
        let popup = PopupDialog(title: title, message: message, image: image)
        
        
        
        // Create first button
        let buttonOne = CancelButton(title: "CANCEL") {
            
        }
        
        // Create second button
        let buttonTwo = DefaultButton(title: "ADMIRE CAR") {
            
        }
        
        // Create third button
        let buttonThree = DefaultButton(title: "BUY CAR") {
            
        }
        
        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo, buttonThree])
        
        
        // Present dialog
        self.present(popup, animated: true, completion: nil)
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
            if (indexPath.row == mang.count - 1)
            {
                let myPicker = UIImagePickerController()
                myPicker.delegate = self
                myPicker.sourceType = .photoLibrary
                present(myPicker, animated: true, completion: nil)
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var nav = self.navigationController?.navigationBar
        // 2
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.yellow
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
    @IBAction func btnDatLichHen(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabbar = storyboard.instantiateViewController(withIdentifier: "DatHen") as! DatHenViewController
        
      //  tabbar.owner = passFullEstate.owner.fullName
        tabbar.idUser = idUser
        tabbar.idOwner = idOwner
        tabbar.owner = passOwner
        tabbar.datLichHen = "Xem nhà tại " + passAdress
        
        self.navigationController?.pushViewController(tabbar, animated: true)
    }
    
}
