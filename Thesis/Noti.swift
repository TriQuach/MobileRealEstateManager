//
//  Noti.swift
//  Thesis
//
//  Created by Tri Quach on 7/18/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
class Noti
{
    var nameEstate:String
    var userFullName:String
    var avatar:String
    var idNoti:Int
    var idRequestUser:Int
    var idEstate:Int
    var typeNoti:Int
    init(nameEstate:String, userFullName:String, avatar:String, idNoti:Int, idRequestUser:Int, idEstate:Int, typeNoti:Int) {
        self.nameEstate = nameEstate
        self.userFullName = userFullName
        self.avatar = avatar
        self.idNoti = idNoti
        self.idRequestUser = idRequestUser
        self.idEstate = idEstate
        self.typeNoti = typeNoti
    }
}
