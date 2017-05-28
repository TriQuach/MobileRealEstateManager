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
class DangMoiViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var myClv: UICollectionView!
    @IBOutlet weak var lblThanhPho: UILabel!
    @IBOutlet weak var btnThanhPho: UIButton!
    let dropper = Dropper(width: 75, height: 200)
    var takenImage = UIImage(named: "add2.png")
    var mang:[UIImage] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblThanhPho.isHidden = true
        myClv.delegate = self
        myClv.dataSource = self
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        mang.append(takenImage!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cityPress(_ sender: Any) {
        if dropper.status == .hidden {
            dropper.items = ["HCM", "Hà Nội","Hải Phòng"]
            dropper.theme = Dropper.Themes.white
            dropper.delegate = self as? DropperDelegate
            dropper.cornerRadius = 3
            //dropper.height = 20
            dropper.showWithAnimation(0.1, options: .center, position: .bottom, button: btnThanhPho)
            
            
        } else {
            dropper.hideWithAnimation(0.1)
        }
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
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mang.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DangMoiCollectionViewCell
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        takenImage = (info[UIImagePickerControllerOriginalImage] as! UIImage?)!
        self.dismiss(animated: true, completion: nil)
        
        self.mang.remove(at: mang.count-1)
        self.mang.append(takenImage!)
        self.mang.append(UIImage(named: "add4.png")!)
        self.myClv.reloadData()
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

}
extension DangMoiViewController: DropperDelegate {
    func DropperSelectedRow(_ path: IndexPath, contents: String) {
        
        
        self.lblThanhPho.text = contents
        self.lblThanhPho.isHidden = false
        
    }
}
