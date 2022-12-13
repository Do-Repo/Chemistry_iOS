//
//  TagsService.swift
//  ChemistryApp
//
//  Created by Ghost weld rim on 7/12/2022.
//  Copyright © 2022 NexThings. All rights reserved.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

class TagsService {
    
    func getTags(completion: @escaping(Result<[Tags]?, AuthError>) -> Void) {
        AF.request("\(Constants.BASE_URL)api/tags",
                   method: .get,
                   encoding: JSONEncoding.default,
        headers: [
            .authorization(bearerToken: UserDefaults.standard.string(forKey: "token")!)
        ])
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseData { res in
            switch res.result {
                
            case .success:
                let responseData = Data(res.data!)
                do {
                    let parsedData = try JSONDecoder().decode(getTagsResponse.self, from: responseData)
                    completion(.success(parsedData.tags))
                } catch {
                    print(error)
                }
                
            case let .failure(err):
                debugPrint(err)
                completion(.failure(.custom(errorMessage: err.localizedDescription)))
            }
        }
    }
}
