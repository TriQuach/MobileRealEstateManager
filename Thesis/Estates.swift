//
//  Estates.swift
//  Thesis
//
//  Created by Tri Quach on 5/23/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
class Estates
{
    var listEstates:[FullEstate]
    var statuskey: Bool
    init(listEstates:[FullEstate], statuskey: Bool ) {
        self.listEstates = listEstates
        self.statuskey = statuskey
    }
}
