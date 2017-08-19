 //
//  MapViewController.swift
//  Thesis
//
//  Created by Tri Quach on 8/11/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import UIKit
import GoogleMaps
class MapViewController: UIViewController,GMSMapViewDelegate,CLLocationManagerDelegate {
    var lat:Double!
    var long:Double!
    var lat2:Double!
    var long2:Double!
    var mang:[Estate_New] = []
    var formatted_address:String!
    var bankinh:UILabel = UILabel()
    var bankinh_search:Int!
    let locationManager = CLLocationManager()
    var check:Bool = true
    var count:Int = 0
    var checkSearchBanKinh:Bool = false
    var searchType:Int! // 0: GPS    1: specific location
    var marker:GMSMarker = GMSMarker()
    var viewContain:UIView = UIView()
    var avatar:UIImageView = UIImageView()
    var avatarButton:UIButton!
    var indexAvatar:Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.delegate = self
        view = mapView
        bankinh = UILabel(frame: CGRect(x: 10 + UIScreen.main.bounds.width / 4, y: 28, width: 40, height: 21))
      //  createGPS()
        //print (UIScreen.main.bounds.width)
      //  createSlider()
       // createSearchButton()
        createViewContain()
        
        
        
        //
        //         Do any additional setup after loading the view.
    }
    func buttonAction(sender: UIButton!) {
        print("Button tapped")
        searchType = 0
        self.check = true
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
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        
        searchType = 1
        print (coordinate.latitude)
        print (coordinate.longitude)
        self.lat2 = coordinate.latitude
        self.long2 = coordinate.longitude
        
        if (count >= 1)
        {
            self.marker.map = nil
        }
        
        let position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let marker = GMSMarker(position: position)
        self.marker = marker
        marker.title = "Hello World"
        marker.map = mapView
        count += 1
        
        
    }
    func createGPS()
    {
        let button = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 40, y: 10, width: 20, height: 20))
        button.setImage(UIImage(named: "gps.png"), for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.viewContain.addSubview(button)
    }
    func createSlider()
    {
        let slider:UISlider = UISlider(frame: CGRect(x: 20, y: 15, width: UIScreen.main.bounds.width / 2, height: 5))
        slider.minimumValue = 0
        slider.maximumValue = 10
        slider.addTarget(self, action: #selector(sliderBanKinh), for: .valueChanged)
        self.viewContain.addSubview(slider)
    }
    func createBanKinh()
    {
        
    }
    func sliderBanKinh(sender: UISlider!)
    {
        print ("hihi")
        
        bankinh_search = Int(sender.value)
        bankinh.text = String(Int(sender.value)) + " km"
        self.viewContain.addSubview(bankinh)
        
    
    }
    
    func createSearchButton()
    {
        let button = UIButton(frame: CGRect(x: 20 +  UIScreen.main.bounds.width / 2 + 10, y: 10, width: 20, height: 20))
        button.setImage(UIImage(named: "search6.png"), for: .normal)
         button.addTarget(self, action: #selector(actionSearch), for: .touchUpInside)
        self.viewContain.addSubview(button)
    }
    func actionSearch(sender: UISlider!)
    {
        if (searchType == 0)
        {
            searchGPS(lat: lat, long: long)
        }
        else if (searchType == 1)
        {
            getLocationGoogleApi2()
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
                    self.formatted_address = formatted_address
                    
                    let camera = GMSCameraPosition.camera(withLatitude: self.lat, longitude: self.long, zoom: 15.0)
                    let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
                    mapView.delegate = self
                    self.view = mapView
                    let position = CLLocationCoordinate2D(latitude: self.lat, longitude: self.long)
                    let marker = GMSMarker(position: position)
                    marker.title = formatted_address
                    marker.map = mapView
                    
                    self.createViewContain()
                    
                //    self.createGPS()
                 //   self.createSlider()
                   // self.createBanKinh()
                   // self.createSearchButton()
                    
                }
                
                
                
                
            }catch{}
        }
        task.resume()
    }
    func getLocationGoogleApi2()
    {
        let url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=" + String(lat2) + "," + String(long2) + "&key=AIzaSyBQrSLHhtVml0KSdfz7px3fmwwlH-XdauA"
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
                    self.formatted_address = formatted_address
                    
                   self.searchGPS(lat: self.lat2, long: self.long2)
                    
                }
                
                
                
                
            }catch{}
        }
        task.resume()
    }
    func searchGPS(lat:Double, long:Double)
    {
        self.mang = []
        let searchGPS:SearchGPS = SearchGPS(latitude: lat, longitude: long, distance: bankinh_search)
        
        
        let json2 = JSONSerializer.toJson(searchGPS)
        
        
        print (json2)
        
        let jsonObject = self.convertToDictionary(text: json2)
        
        //  print (jsonObject)
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject)
        
        
        
        //  print (postString)
        var req = URLRequest(url: URL(string: "http://35.194.220.127/rem/rem_server/estate/searchGPSAll")!)
        
        req.httpMethod = "POST"
        req.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            
            
            do
            {
                // print ("asdasd")
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as AnyObject
                let estates = json["estates"] as! [AnyObject]
                for i in 0..<estates.count
                {
                    let id = estates[i]["id"] as! Int
                    
                    let date = estates[i]["postTime"] as! String
                    let title = estates[i]["name"] as! String
                    let price = estates[i]["price"] as! Double
                    let area = estates[i]["area"] as! Double
                    let address = estates[i]["address"] as! AnyObject
                    
                    let district = address["district"]
                        as! String
                    
                    let detail = estates[i]["detail"] as! AnyObject
                    let lat = detail["latitude"] as! Double
                    let long = detail["longitude"] as! Double
                    let name = estates[i]["name"] as! String
                    
                    let owner = estates[i]["owner"] as! AnyObject
                    let idOwner = owner["id"] as! Int
                    let avatar = estates[i]["avatar"] as! String
                    
                    let new_estate = Estate_New(ID: id,image: "", title: title, gia: price, dientich: area, quan: district, date: date, idOwner: idOwner, lat: lat, long: long, name: name, avatar: avatar)
                    
                    
                    
                    
                    self.mang.append(new_estate)
                    
                }
               
                
                
                
                if ( json["statuskey"] as! Bool)
                {
                    if (self.mang.count > 0)
                    {
                        DispatchQueue.main.async {
                            self.markerSearchResult(lat: lat, long: long)
                            
                            
                        }
                    }
                    else
                    {
                        let alert = UIAlertController(title: "Lỗi", message: "Không tìm thấy BĐS nào!", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                }
                else
                {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Alert", message: json["message"] as! String, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                }
                
                
                
            }catch{
                print ("catch")
                print (error)
            }
            
            
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
    func markerSearchResult(lat:Double, long:Double)
    {
        
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 13.0)
        
        
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.delegate = self
        self.view = mapView
        
        
        
        
        for i in 0..<mang.count
        {
            let position = CLLocationCoordinate2D(latitude: mang[i].lat, longitude: mang[i].long)
            let marker = GMSMarker(position: position)
            marker.title = mang[i].name
            marker.map = mapView
        }
//        self.createGPS()
//        self.createSlider()
//        self.createBanKinh()
//        self.createSearchButton()
        createViewContain()
    }
    func createViewContain()
    {
        viewContain = UIView()
        viewContain.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 50, width: UIScreen.main.bounds.width, height: 50)
        viewContain.backgroundColor = UIColor(cgColor: #colorLiteral(red: 0.9395621827, green: 0.9395621827, blue: 0.9395621827, alpha: 1).cgColor)
        self.view.addSubview(viewContain)
        createGPS()
        createSlider()
        createSearchButton()
        createBanKinh()
    }
    func createImageAvatar()
    {
        avatarButton = UIButton()
        //avatar = UIImageView()
        let data:Data = Data(base64Encoded: mang[indexAvatar].avatar)!
//        avatar.image = UIImage(data: data)
//        avatar.frame = CGRect(x: 20 +  UIScreen.main.bounds.width / 2 + 10 + 45, y: 10, width: 35, height: 35)
//        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imgMoreTapped))
//        avatar.isUserInteractionEnabled = true
//        avatar.addGestureRecognizer(tap)
//        self.viewContain.addSubview(avatar)
//        self.viewContain.bringSubview(toFront: avatar)
        
        
        avatarButton.frame = CGRect(x: 20 +  UIScreen.main.bounds.width / 2 + 10 + 35, y: 10, width: 35, height: 35)
        avatarButton.setImage(UIImage(data: data), for: .normal)
        avatarButton.addTarget(self, action: #selector(actionAvatar), for: .touchUpInside)
        self.viewContain.addSubview(avatarButton)
        
        
        
        
    }
    func actionAvatar(sender: UISlider!)
    {
        print ("fuck")
        
    }
    
    func imgMoreTapped()
    {
        print ("asdas")
    }
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        indexAvatar = getIndexMarker(title: marker.title!)
        createImageAvatar()
        return true
    }
    func getIndexMarker(title: String) -> Int
    {
        for i in 0..<mang.count
        {
            if ( mang[i].name == title )
            {
                return i
            }
        }
        return 0
    }
}
