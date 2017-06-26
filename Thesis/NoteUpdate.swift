//
//  NoteUpdate.swift
//  
//
//  Created by Tri Quach on 6/26/17.
//
//

import Foundation
class NoteUpdate
{
    var UserID:Int
    var EstateID:Int
    var Note:String
    init(userId:Int, estateId:Int, note:String) {
        self.UserID = userId
        self.EstateID = estateId
        self.Note = note
    }
}
