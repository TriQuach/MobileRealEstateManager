//
//  DangMoiViewController.swift
//  Thesis
//
//  Created by Tri Quach on 5/27/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import UIKit

import M13Checkbox
import Dropper
import DropDown
class DangMoiViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var check:Int = 9999
    var idOwner:Int = 0

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
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
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

        
        
        
        
    }
    
    func initDropDown(x:UIView)
    {
        x.layer.borderWidth = 1
        x.layer.borderColor = UIColor.black.cgColor
        
        if ( x.tag == 0)
        {
            dropDown.anchorView = x // UIView or UIBarButtonItem
            
            dropDown.dataSource = [
                "iPhone SE | Black | 64G",
                "Samsung S7",
                "Huawei P8 Lite Smartphone 4G",
                "Asus Zenfone Max 4G",
                "Apple Watwh | Sport Edition"
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
            
            dropDown2.dataSource = [
                "iPhone SE | Black | 64G",
                "Samsung S7",
                "Huawei P8 Lite Smartphone 4G",
                "Asus Zenfone Max 4G",
                "Apple Watwh | Sport Edition"
            ]
            dropDown2.selectionAction = { [unowned self] (index: Int, item: String) in
                self.lblQuan.text = item
                
            }
            
            let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imgMoreTapped3))
            x.isUserInteractionEnabled = true
            x.addGestureRecognizer(tap)
        }
        else if (x.tag == 2)
        {
            dropDown3.anchorView = x
            dropDown3.dataSource = [
                "iPhone SE | Black | 64G",
                "Samsung S7",
                "Huawei P8 Lite Smartphone 4G",
                "Asus Zenfone Max 4G",
                "Apple Watwh | Sport Edition"
            ]
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
            dropDown4.dataSource = [
            "1","2","3","4"
            ]
            dropDown4.selectionAction = { [unowned self] (index: Int, item: String) in
                self.lblLoai.text = item
                
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
        var nav = self.navigationController?.navigationBar
        // 2
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.yellow
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
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let tabbar = storyboard.instantiateViewController(withIdentifier: "BDS") as! BatDongSanController
//        tabbar.isLogin = true
//        self.navigationController?.pushViewController(tabbar, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabbar = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        let login : BatDongSanController = tabbar.viewControllers?[0] as! BatDongSanController;
        login.isLogin = true
        self.navigationController?.pushViewController(tabbar, animated: true)
        
        
        let owner:UserEstatePostNew = UserEstatePostNew(id: idOwner)
        
        let address:Address = Address(city: self.lblThanhPho.text!, district: self.lblQuan.text!, ward: self.lblPhuong.text!, address: self.edtSoNha.text!, id: 0)
        
        let detail:Detail = Detail(bathroom: Int(self.edtSoPhongNgu.text!)!, bedroom: Int(self.edtSoPhongTam.text!)!, condition: self.edtTinhTrang.text!, description: self.edtMoTa.text!, floor: Int(self.edtSoTang.text!)!, length: Double(self.edtChieuDai.text!)!, width: Double(self.edtChieuRong.text!)!, id: 0)
        
        
        let type = Int(self.lblLoai.text!)
        let price = Double(self.edtGia.text!)
        let area = Double(self.edtDienTich.text!)
        let name = self.edtTieuDe.text
        
        let estatePostNew:EstatePostNew = EstatePostNew(owner: owner, address: address, detail: detail, type: type!, price: price!, area: area!, name: name!, broker: self.isBroker.isEnabled)
        
        
        let json = JSONSerializer.toJson(estatePostNew)
        print (json)
        
        let jsonObject = convertToDictionary(text: json)
        print (jsonObject)
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject)
        
        var req = URLRequest(url: URL(string: "http://rem-real-estate-manager.1d35.starter-us-east-1.openshiftapps.com/rem/rem_server/estate/post")!)
        
        
        
        req.httpMethod = "POST"
        req.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            
            
            print (data)
            do
            {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as AnyObject
                
                print (json["statuskey"])
                print (json["name"])
                
                
                
                
                
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

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mang.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if ( indexPath.row != check)
        {
       
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DangMoiCollectionViewCell
        cell.myImg.image = mang[indexPath.row]
            cell.btnLike.isHidden = true
        //  cell.myCheckBox.setCheckState(.mixed, animated: true)
        cell.myCheckBox.stateChangeAnimation = .fill
        return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! DangMoi2CollectionViewCell
       cell.myImg.image = mang2[indexPath.row]
        
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
            let currentCell = collectionView.cellForItem(at: indexPath) as! DangMoiCollectionViewCell
            currentCell.btnLike.isHidden = false
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

}
extension DangMoiViewController: DropperDelegate {
    func DropperSelectedRow(_ path: IndexPath, contents: String) {
        
        
        self.lblThanhPho.text = contents
        self.lblThanhPho.isHidden = false
        
    }
}
