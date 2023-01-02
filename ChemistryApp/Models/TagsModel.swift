//
//  TagsModel.swift
//  ChemistryApp
//
//  Created by Ghost weld rim on 7/12/2022.
//  Copyright © 2022 NexThings. All rights reserved.
//

import Foundation

struct Tags : Codable, Equatable {
    let _id, colorCode, name : String;
}

struct getTagsResponse : Codable {
    let status : String;
    let tags : [Tags];
}
