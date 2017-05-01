//
//  DetailCuocHenViewController.swift
//  Thesis
//
//  Created by TriQuach on 4/30/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import UIKit

class DetailCuocHenViewController: UIViewController {
    
    var status:Int = 0
    
    @IBOutlet weak var btnRight: UIButton!
    @IBOutlet weak var btnLeft: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        if ( status == 0)
        {
           self.btnLeft.isHidden = true
            btnRight.setTitle("Hủy yêu cầu", for: .normal)
        }
        else if ( status == 1)
        {
            self.btnLeft.isHidden = false
            btnRight.setTitle("Hủy cuộc hẹn", for: .normal)
            btnLeft.setTitle("Nhắc nhở", for: .normal)
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
}
