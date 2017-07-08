//
//  Detail.swift
//  Thesis
//
//  Created by Tri Quach on 5/26/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
class Detail
{
    var bathroom: Int
    var bedroom: Int
    var condition: String
    var description: String
    var floor: Int
    var length: Double
    var width: Double
    var longitude:Double
    var latitude:Double
    var id: Int
    init(bathroom: Int, bedroom: Int, condition: String, description: String, floor: Int, length: Double, width: Double, longitude:Double,latitude:Double,  id: Int) {
        self.bathroom = bathroom
        self.bedroom = bedroom
        self.condition = condition
        self.description = description
        self.floor = floor
        self.length = length
        self.width = width
        self.longitude = longitude
        self.latitude = latitude
        self.id = id
    }
}
