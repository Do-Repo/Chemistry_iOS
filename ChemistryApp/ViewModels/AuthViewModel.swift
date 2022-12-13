//
//  LogInViewModel.swift
//  ChemistryApp
//
//  Created by Apple Esprit on 22/11/2022.
//  Copyright © 2022 NexThings. All rights reserved.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

class AuthViewModel : ObservableObject {
    
    @Published var loginAlert = false
    @Published var isAuthenticated : Bool = false
    @Published var navigateNowToLogin : Bool = false
    @Published var navigateNowToSignup : Bool = false
    @Published var currentUser : User?
    @Published var userExtras : UserExtras?

    var email: String = ""
    var password: String = ""
    var name: String = ""
    var passwordConfirm: String = ""
    var phone: String = ""
    
    
    func login(){
        let defaults = UserDefaults.standard
        
        AuthService().login(body: LoginRequestBody(email: email, password: password)){ result in
            switch result {
                
            case.success(let user):
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    withAnimation{
                        self.currentUser = user?.user!
                        self.userExtras = user?.extras
                        self.isAuthenticated = true
                    }
                }
                
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func register(){
        AuthService().signup(body: RegisterRequestBody(name: name, email: email, phone: phone, password: password, passwordConfirm: passwordConfirm)) { result in
            switch result {
            case.success(let user):
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    withAnimation{
                        self.navigateNowToLogin=true
                    }
                }
            case.failure(let error):
                print(error.localizedDescription)
                
            }
            
        }
        
    }
    
    func logout( ){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "accessToken")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation {
                self.isAuthenticated = false
            }
        }
    }
    
    func updateImage(image : UIImage ) {
        AuthService().setProfilePicture(image: image){ result in
            switch result {
            case.success(let user):
                DispatchQueue.main.async {
                    self.currentUser = user!
                }
                
            case.failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func updateUser(user: UserUpdateRequestBody){
        AuthService().updateUser(
            body: UserUpdateRequestBody(
                name: user.name ?? currentUser?.name,
                email: user.email ?? currentUser?.email,
                phone: user.phone ?? currentUser?.phone)) { result in
                switch result {
                case.success(let user):
                    DispatchQueue.main.async {
                        self.currentUser = user!
                    }
                    
                case.failure(let err):
                    print(err.localizedDescription)
                }
            }
    }
    
    func buyCourse(course: BuyCourseRequestBody){
        CourseService().enrollCourse(body: course.courses){ result in
            switch result {
            case.success(let userExtras):
                DispatchQueue.main.async {
                    self.userExtras = userExtras
                }
                
            case.failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
