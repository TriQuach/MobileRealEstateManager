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
class EstateDetailBuyerController: UIViewController, UITableViewDelegate, UITableViewDataSource,FaveButtonDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    @IBOutlet weak var myClv: UICollectionView!
    var arrayImage:[UIImage]?
    @IBOutlet weak var lblGhiChu: UILabel!
    @IBOutlet weak var myTbv1: UITableView!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var lbl: UILabel!
    
    
    var takenImage = UIImage(named: "add2.png")
    let estates = ["house1", "house2","house3"]
    let descrip = ["abc","xyx","asd"]
    var count:Int = 0
    var name_house:String?
    var mang:[UIImage] = []
    
    var passObject:Estates!
    override func viewDidLoad() {
        super.viewDidLoad()
        mang.append(takenImage!)
        myTbv1.dataSource = self
        myTbv1.delegate = self
        
        myClv.delegate = self
        myClv.dataSource = self
        arrayImage = []
       
        
        
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if ( tableView.tag == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            //cell?.backgroundColor = .yellow
            return cell!
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as! MyImageTableViewCell
        cell.mang = arrayImage
        //cell?.backgroundColor = .yellow
        return cell

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
        return mang.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     //   print(arrayImage?.count)
            
      //  print(arrayImage?[indexPath.row])
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyImageCollectionViewCell
        cell.myImg.image = mang[indexPath.row]
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
        
        if (indexPath.row == mang.count - 1)
        {
            let myPicker = UIImagePickerController()
            myPicker.delegate = self
            myPicker.sourceType = .photoLibrary
            present(myPicker, animated: true, completion: nil)
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
    
}
