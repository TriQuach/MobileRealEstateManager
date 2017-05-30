//
//  EstatePostNew.swift
//  Thesis
//
//  Created by Tri Quach on 5/30/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
class EstatePostNew
{
    var owner: UserEstatePostNew
    var address:Address
    var detail:Detail
    var type:Int
    var price:Double
    var area:Double
    var name:String
    var broker:Bool
    
    init(owner: UserEstatePostNew, address:Address, detail:Detail, type:Int, price:Double, area:Double, name:String, broker:Bool) {
        self.owner = owner
        self.address = address
        self.detail = detail
        self.type = type
        self.price = price
        self.area = area
        self.name = name
        self.broker = broker
    }
}
