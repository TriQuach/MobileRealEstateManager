//
//  PostNewSearch.swift
//  Thesis
//
//  Created by Tri Quach on 6/24/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
class PostNewSearch
{
    var address:AddressSearch
    var detail:DetailSearch
    var type:String
    var price:Int
    var area:Int
    var userID:Int
    init(address:AddressSearch, detail:DetailSearch, type:String, price:Int, area:Int, userID:Int) {
        self.address = address
        self.detail = detail
        self.type = type
        self.price = price
        self.area = area
        self.userID = userID
    }
}
