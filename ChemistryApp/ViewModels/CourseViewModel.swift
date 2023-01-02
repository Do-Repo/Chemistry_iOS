//
//  CourseViewModel.swift
//  ChemistryApp
//
//  Created by Ghost weld rim on 6/12/2022.
//  Copyright © 2022 NexThings. All rights reserved.
//

import Foundation
import SwiftUI

class CoursesViewModel : ObservableObject {
    
    @Published var courses : [Course]?
    @Published var postedSuccesfully : Bool = false
    
    var title : String = ""
    var content : String = ""
    var price : Int = 0
    var tags : [String] = []
    var thumbnail : UIImage?
    
    func getCourses( ){
        CourseService().getCourses(){ result in
            switch result {
                
            case.success(let x):
                DispatchQueue.main.async {
                    self.courses = x!
                }
                
            case.failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func postCourse( image: UIImage ) {
        
        CourseService( ).createCourse(body: PostCourseRequestBody(price: price, content: content, title: title, tags: tags), thumbnail: image) { result in
            switch result {
                
            case.success(_):
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){ [self] in
                    postedSuccesfully = true
                }
            case.failure(let error):
                print(error.localizedDescription)
                
            }
            
        }
    }
}
