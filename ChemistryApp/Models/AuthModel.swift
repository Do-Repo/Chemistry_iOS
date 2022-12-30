//
//  AuthModel.swift
//  ChemistryApp
//
//  Created by Apple Esprit on 22/11/2022.
//  Copyright © 2022 NexThings. All rights reserved.
//

import Foundation

enum AuthError : Error {
    case custom(errorMessage: String)
}

struct LoginRequestBody : Codable {
    let email, password: String
}

struct AuthResponse : Codable {
    let status, accessToken, message: String?
    let user : User?
    let extras : UserExtras?
}

struct RegisterRequestBody : Codable {
    let name, email, phone, password, passwordConfirm, role : String
}


