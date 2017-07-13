//
//  DetailCuocHenViewController.swift
//  Thesis
//
//  Created by TriQuach on 4/30/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import UIKit

class DetailCuocHenViewController: UIViewController {
    
    @IBOutlet weak var lblBdsLienQuan: UnderlinedLabel!
    var passAppoint:SimpleAppointment!
    var role:Int!
    var idUser:Int!
    var idEstate:Int!
    var name:String!
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var lblNote: UILabel!
    @IBOutlet weak var lblUser2: UILabel!
    @IBOutlet weak var lblUser1: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnRight: UIButton!
    @IBOutlet weak var btnLeft: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loading.isHidden = true
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imgMoreTapped))
        lblBdsLienQuan.isUserInteractionEnabled = true
        lblBdsLienQuan.addGestureRecognizer(tap)
        parseAppoint()
        btnLeft.ghostButton()
        btnRight.ghostButton()
        
    }
    func imgMoreTapped()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let timkiem = storyboard.instantiateViewController(withIdentifier: "EstateDetailBuyer") as! EstateDetailBuyerController
        timkiem.idUser = idUser
        timkiem.isLogin = true
        timkiem.idEstate = idEstate
        
        self.navigationController?.pushViewController(timkiem, animated: true)
    }
    func parseAppoint()
    {
        if (role == 0)
        {
            if ( passAppoint.status == 1)
            {
                self.lblStatus.text = "Chờ trả lời"
                self.btnLeft.isHidden = true
                btnRight.setTitle("Hủy yêu cầu", for: .normal)
                parseTime()
            }
            else if ( passAppoint.status == 2)
            {
                self.lblStatus.text = "Đã chấp nhận"
                self.btnLeft.isHidden = true
                btnRight.setTitle("Hủy cuộc hẹn", for: .normal)
                parseTime()
            }
            else if ( passAppoint.status == 3)
            {
                self.lblStatus.text = "Đã từ chối"
                self.btnLeft.isHidden = true
                self.btnRight.isHidden = true
                parseTime()
            }
            else if ( passAppoint.status == 5)
            {
                self.lblStatus.text = "Đã hủy"
                self.btnLeft.isHidden = true
                self.btnRight.isHidden = true
                parseTime()
            }
        }
        else if (role == 1)
        {
            if ( passAppoint.status == 1)
            {
                self.lblStatus.text = "Chờ trả lời"
                btnLeft.setTitle("Chấp nhận", for: .normal)
                parseTime()
                btnRight.setTitle("Từ chối", for: .normal)
                parseTime()
            }
            else if ( passAppoint.status == 2 )
            {
                self.lblStatus.text = "Đã chấp nhận"
                self.btnLeft.isHidden = true
                btnRight.setTitle("Hủy cuộc hẹn", for: .normal)
                parseTime()
            }
            
        }

    }
    func parseTime()
    {
        self.lblDate.text = passAppoint.time
        self.lblAddress.text = passAppoint.address
        self.lblNote.text = passAppoint.note
        if (role == 0)
        {
            self.lblUser1.text = passAppoint.user2
        }
        else if (role == 1)
        {
            self.lblUser1.text = passAppoint.user1
        }
        lblBdsLienQuan.text = name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    @IBAction func actionLeftButton(_ sender: Any) {
        
        
       loading.isHidden = false
        loading.startAnimating()
        sendRequest(status: 2)
        
        
    }
    
    @IBAction func actionButtonRight(_ sender: Any) {
        loading.isHidden = false
        loading.startAnimating()
        if (role == 0)
        {
            if (passAppoint.status == 1 || passAppoint.status == 2 )
            {
                sendRequest(status: 5)
            }
            
        }
        else if ( role == 1)
        {
            if (passAppoint.status == 1) // pending
            {
                sendRequest(status: 3)
            }
            else if (passAppoint.status == 2)
            {
                sendRequest(status: 5)
            }
        
        }
    }
    func sendRequest(status: Int)
    {
        let updateStatus: AppointmentStatusUpdate = AppointmentStatusUpdate(ApptID: passAppoint.id, Status: status)
        
        
        let json = JSONSerializer.toJson(updateStatus)
        //    print (json)
        
        let jsonObject = convertToDictionary(text: json)
        
        //  print (jsonObject)
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject)
        
        var req = URLRequest(url: URL(string: "http://rem-bt.azurewebsites.net/rem/rem_server/appointment/updateStatus")!)
        
        
        
        req.httpMethod = "POST"
        req.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            
            
            //   print (data)
            do
            {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as AnyObject
                
                DispatchQueue.main.async {
                    if ( json["statuskey"] as! Bool )
                    {
                        self.loading.isHidden = true
                        self.loading.stopAnimating()
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let tabbar = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
                        
                        self.navigationController?.pushViewController(tabbar, animated: true)
                    }
                    else
                    {
                        
                        
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
    
}
