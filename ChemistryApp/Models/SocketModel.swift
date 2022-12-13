//
//  SocketModel.swift
//  ChemistryApp
//
//  Created by Apple Esprit on 11/12/2022.
//  Copyright © 2022 NexThings. All rights reserved.
//

import Foundation

class SocketResponse : Decodable {
    var test : String
}

class SocketModel {
    
    static func convert<T: Decodable>(data: Any) throws -> T {
        let jsonData = try JSONSerialization.data(withJSONObject: data)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: jsonData)
    }
    
    static func convert<T: Decodable>(datas: [Any]) throws -> [T] {
        return try datas.map { (dict) -> T in
            let jsonData = try JSONSerialization.data(withJSONObject: dict)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: jsonData)
            
        }
    }
}
