//
//  User.swift
//  Thesis
//
//  Created by Tri Quach on 5/23/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation

class User
{
    var email:String
    var password:String
    var address:String
    var typeID:Int
    var fullName:String
    var phone:String
    var id:Int
    var name:String
    var avatar:String
    init(email:String, password:String, address:String, typeID:Int, fullName:String, phone:String, id:Int, name:String, avatar:String) {
        self.email = email
        self.password = password
        self.address = address
        self.typeID = typeID
        self.fullName = fullName
        self.phone = phone
        self.id = id
        self.name = name
        self.avatar = avatar
    }
}
