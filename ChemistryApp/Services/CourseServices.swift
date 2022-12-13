//
//  CourseServices.swift
//  ChemistryApp
//
//  Created by Ghost weld rim on 6/12/2022.
//  Copyright © 2022 NexThings. All rights reserved.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

class CourseService {
    
    func getCourses(completion: @escaping(Result<[Course
    ]?, AuthError>) -> Void) {
        AF.request("\(Constants.BASE_URL)api/course",
                   method: .get,
                   encoding: JSONEncoding.default,
                   headers: [
                    .authorization(bearerToken: UserDefaults.standard.string(forKey: "token")!)
                   ]
        )
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseData { res in
            switch res.result {
                
            case .success:
                let responseData = Data(res.data!)
                do {
                    let parsedData = try JSONDecoder().decode(GetCoursesResponse.self, from: responseData)
                    completion( .success(parsedData.courses))
                    
                } catch {
                    print(error)
                }
                
            case let .failure(err):
                debugPrint(err)
                completion(.failure(
                    .custom(errorMessage: err.localizedDescription)))
            }
            
        }
    }
    
    func enrollCourse(body: [Course] ,completion: @escaping(Result<UserExtras, AuthError>) -> Void){
        var courses : [String] = []
        body.forEach { course in
            courses.append(course._id)
        }
    
        AF.request("\(Constants.BASE_URL)api/course/buy",
                   method: .post,
                   parameters: [
                    "courses": courses
                   ],
                   encoding: JSONEncoding.default,
                   headers:  [
                    .authorization(bearerToken: UserDefaults.standard.string(forKey: "token")!)
                   ]
        )
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseData { res in
            switch res.result {
                
            case .success:
                let responseData = Data(res.data!)
                do {
                    let parsedData = try JSONDecoder().decode(BuyCourseResponse.self, from: responseData)
                    completion(.success(parsedData.extras))
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
