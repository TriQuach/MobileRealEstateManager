//
//  Appointments.swift
//  Thesis
//
//  Created by Tri Quach on 6/6/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
class Appointments
{
    var listAppointment: [Appointment]
    var statuskey: Bool
    init(listAppointment: [Appointment], statuskey: Bool) {
        self.listAppointment = listAppointment
        self.statuskey = statuskey
    }
    
    
}
