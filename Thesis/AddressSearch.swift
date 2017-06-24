//
//  AddressSearch.swift
//  Thesis
//
//  Created by Tri Quach on 6/24/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
class AddressSearch
{
    var city:String
    var district:String
    var ward:String
    var address:String
    init(city:String, district:String, ward:String, address:String) {
        self.city = city
        self.district = district
        self.ward = ward
        self.address = address
    }
}
