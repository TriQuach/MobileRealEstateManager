//
//  EstateDetailOwnerViewController.swift
//  Thesis
//
//  Created by TriQuach on 5/17/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import UIKit

class EstateDetailOwnerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        var navigationBarAppearace = UINavigationBar.appearance()
//        
//        navigationBarAppearace.barTintColor = UIColor(cgColor: #colorLiteral(red: 0.2352941176, green: 0.3529411765, blue: 0.6078431373, alpha: 1).cgColor)
//        navigationBarAppearace.tintColor = UIColor(cgColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor)
        // 3
        
        // 5
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "edit3.png"), style: .done, target: self, action: #selector(DangBai))
        
        
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        // 4
        let image = UIImage(named: "swift2.png")
        imageView.image = image
        navigationItem.titleView = imageView
    }
    func DangBai()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabbar = storyboard.instantiateViewController(withIdentifier: "DangBai") as! DangBaiViewController
        self.navigationController?.pushViewController(tabbar, animated: true)
    }
}
