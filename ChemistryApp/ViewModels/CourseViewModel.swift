//
//  CourseViewModel.swift
//  ChemistryApp
//
//  Created by Ghost weld rim on 6/12/2022.
//  Copyright © 2022 NexThings. All rights reserved.
//

import Foundation

class CoursesViewModel : ObservableObject {
    
    @Published var courses : [Course]?
    
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
}
