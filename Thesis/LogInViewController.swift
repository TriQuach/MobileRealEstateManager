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
        var req = URLRequest(url: URL(string: "http://rem-real-estate-manager.1d35.starter-us-east-1.openshiftapps.com/rem/rem_server/user/login")!)
        
        req.httpMethod = "POST"
        req.httpBody = jsonData
        
        
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            
            do
            {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as AnyObject
                
                print (json["statuskey"])
                if (json["statuskey"] as? Bool)!
                {
                    
                    print ("a")
                    
                    DispatchQueue.main.async {
                        
                        self.loading.stopAnimating()
                        self.loading.isHidden = true
                        
                        if (self.storyboardID == "BDS")
                        {
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let tabbar = storyboard.instantiateViewController(withIdentifier: "DangMoi") as! DangMoiViewController
                            
                            self.navigationController?.pushViewController(tabbar, animated: true)
                        }
                    }
                    
                    
                }
                else
                {
                    print ("fuck")
                    check = 0
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Alert", message: json["message"] as! String, preferredStyle: UIAlertControllerStyle.alert)
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
