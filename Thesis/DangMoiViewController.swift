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
class DangMoiViewController: UIViewController {

    @IBOutlet weak var lblThanhPho: UILabel!
    @IBOutlet weak var btnThanhPho: UIButton!
    let dropper = Dropper(width: 75, height: 200)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblThanhPho.isHidden = true
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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabbar = storyboard.instantiateViewController(withIdentifier: "BDS") as! BatDongSanController
        tabbar.isLogin = true
        self.navigationController?.pushViewController(tabbar, animated: true)
    }

}
extension DangMoiViewController: DropperDelegate {
    func DropperSelectedRow(_ path: IndexPath, contents: String) {
        
        
        self.lblThanhPho.text = contents
        self.lblThanhPho.isHidden = false
        
    }
}
