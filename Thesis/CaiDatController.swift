//
//  CaiDatController.swift
//  Thesis
//
//  Created by TriQuach on 4/4/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
import UIKit

class CaiDatController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    var mang:[String] = ["Tài khoản","Lịch sử","Tác giả", "Liên hệ", "Feedback", "Rate","LogOut"]
    
    @IBOutlet weak var myTbv: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTbv.dataSource = self
        myTbv.delegate = self
        
        print (self.view.frame.height - (self.navigationController?.navigationBar.frame.size.height)!)
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mang.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CaiDatTableViewCell
        cell.myLbl.text = mang[indexPath.row]
        if ( indexPath.row == mang.count - 1)
        {
            cell.myLbl.textColor = .red
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if ( indexPath.row == mang.count - 1)
        {
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        
        return (self.view.frame.height / 9)
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
