//
//  SimpleAppointment.swift
//  Thesis
//
//  Created by Tri Quach on 6/6/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
class SimpleAppointment
{
    var address:String
    var time:String
    var status:Int
    var name:String
    init(address:String, time:String, status:Int, name:String) {
        self.address = address
        self.time = time
        self.status = status
        self.name = name
    }
}
