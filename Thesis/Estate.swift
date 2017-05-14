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
    var image:String
    var title:String
    var gia:String
    var dientich:String
    var quan:String
    var date:String
    init(image:String,title:String, gia:String, dientich:String, quan:String, date:String) {
        self.image = image
        self.title = title
        self.gia = gia
        self.dientich = dientich
        self.quan = quan
        self.date = date
    }
}
