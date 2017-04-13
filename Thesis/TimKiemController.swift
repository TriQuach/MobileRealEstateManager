//
//  TimKiemController.swift
//  Thesis
//
//  Created by TriQuach on 4/9/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
import UIKit
import Dropper
class TimKiemController: UIViewController {
    
    @IBOutlet weak var btnThanhPho: UIButton!
    @IBOutlet weak var lblThanhPho: UILabel!
    let dropper = Dropper(width: 75, height: 200)
       override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Tìm kiếm nâng cao"
        
        
    }
    
    
    
    @IBAction func pressThanhPho(_ sender: Any) {
        if dropper.status == .hidden {
            dropper.items = ["Item 1", "Item 2", "home.png", "Item 3", "Item 4", "Item 5"]
            dropper.theme = Dropper.Themes.white
            dropper.delegate = self as? DropperDelegate
            dropper.cornerRadius = 3
            //dropper.height = 20
            dropper.showWithAnimation(0.7, options: .center, position: .bottom, button: btnThanhPho)
            
            
        } else {
            dropper.hideWithAnimation(0.1)
        }
        
    }
    
   
    
}
extension TimKiemController: DropperDelegate {
    func DropperSelectedRow(_ path: IndexPath, contents: String) {
        
        lblThanhPho.text = contents
    }
}

