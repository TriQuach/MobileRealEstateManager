//
//  MainPageNaviViewController.swift
//  Thesis
//
//  Created by Tri Quach on 6/5/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import UIKit

class MainPageNaviViewController: UINavigationController {

    
    var isLogin:Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print ("islogin1")
        print (isLogin)
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let tabbar = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
//        let Role : BatDongSanController = tabbar.viewControllers?[0] as! BatDongSanController;
//        Role.isLogin = true
//        self.navigationController?.pushViewController(tabbar, animated: true)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
