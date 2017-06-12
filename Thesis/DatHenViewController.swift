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

    @IBOutlet weak var edtNote: UITextField!
    @IBOutlet weak var lblOwner: UILabel!
    @IBOutlet weak var lblDatLichHen: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    var idUser:Int = 0
    var datLichHen:String!
    var owner:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print ("idUser new" + String(idUser))

        // Do any additional setup after loading the view.
        parsePassObject()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parsePassObject()
    {
        lblDatLichHen.text = datLichHen
        lblOwner.text = owner
    }

   

    @IBAction func btnPickTime(_ sender: Any) {
        let picker = DateTimePicker.show()
        picker.highlightColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1)
        picker.darkColor = UIColor.darkGray
        picker.doneButtonTitle = "!! DONE DONE !!"
        picker.todayButtonTitle = "Today"
        picker.is12HourFormat = true
        picker.dateFormat = "hh:mm aa dd/MM/YYYY"
        
        picker.completionHandler = { date in
            // do something after tapping done
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm aa dd/MM/YYYY"
            self.lblTime.text = formatter.string(from: date)
        }
    }
    
    @IBAction func sendRequest(_ sender: Any) {
        
        
        let appointmentPostNew:AppointmentPostNew = AppointmentPostNew(name: lblDatLichHen.text!, time: lblTime.text!, userid: idUser, note: edtNote.text!)
        
        
        let json = JSONSerializer.toJson(appointmentPostNew)
        print (json)
        
        let jsonObject = convertToDictionary(text: json)
        
        print (jsonObject)
        
        
//        let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject)
//        
//        var req = URLRequest(url: URL(string: "http://rem-real-estate-manager.1d35.starter-us-east-1.openshiftapps.com/rem/rem_server/estate/post")!)
//        
//        
//        
//        req.httpMethod = "POST"
//        req.httpBody = jsonData
//        
//        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
//            
//            
//            print (data)
//            do
//            {
//                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as AnyObject
//                
//                print (json["statuskey"])
//                print (json["name"])
//                
//                
//                
//                
//                
//            }catch{}
//            
//            
//        }
//        task.resume()
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
