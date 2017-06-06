//
//  Appointment.swift
//  Thesis
//
//  Created by Tri Quach on 6/4/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
class Appointment
{
    var address:String
    var note:String
    var time:String
    var status:Int
    var user1:User
    var user2:User
    var id:Int
    var name:String
    init(address:String, note:String, time:String, status:Int, user1:User, user2:User, id:Int, name:String) {
        self.address = address
        self.note = note
        self.time = time
        self.status = status
        self.user1 = user1
        self.user2 = user2
        self.id = id
        self.name = name
    }
}
