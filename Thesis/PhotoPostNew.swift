//
//  PhotoPostNew.swift
//  Thesis
//
//  Created by Tri Quach on 6/13/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
class PhotoPostNew
{
    var id: Int
    var photos: [Photo]
    var avatar: Int
    init(id: Int, photos: [Photo], avatar: Int) {
        self.id = id
        self.photos = photos
        self.avatar = avatar
    }
}
