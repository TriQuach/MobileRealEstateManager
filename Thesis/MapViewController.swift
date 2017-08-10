//
//  MapViewController.swift
//  Thesis
//
//  Created by Tri Quach on 8/11/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import UIKit
import GoogleMaps
class MapViewController: UIViewController,GMSMapViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.delegate = self
        view = mapView
        
        //print (UIScreen.main.bounds.width)
        
        
        let button = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 40, y: UIScreen.main.bounds.height - 40, width: 20, height: 20))
        button.setImage(UIImage(named: "gps.png"), for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(button)
        //
        //         Do any additional setup after loading the view.
    }
    func buttonAction(sender: UIButton!) {
        print("Button tapped")
    }
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print (coordinate.latitude)
        print (coordinate.latitude)
        
        let position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let marker = GMSMarker(position: position)
        marker.title = "Hello World"
        marker.map = mapView
        
        
    }
    

}
