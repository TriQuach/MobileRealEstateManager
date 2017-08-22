//
//  SignUpViewController.swift
//  Thesis
//
//  Created by TriQuach on 5/13/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import UIKit
import M13Checkbox
class SignUpViewController: UIViewController {
    @IBOutlet weak var edtName: UITextField!
    @IBOutlet weak var edtusername: UITextField!
    @IBOutlet weak var edtPass: UITextField!
    @IBOutlet weak var edtEmail: UITextField!
    @IBOutlet weak var edtPhone: UITextField!
    @IBOutlet weak var cb1: M13Checkbox!
    @IBOutlet weak var cb2: M13Checkbox!
    @IBOutlet var loading: UIActivityIndicatorView!

    @IBOutlet weak var outletDangKy: UIButton!
    var type:Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        loading.isHidden = true
        outletDangKy.ghostButton()
        
        
            }
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

    @IBAction func actionDangKy(_ sender: Any) {
        loading.isHidden = false
        loading.startAnimating()
        let fullname = edtName.text
        let username = edtusername.text
        let pass = edtPass.text
        let email = edtEmail.text
        let phone = edtPhone.text
       
        if (cb1.checkState == .checked)
        {
            cb2.isEnabled = false
            type = 1
            
        }
        else if ( cb2.checkState == .checked)
        {
            cb1.isEnabled = false
            type = 2
        }
        
        let postNewResister:PostNewRegister = PostNewRegister(Email: email!, Password: pass!, UserType: type, FullName: fullname!, Phone: phone!, UserName: username!)
        
        
        
        
        let json = JSONSerializer.toJson(postNewResister)
            print (json)
        
        let jsonObject = convertToDictionary(text: json)
        
        //  print (jsonObject)
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject)
        
        var req = URLRequest(url: URL(string: "http://35.194.220.127/rem/rem_server/user/register")!)
        
        
        
        
        req.httpMethod = "POST"
        req.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            
            
            //   print (data)
            do
            {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as AnyObject
                
                
                DispatchQueue.main.async {
                    if (json["statuskey"] as! Bool)
                    {
                        self.loading.stopAnimating()
                        self.loading.isHidden = true
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let tabbar = storyboard.instantiateViewController(withIdentifier: "login") as! LogInViewController
                        
                        self.navigationController?.pushViewController(tabbar, animated: true)
                        
                    }
                    else
                    {
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Alert", message: json["message"] as! String, preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                            self.loading.stopAnimating()
                            self.loading.isHidden = true
                        }
                    }

                }
                
                
                
                
            }catch{}
            
            
        }
        task.resume()
        

    }


}
