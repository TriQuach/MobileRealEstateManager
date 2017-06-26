//
//  PhotoNote.swift
//  Thesis
//
//  Created by Tri Quach on 6/26/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
class PhotoNote
{
    var UserID:Int
    var EstateID:Int
    var photos:[Photo]
    init(UserID:Int, EstateID:Int, photos:[Photo]) {
        self.UserID = UserID
        self.EstateID = EstateID
        self.photos = photos
    }
}
