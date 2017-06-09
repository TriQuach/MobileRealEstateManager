//
//  CaiDatController.swift
//  Thesis
//
//  Created by TriQuach on 4/4/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
import UIKit

class CaiDatController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
    @IBAction func btnLogOut(_ sender: Any) {
        
        let check = "true"
        do
        {
            try check.write(toFile: "/Users/triquach/Documents/check.txt", atomically: false, encoding: .utf8)
        }catch{}
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabbar = storyboard.instantiateViewController(withIdentifier: "login") as! LogInViewController
        tabbar.storyboardID = "LogOut"
        self.navigationController?.pushViewController(tabbar, animated: true)
        
    }
    
    
}
