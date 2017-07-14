//
//  DatHenViewController.swift
//  Thesis
//
//  Created by Tri Quach on 6/7/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import UIKit
import DateTimePicker
class DatHenViewController: UIViewController {

    @IBOutlet weak var btnGuiYeuCau: UIButton!
    @IBOutlet weak var lblBDSLienQuan: UILabel!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var edtAddress: UITextField!
    @IBOutlet weak var edtName: UITextField!
    @IBOutlet weak var edtNote: UITextField!
    @IBOutlet weak var lblOwner: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    var idOwner:Int = 0
    var idUser: Int = 0
    var datLichHen:String!
    var owner:String!
    var passAdress:String!
    var role:Int!
    var idEstate:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loading.isHidden = true
        print ("user2" + String(idUser))
        // Do any additional setup after loading the view.
        parsePassObject()
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imgMoreTapped))
        lblBDSLienQuan.isUserInteractionEnabled = true
        lblBDSLienQuan.addGestureRecognizer(tap)
        btnGuiYeuCau.ghostButton()
    }

    func imgMoreTapped()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let timkiem = storyboard.instantiateViewController(withIdentifier: "EstateDetailBuyer") as! EstateDetailBuyerController
        timkiem.idUser = idUser
        timkiem.isLogin = true
        timkiem.idEstate = idEstate
        timkiem.idOwner = idOwner
        timkiem.role = role
        self.navigationController?.pushViewController(timkiem, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parsePassObject()
    {
        edtName.text = datLichHen
        lblOwner.text = owner
        edtAddress.text = passAdress
        lblBDSLienQuan.text = datLichHen
    }

   

    @IBAction func btnPickTime(_ sender: Any) {
        let picker = DateTimePicker.show()
        picker.highlightColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1)
        picker.darkColor = UIColor.darkGray
        picker.doneButtonTitle = "Chọn"
        
       // picker.todayButtonTitle = "Today"
      //  picker.is12HourFormat = true
        picker.dateFormat = "hh:mm aa dd/MM/YYYY"
        
        
        picker.completionHandler = { date in
            // do something after tapping done
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm aa dd/MM/YYYY"
            
            self.lblTime.text = formatter.string(from: date)
        }
    }
    
    @IBAction func sendRequest(_ sender: Any) {
        
        loading.isHidden = false
        loading.startAnimating()
        
//        let appointmentPostNew:AppointmentPostNew = AppointmentPostNew(name: lblDatLichHen.text!, time: lblTime.text!, userid: idUser, note: edtNote.text!)
//       
        let appointmentPostNew:AppointmentPostNew = AppointmentPostNew(name: edtName.text!, address: edtAddress.text!, time: lblTime.text!, user1: UserIdBookAppointment(id: idUser), user2: UserIdBookAppointment(id: idOwner), note: edtNote.text!, estate: idEstate)
//        
        let json = JSONSerializer.toJson(appointmentPostNew)
        print (json)
        
        let jsonObject = convertToDictionary(text: json)
        
        print (jsonObject)
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject)
        
        var req = URLRequest(url: URL(string: "http://rem-bt.azurewebsites.net/rem/rem_server/appointment/book")!)
        
        
        
        req.httpMethod = "POST"
        req.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            
            
            do
            {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as AnyObject
                
                print (json["message"] as! String)
                
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
