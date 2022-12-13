//
//  TagsViewModel.swift
//  ChemistryApp
//
//  Created by Ghost weld rim on 7/12/2022.
//  Copyright © 2022 NexThings. All rights reserved.
//

import Foundation

class TagsViewModel : ObservableObject {
    
    @Published var tags : [Tags]?
    
    func getTags( ){
        TagsService().getTags() { result in
            switch result {
                
            case.success(let x):
                DispatchQueue.main.async {
                    self.tags = x!
                }
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
