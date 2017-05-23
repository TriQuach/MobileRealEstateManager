//
//  FullEstate.swift
//  Thesis
//
//  Created by Tri Quach on 5/23/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
class FullEstate
{
    var owner: User
    var address: Address
    var available: Bool
    var type: String
    var postTime: String
    var price: Double
    var area: Double
    var id: Int
    var name: String
    init(owner: User, address: Address, available: Bool, type: String, postTime: String, price: Double, area: Double, id: Int, name: String ) {
        self.owner = owner
        self.address = address
        self.available = available
        self.type = type
        self.postTime = postTime
        self.price = price
        self.area = area
        self.id = id
        self.name = name
    }
}
