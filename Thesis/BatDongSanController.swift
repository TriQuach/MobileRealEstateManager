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
    
    
    
    
    
    
    @IBOutlet weak var imgMore: UIImageView!
    @IBOutlet weak var view1: UIView!
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
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        view1.isUserInteractionEnabled = true
        view1.addGestureRecognizer(tapGestureRecognizer)
        
        view1.ghostUIView()
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imgMoreTapped))
        imgMore.isUserInteractionEnabled = true
        imgMore.addGestureRecognizer(tap)
    }
    func imgMoreTapped()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let timkiem = storyboard.instantiateViewController(withIdentifier: "TimKiemController") as! TimKiemController
        
        self.navigationController?.pushViewController(timkiem, animated: true)
    }
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailBuyer = storyboard.instantiateViewController(withIdentifier: "EstateDetailBuyer") as! EstateDetailBuyerController
        
        self.navigationController?.pushViewController(detailBuyer, animated: true)
        
    }
    
    
    
    
    
    
}
