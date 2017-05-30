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
    var address:String
    var id:Int
    init(city:String, district: String, ward:String, address:String, id:Int) {
        self.city = city
        self.district = district
        self.ward = ward
        self.address = address
        self.id = id
    }
}
