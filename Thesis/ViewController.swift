//
//  ViewController.swift
//  Thesis
//
//  Created by TriQuach on 4/2/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnMuaNha: UIButton!
    @IBOutlet weak var btnBanNha: UIButton!
    @IBOutlet weak var btnMoiGioi: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnMuaNha.ghostButton()
        btnBanNha.ghostButton()
        btnMoiGioi.ghostButton()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "MuaNha")
        {
            let firstTabbar : UITabBarController = segue.destination as! UITabBarController;
            
            let Role : BatDongSanController = firstTabbar.viewControllers?[0] as! BatDongSanController;
            
            // Set the case number selected property of History vc
            Role.temp2 = "Bất động sản đang quan tâm";
            Role.role = 0
            
            
            
            
        }
        else if (segue.identifier == "BanNha")
        {
            let firstTabbar : UITabBarController = segue.destination as! UITabBarController;
            
            let Role : BatDongSanController = firstTabbar.viewControllers?[0] as! BatDongSanController;
            
            // Set the case number selected property of History vc
            Role.temp2 = "Bất động sản của tôi";
            Role.role = 1
            
        }
        else
        {
            let firstTabbar : UITabBarController = segue.destination as! UITabBarController;
            
            let Role : BatDongSanController = firstTabbar.viewControllers?[0] as! BatDongSanController;
            
            // Set the case number selected property of History vc
            Role.temp2 = "Bất động sản đang quản lý";
            Role.role = 1
        }
    }


    

}

