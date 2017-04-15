//
//  BatDongSanController.swift
//  Thesis
//
//  Created by TriQuach on 4/2/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
import UIKit

class BatDongSanController: UIViewController  {
    
    
    
    
    
    
    @IBOutlet weak var lblRole: UILabel!
    var temp:String = ""
    var role:Int? // 0: buyer 1: seller || buyer
    let estates = ["house1", "house2","house3"]
    let owner = ["triquach","quach","tri"]
    let phone = ["123","456","789"]
    let address = ["abc","xyx","asd"]
    var test:String?
    
    @IBOutlet weak var imgSearch: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
       // lblRole.text = temp
        self.navigationItem.title = "Bất động sản"
        
     
    }
    
    
    
    
    
    
    
}
