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
    
    
    @IBAction func btnMuaNhaClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabbar = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        let Role : BatDongSanController = tabbar.viewControllers?[0] as! BatDongSanController;
        Role.temp = "BĐS đang quan tâm"
        self.navigationController?.pushViewController(tabbar, animated: true)
    }

}

