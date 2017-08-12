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
    var mang:[Estate_New] = []
    var formatted_address:String!
    var bankinh:UILabel = UILabel()
    var bankinh_search:Int!
    let locationManager = CLLocationManager()
    var check:Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.delegate = self
        view = mapView
        bankinh = UILabel(frame: CGRect(x: 10 + UIScreen.main.bounds.width / 4, y: UIScreen.main.bounds.height - 30, width: 40, height: 21))
        createGPS()
        //print (UIScreen.main.bounds.width)
        createSlider()
        createSearchButton()
        
        
        
        
        //
        //         Do any additional setup after loading the view.
    }
    func buttonAction(sender: UIButton!) {
        print("Button tapped")
        
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
        print (coordinate.latitude)
        print (coordinate.latitude)
        
        let position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let marker = GMSMarker(position: position)
        marker.title = "Hello World"
        marker.map = mapView
        
        
    }
    func createGPS()
    {
        let button = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 40, y: UIScreen.main.bounds.height - 55, width: 20, height: 20))
        button.setImage(UIImage(named: "gps.png"), for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(button)
    }
    func createSlider()
    {
        let slider:UISlider = UISlider(frame: CGRect(x: 20, y: UIScreen.main.bounds.height - 50, width: UIScreen.main.bounds.width / 2, height: 10))
        slider.minimumValue = 0
        slider.maximumValue = 10
        slider.addTarget(self, action: #selector(sliderBanKinh), for: .valueChanged)
        self.view.addSubview(slider)
    }
    func createBanKinh()
    {
        
    }
    func sliderBanKinh(sender: UISlider!)
    {
        print ("hihi")
        bankinh_search = Int(sender.value)
        bankinh.text = String(Int(sender.value)) + " km"
        self.view.addSubview(bankinh)
        
    
    }
    
    func createSearchButton()
    {
        let button = UIButton(frame: CGRect(x: 20 +  UIScreen.main.bounds.width / 2 + 10, y: UIScreen.main.bounds.height - 55, width: 20, height: 20))
        button.setImage(UIImage(named: "search6.png"), for: .normal)
         button.addTarget(self, action: #selector(actionSearch), for: .touchUpInside)
        self.view.addSubview(button)
    }
    func actionSearch(sender: UISlider!)
    {
        searchGPS(address: self.formatted_address)
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
                    
                    self.createGPS()
                    self.createSlider()
                    self.createBanKinh()
                    self.createSearchButton()
                    
                }
                
                
                
                
            }catch{}
        }
        task.resume()
    }
    func searchGPS(address: String)
    {
        
        let searchGPS:SearchGPS = SearchGPS(latitude: lat, longitude: long, distance: bankinh_search)
        
        
        let json2 = JSONSerializer.toJson(searchGPS)
        
        
        print (json2)
        
        let jsonObject = self.convertToDictionary(text: json2)
        
        //  print (jsonObject)
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject)
        
        
        
        //  print (postString)
        var req = URLRequest(url: URL(string: "http://35.194.220.127/rem/rem_server/estate/searchGPS/0")!)
        
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
                    
                    let new_estate = Estate_New(ID: id,image: "", title: title, gia: price, dientich: area, quan: district, date: date, idOwner: idOwner, lat: lat, long: long, name: name)
                    
                    
                    
                    
                    self.mang.append(new_estate)
                    
                }
               
                
                
                
                if ( json["statuskey"] as! Bool)
                {
                    if (self.mang.count > 0)
                    {
                        DispatchQueue.main.async {
                            self.markerSearchResult()
                            
                            
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
    func markerSearchResult()
    {
        let camera = GMSCameraPosition.camera(withLatitude: self.lat, longitude: self.long, zoom: 15.0)
        
        
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
        self.createGPS()
        self.createSlider()
        self.createBanKinh()
        self.createSearchButton()
    }
}
