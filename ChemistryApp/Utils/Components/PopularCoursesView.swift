//
//  PopularCoursesView.swift
//  ChemistryApp
//
//  Created by yasine romdhane on 2/1/2023.
//  Copyright © 2023 NexThings. All rights reserved.
//

import SwiftUI

struct PopularCoursesView: View {
    
    var course: Course
    
    var body: some View {
        ZStack{
            AsyncImage(url: URL(string: course.thumbnail)){ image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }.frame(width: 155, height: 225)
                .background(Color.black.opacity(0.2))
                .cornerRadius(10)
                .aspectRatio(contentMode: .fill)
            
            VStack (alignment: .leading) {
                Spacer()
                
                Text(course.title)
                    .foregroundColor(Color.white)
                    .font(.system(size: 20, weight: .bold, design: Font.Design.default))
                    .padding(.bottom, 24)
            }
            
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color.white)
        
    }
}

