//
//  AuthService.swift
//  ChemistryApp
//
//  Created by Apple Esprit on 22/11/2022.
//  Copyright © 2022 NexThings. All rights reserved.
//

import Foundation
import SwiftyJSON
import SwiftUI
import Alamofire

class AuthService {
    
    func login(body: LoginRequestBody, completion: @escaping(Result<AuthResponse?, AuthError>) -> Void) {
        AF.request("\(Constants.BASE_URL)api/auth/login",
                   method: .post,
                   parameters: [
                    "email": body.email,
                    "password": body.password],
                   encoding: JSONEncoding.default)
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseData { res in
            switch res.result {
                
            case .success:
                let responseData = Data(res.data!)
                do {
                    let parsedData = try JSONDecoder().decode(AuthResponse.self, from: responseData)
                    UserDefaults.standard.set(parsedData.accessToken, forKey: "token")
                    completion(.success(parsedData))
                } catch {print(error)}
                
                
            case let .failure(err):
                debugPrint(err)
                completion(.failure(.custom(errorMessage: err.localizedDescription)))
            }
        }
    }
    
    func signup(body: RegisterRequestBody, completion: @escaping(Result<AuthResponse?, AuthError>) -> Void) {
        AF.request("\(Constants.BASE_URL)api/auth/register",
                   method: .post,
                   parameters: [
                    "name": body.name,
                    "email": body.email,
                    "phone": body.phone,
                    "password": body.password,
                    "passwordConfirm": body.passwordConfirm,
                    "role": body.role
                   ],
                   encoding: JSONEncoding.default)
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseData { res in
            switch res.result {
                
            case.success:
                let responseData = Data(res.data!)
                do {
                    let parsedData = try JSONDecoder().decode(AuthResponse.self, from: responseData)
                    UserDefaults.standard.set(parsedData.accessToken, forKey: "token")
                    completion(.success(parsedData))
                } catch {print(error)}
                
            case let .failure(err):
                debugPrint(err)
                completion(.failure(.custom(errorMessage: err.localizedDescription)))
                
            }
        }
    }
    
    func updateUser(body: UserUpdateRequestBody, completion: @escaping(Result<User?, AuthError>) -> Void) {
        AF.request("\(Constants.BASE_URL)api/user/profile/update",
                   method: .post,
                   parameters: [
                    //"avatar": body.avatar!,
                    "name": body.name!,
                    "email": body.email!,
                    "phone": body.phone!,
                   ],
                   encoding: JSONEncoding.default,
                   headers: [
                    .authorization(bearerToken: UserDefaults.standard.string(forKey: "token")!)
                   ]
        )
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseData { res in
            switch res.result {
                
            case.success:
                let responseData = Data(res.data!)
                do {
                    let parsedData = try JSONDecoder().decode(UserUpdateResponse.self, from: responseData)
                    
                    completion(.success(parsedData.user))
                } catch {print(error)}
            case let .failure(err):
                debugPrint(err)
                completion(.failure(.custom(errorMessage: err.localizedDescription)))
            }
        }
    }
    
    func setProfilePicture(image : UIImage, completion: @escaping(Result<User?, AuthError>) -> Void) {
        let imageData = image.jpegData(compressionQuality: 0.5)
        
        AF.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imageData!, withName: "userImage", fileName: "image.jpeg", mimeType: "image/jpeg")
            
            
        }, to: "\(Constants.BASE_URL)api/user/upload/avatar",
                  method: .post,
                  headers: [
                   .authorization(bearerToken: UserDefaults.standard.string(forKey: "token")!)
                  ])
        .uploadProgress(queue: .main, closure: {
            progress in print("upload progress: \(progress.fractionCompleted)")
        })
        .responseData { res in
            switch res.result {
            case .success:
                let responseData = Data(res.data!)
                do {
                    let parsedData = try JSONDecoder().decode(UserUpdateResponse.self, from: responseData)
                    completion(.success(parsedData.user))
                }catch { print(error)}
            case .failure(let err): print(err.localizedDescription)
            }
            
        }
    
    }
}
