//
//  ViewController.swift
//  Thesis
//
//  Created by TriQuach on 4/2/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    
    @IBOutlet weak var myTbv: UITableView!
    var role = ["Real Estate Manager","Người tìm mua nhà","Người đang bán nhà/Môi giới"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTbv.delegate = self
        myTbv.dataSource = self
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return role.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0)
        {
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "cell1") as! StartScreenCell1TableViewCell
            cell1.myLbl.font = UIFont.boldSystemFont(ofSize: 25.0)
            cell1.myLbl.text = role[indexPath.row]
            cell1.myLbl.morphingEffect = .evaporate
            cell1.myLbl.morphingDuration = 3.0
            return cell1
        }
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "cell2") as! StartScreenCell2TableViewCell
        cell2.myLbl.font = UIFont.boldSystemFont(ofSize: 18.0)
        cell2.myLbl.text = role[indexPath.row]
        cell2.myLbl.morphingEffect = .evaporate
        cell2.myLbl.morphingDuration = 1.0
       //cell2.selectionStyle = .none
        //cell2.setSelected(false, animated: true)
        return cell2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0)
        {
            return (self.view.frame.height) * 1 / 2
        }
        return (self.view.frame.height)  / 4
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 1)
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabbar = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
            let Role : BatDongSanController = tabbar.viewControllers?[0] as! BatDongSanController;
            Role.role = 0
            self.navigationController?.pushViewController(tabbar, animated: true)
        }
        else if (indexPath.row == 2)
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabbar = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
            let Role : BatDongSanController = tabbar.viewControllers?[0] as! BatDongSanController;
            Role.role = 1
            self.navigationController?.pushViewController(tabbar, animated: true)
        }
        else if (indexPath.row == 3)
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabbar = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
            let Role : BatDongSanController = tabbar.viewControllers?[0] as! BatDongSanController;
            Role.role = 2
            self.navigationController?.pushViewController(tabbar, animated: true)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    }

