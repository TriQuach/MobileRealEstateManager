//
//  CollapsedEstate.swift
//  Thesis
//
//  Created by TriQuach on 5/14/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
class Estate
{
    var ID:Int
    var image:String
    var title:String
    var gia:Double
    var dientich:Double
    var quan:String
    var date:String
    var idOwner:Int
    init(ID:Int, image:String,title:String, gia:Double, dientich:Double, quan:String, date:String,idOwner:Int) {
        self.ID = ID
        self.image = image
        self.title = title
        self.gia = gia
        self.dientich = dientich
        self.quan = quan
        self.date = date
        self.idOwner = idOwner
    }
}
