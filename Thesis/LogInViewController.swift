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

    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var edtPass: UITextField!
    @IBOutlet weak var edtUserName: UITextField!
    @IBOutlet weak var lblSignUp: UILabel!
    @IBOutlet var myCheckBox: M13Checkbox!
    @IBOutlet var lblLogIn: UILabel!
    var storyboardID: String = ""
    var message:String = ""
    var id:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        lblSignUp.isUserInteractionEnabled = true
        lblSignUp.addGestureRecognizer(tap)
        
        loading.isHidden = true
        loading.color = .black
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        
        
        
    }
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailBuyer = storyboard.instantiateViewController(withIdentifier: "signup") as! SignUpViewController
        
        self.navigationController?.pushViewController(detailBuyer, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkUser(token: String)
    {
        
            print ("1")
            
            let url = "http://rem-bt.azurewebsites.net/rem/rem_server/user/login/" + token
            print (url)
            let req = URLRequest(url: URL(string: url)!)
            
            let task = URLSession.shared.dataTask(with: req) { (d, u, e) in
                
                do
                {
                    
                    let json = try JSONSerialization.jsonObject(with: d!, options: .allowFragments) as! AnyObject
                    
                    let typeId = json["typeId"] as! Int
                    let id = json["id"] as! Int
                    
                    print (typeId)
                    
                    DispatchQueue.main.async {
                        
                        if (typeId == 1)
                        {
                            self.loading.stopAnimating()
                            self.loading.isHidden = true
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let tabbar = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
                            let Role : BatDongSanController = tabbar.viewControllers?[0] as! BatDongSanController;
                            Role.role = 0
                            self.navigationController?.pushViewController(tabbar, animated: true)
                        }
                        else if ( typeId == 2)
                        {
                            self.loading.stopAnimating()
                            self.loading.isHidden = true
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let tabbar = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
                            let Role : BatDongSanController = tabbar.viewControllers?[0] as! BatDongSanController;
                            Role.role = 1
                            self.navigationController?.pushViewController(tabbar, animated: true)
                        }
                        
                        
                        //
                        
                        
                        
                        
                    }
                }catch{}
            }
            task.resume()
        
    }


    @IBAction func btnDangNhap(_ sender: Any) {
        
        loading.isHidden = false
        loading.startAnimating()
        var check:Int = 0
        
        
        
       // self.navigationController?.popViewController(animated: true)
        var a:String = edtUserName.text!
        let b:String = edtPass.text!
        
        //print (a)
        
        
        let jsonObject: [String: String] = [
            "UserName": a,
            "Password": b
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject)
        
        
        
        
        
        
        //  print (postString)
        var req = URLRequest(url: URL(string: "http://rem-bt.azurewebsites.net/rem/rem_server/user/login")!)
        
        req.httpMethod = "POST"
        req.httpBody = jsonData
        
        
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            
            do
            {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as AnyObject
                
                
                
                if (json["statuskey"] as? Bool)!
                {
                    print (json["statuskey"])
                    let token = json["token"] as! String
                    do
                    {
                        try token.write(toFile: "/Users/triquach/Documents/token.txt", atomically: false, encoding: .utf8)
                    }catch{}
                    let check = "false"
                    do
                    {
                        try check.write(toFile: "/Users/triquach/Documents/check.txt", atomically: false, encoding: .utf8)
                    }catch{}
                    
                    DispatchQueue.main.async {
                        
                        
                        
                        if (self.storyboardID == "BDS")
                        {
                            self.loading.stopAnimating()
                            self.loading.isHidden = true
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let tabbar = storyboard.instantiateViewController(withIdentifier: "DangMoi") as! DangMoiViewController
                            
                            tabbar.idOwner = json["id"] as! Int
                            
                            
                            self.navigationController?.pushViewController(tabbar, animated: true)
                            
                        }
                        else if (self.storyboardID == "EstateDetailBuyer")
                        {
                            
                            self.loading.stopAnimating()
                            self.loading.isHidden = true
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let tabbar = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
                            let login : BatDongSanController = tabbar.viewControllers?[0] as! BatDongSanController;
                            login.isLogin = true
                            login.role = 0
                            login.idUser = json["id"] as! Int
                            self.navigationController?.pushViewController(tabbar, animated: true)
                        }
                        else if (self.storyboardID == "LogOut")
                        {
                            self.checkUser(token: token)
                        }
                        else
                        {
                            self.checkUser(token: token)
                        }
                    }
                    
                    
                }
                else
                {
                    print ("fuck")
                    check = 0
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Lỗi", message: json["message"] as! String, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        self.loading.stopAnimating()
                        self.loading.isHidden = true
                    }
                }
              
            }catch{}
            
            
        }
        task.resume()
        
        
    }
    class UnderlinedLabel: UILabel {
        
        override var text: String? {
            didSet {
                guard let text = text else { return }
                let textRange = NSMakeRange(0, text.characters.count)
                let attributedText = NSMutableAttributedString(string: text)
                attributedText.addAttribute(NSUnderlineStyleAttributeName , value: NSUnderlineStyle.styleSingle.rawValue, range: textRange)
                // Add other attributes if needed
                self.attributedText = attributedText
            }
        }
    }

}
