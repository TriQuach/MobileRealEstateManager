//
//  Estate_New.swift
//  Thesis
//
//  Created by Tri Quach on 8/12/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
class Estate_New
{
    var ID:Int
    var image:String
    var title:String
    var gia:Double
    var dientich:Double
    var quan:String
    var date:String
    var idOwner:Int
    var lat:Double
    var long:Double
    var name:String
    var avatar:String
    init(ID:Int, image:String,title:String, gia:Double, dientich:Double, quan:String, date:String,idOwner:Int, lat:Double, long:Double, name:String, avatar:String) {
        self.ID = ID
        self.image = image
        self.title = title
        self.gia = gia
        self.dientich = dientich
        self.quan = quan
        self.date = date
        self.idOwner = idOwner
        self.lat = lat
        self.long = long
        self.name = name
        self.avatar = avatar
    }
    
    
}
