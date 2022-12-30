//
//  CoursesModel.swift
//  ChemistryApp
//
//  Created by Ghost weld rim on 6/12/2022.
//  Copyright © 2022 NexThings. All rights reserved.
//

import Foundation

struct Course : Codable {
    let price : Int;
    let _id, owner, title, content, thumbnail, createdAt: String;
    let likes : Int;
    let tags : [String]
}

struct PostCourseResponse : Codable {
    let status : String;
    let course : Course;
}

struct GetCoursesResponse : Codable {
    let status: String;
    let courses: [Course]?
}

struct BuyCourseResponse : Codable {
    let status : String
    let extras : UserExtras
}

struct BuyCourseRequestBody : Codable {
    let courses : [Course]
}
