//
//  SearchNewViewController.swift
//  Thesis
//
//  Created by Tri Quach on 7/7/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import UIKit
import CoreLocation
class SearchNewViewController: UIViewController,CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var myTbv: UITableView!
    @IBOutlet weak var edtAddress: UITextField!
    let locationManager = CLLocationManager()
    var lat:Double!
    var long:Double!
    var check:Bool = true
    var mangFristLabel:[String] = [
        "Tỉnh/Thành phố",
        "Quận/huyện",
        "Phường/xã",
        "Loại nhà đất",
        "Diện tích",
        "Mức giá(triệu VND",
        "Số tầng",
        "Số phòng ngủ",
        "Số phòng tắm",
        "Hướng nhà"
    ]
    var mangSecondLabel:[String] = [
        ">",
        ">",
        ">",
        ">",
        ">",
        ">",
        ">",
        ">",
        ">",
        ">"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        myTbv.delegate = self
        myTbv.dataSource = self

    }
    

    @IBAction func locateGPS(_ sender: Any) {
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print ("1")
        var locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        lat = locValue.latitude
        long = locValue.longitude
        if (check)
        {
            check = false
            self.getLocationGoogleApi()
        }
        
    }
    func getLocationGoogleApi()
    {
        let url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=" + String(lat) + "," + String(long) + "&key=AIzaSyBQrSLHhtVml0KSdfz7px3fmwwlH-XdauA"
        // print (url)
        let req = URLRequest(url: URL(string: url)!)
        
        
        let task = URLSession.shared.dataTask(with: req) { (d, u, e) in
            
            
            do
            {
                
                let json = try JSONSerialization.jsonObject(with: d!, options: .allowFragments) as! AnyObject
                
                let results = json["results"] as! [AnyObject]
                let formatted_address = results[0]["formatted_address"] as! String
                print (formatted_address)
                DispatchQueue.main.async {
                    //self.searchGPS(address: formatted_address)
                    self.edtAddress.text = formatted_address
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mangFristLabel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SearchNewTableViewCell
        cell.lblFirst.text = mangFristLabel[indexPath.row]
        cell.lblSecond.text = mangSecondLabel[indexPath.row]
        return cell
    }
}
