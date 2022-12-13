//
//  UserModel.swift
//  ChemistryApp
//
//  Created by Apple Esprit on 22/11/2022.
//  Copyright © 2022 NexThings. All rights reserved.
//

import Foundation
import SwiftUI


struct User : Codable {
    var _id, name, email, phone, role, extras, createdAt, updatedAt, avatarUrl, publicid: String
    var isVerified: Bool
}

struct UserExtras : Codable {
    var _id : String
    var likedCourses, followingMentors, boughtCourses : [String]
}

struct UserUpdateRequestBody : Codable {
    var avatar, name, email, phone: String?
}

struct UserUpdateResponse : Codable {
    let status: String?
    let user : User?
    
}
