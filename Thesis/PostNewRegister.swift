//
//  PostNewRegister.swift
//  Thesis
//
//  Created by Tri Quach on 6/21/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
class PostNewRegister
{
    var Email:String
    var Password:String
    var UserType:Int
    var FullName:String
    var Phone:String
    var UserName:String
    init(Email:String, Password:String, UserType:Int, FullName:String, Phone:String, UserName:String) {
        self.Email = Email
        self.Password = Password
        self.UserType = UserType
        self.FullName = FullName
        self.Phone = Phone
        self.UserName = UserName
    }
}
