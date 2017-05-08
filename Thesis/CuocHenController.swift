//
//  CuocHenController.swift
//  Thesis
//
//  Created by TriQuach on 4/4/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
import UIKit

class CuocHenController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var myTbv: UITableView!
    @IBOutlet weak var lblTest: UILabel!
    
    
    var temp:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        myTbv.dataSource = self
        myTbv.delegate = self
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if ( indexPath.row == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DetailCuocHenTableViewCell
            cell.tinhTrang.text = "Chờ trả lời"
            temp = 0
            return cell
        }
        else if ( indexPath.row == 1)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DetailCuocHenTableViewCell
            cell.tinhTrang.text = "Đã chấp nhận"
            temp = 1
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DetailCuocHenTableViewCell
        cell.tinhTrang.text = "Chờ trả lời"
        //temp = cell.tinhTrang.text
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabbar = storyboard.instantiateViewController(withIdentifier: "DetailCuocHen") as! DetailCuocHenViewController
        tabbar.status = temp!
                
        self.navigationController?.pushViewController(tabbar, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let xoa = UITableViewRowAction(style: .default, title: "xoa") { (action:UITableViewRowAction, index:IndexPath) in
            print ("fuck")
            
            self.myTbv.deleteRows(at: [index], with: .fade)
        }
        return [xoa]
    }
    
    
}
