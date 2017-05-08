//
//  LogInViewController.swift
//  Thesis
//
//  Created by TriQuach on 5/7/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import UIKit
import M13Checkbox
class LogInViewController: UIViewController {

    @IBOutlet var myCheckBox: M13Checkbox!
    @IBOutlet var lblLogIn: UILabel!
    var id:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        myCheckBox.stateChangeAnimation = .bounce(.fill)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    @IBAction func btnDangNhap(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }

}
