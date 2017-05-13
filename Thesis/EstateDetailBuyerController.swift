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
    
    
    @IBOutlet weak var imgTest: UIImageView!
    @IBOutlet weak var myClv: UICollectionView!
    var arrayImage:[UIImage]?
    @IBOutlet weak var myTbv2: UITableView!
    @IBOutlet weak var lblGhiChu: UILabel!
    @IBOutlet weak var myTbv1: UITableView!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var lbl: UILabel!
    
    @IBOutlet var btnLike: FaveButton!
    @IBOutlet var lblCare: UILabel!
    @IBOutlet weak var myTbv: UITableView!
    @IBOutlet weak var btnCare: UIButton!
    @IBOutlet weak var btnDate: UIButton!
    @IBOutlet weak var imgMainHouse: UIImageView!
    let estates = ["house1", "house2","house3"]
    let descrip = ["abc","xyx","asd"]
    
    var name_house:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        myTbv1.dataSource = self
        myTbv1.delegate = self
        
        myClv.delegate = self
        myClv.dataSource = self
        arrayImage = []
       //        
//        imgMainHouse.image = UIImage(named: name_house! + ".jpg")
//        self.navigationItem.title = "Chi tiết BĐS"
//        
   //     btnLike.isHidden = true
        lbl.text = ""
        
        let textView = ReadMoreTextView(frame: CGRect(x: lbl.frame.origin.x, y: lbl.frame.origin.y, width: 240, height: 100))
        
        
        textView.text = "Lorem ipsum dolorLorem ipsum dolorLorem ipsum dolorLorem ipsum dolorLorem ipsum dolorLorem ipsum dolorLorem ipsum dolorLorem ipsum dolorLorem ipsum dolorLorem ipsum ipsum dolorLorem ipsum"
        
        textView.shouldTrim = true
        textView.maximumNumberOfLines = 3
        textView.attributedReadMoreText = NSAttributedString(string: "... Read more")
        textView.attributedReadLessText = NSAttributedString(string: " Read less")
       // self.view.addSubview(textView)
        subView.addSubview(textView)
        
        lblGhiChu.text = "Ghi chú Ghi chú Ghi chú Ghi chú Ghi chú Ghi chú Ghi chú "
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
    
    @IBAction func btnQuanTam(_ sender: Any) {

        
        btnLike.isHidden = false
        btnLike.isSelected = true
        
        btnCare.isHidden = true
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
        let myPicker = UIImagePickerController()
        myPicker.delegate = self
        myPicker.sourceType = .photoLibrary
        present(myPicker, animated: true, completion: nil)
        
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var image = UIImage()
        image = (info[UIImagePickerControllerOriginalImage] as! UIImage?)!
        arrayImage?.append(image)
        print (arrayImage?.count)
        self.dismiss(animated: true, completion: nil)
        
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     //   print(arrayImage?.count)
            
      //  print(arrayImage?[indexPath.row])
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 2.5
        let hardCodedPadding:CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
}
