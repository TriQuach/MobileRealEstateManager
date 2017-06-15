//
//  AppointmentPostNew.swift
//  Thesis
//
//  Created by Tri Quach on 6/12/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
class AppointmentPostNew
{
   
    var address:String
    var note:String
    var time:String
    var user1:UserIdBookAppointment
    var user2:UserIdBookAppointment
    var name:String
    init(name:String,address:String, time:String, user1:UserIdBookAppointment,user2:UserIdBookAppointment, note:String) {
        self.name = name
        self.address = address
        self.time = time
        self.user1 = user1
        self.user2 = user2
        self.note = note
    }
}
