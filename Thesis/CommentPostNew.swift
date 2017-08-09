//
//  CommentPostNew.swift
//  Thesis
//
//  Created by Tri Quach on 8/9/17.
//  Copyright © 2017 TriQuach. All rights reserved.
//

import Foundation
class CommentPostNew
{
    var question:String
    var buyerId:Int
    var ownerId:Int
    var estateId:Int
    init(question:String, buyerId:Int, ownerId:Int, estateId:Int) {
        self.question = question
        self.buyerId = buyerId
        self.ownerId = ownerId
        self.estateId = estateId
    }
}
