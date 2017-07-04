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
    var user1:String
    var user2:String
    var note:String
    var estate:Int
    var id:Int
    init(address:String, time:String, status:Int, name:String, user1:String, user2:String, note:String,estate:Int, id:Int) {
        self.address = address
        self.time = time
        self.status = status
        self.name = name
        self.user1 = user1
        self.user2 = user2
        self.estate = estate
        self.note = note
        self.id = id
    }
}
