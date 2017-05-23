//
//  Address.swift
//  Thesis
//
//  Created by Tri Quach on 5/23/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
class Address
{
    var city:String
    var district: String
    var ward:String
    var street:String
    var address:String
    var id:Int
    init(city:String, district: String, ward:String, street:String, address:String, id:Int) {
        self.city = city
        self.district = district
        self.ward = ward
        self.street = street
        self.address = address
        self.id = id
    }
}
