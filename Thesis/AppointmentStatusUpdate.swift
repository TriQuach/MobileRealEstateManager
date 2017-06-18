//
//  AppointmentStatusUpdate.swift
//  Thesis
//
//  Created by Tri Quach on 6/18/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
class AppointmentStatusUpdate
{
    var ApptID: Int
    var Status: Int
    init(ApptID: Int, Status: Int) {
        self.ApptID = ApptID
        self.Status = Status
    }
}
