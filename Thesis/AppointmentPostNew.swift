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
    var name:String
    var time:String
    var userid:Int
    var note:String
    init(name:String, time:String, userid:Int, note:String) {
        self.name = name
        self.time = time
        self.userid = userid
        self.note = note
    }
}
