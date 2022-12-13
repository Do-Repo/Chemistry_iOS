//
//  CourseView.swift
//  ChemistryApp
//
//  Created by Apple Esprit on 10/12/2022.
//  Copyright © 2022 NexThings. All rights reserved.
//
import SwiftUI
import Combine




struct CourseView: View {
    @EnvironmentObject var auth : AuthViewModel
    @EnvironmentObject var cart : CartViewModel
    @Binding var course: Course?
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                Image("capetown")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width ,height: 250)
                    .clipped()
                    
                ZStack(alignment: .leading) {
                    ScrollView {
                        VStack(alignment: .leading) {
                            Text(course!.title)
                                .font(.title)
                            .padding([.top, .leading])
                            
                            Text(course!.content)
                            .padding([.top, .leading])
                            
                        }
                    }
                    
                    if(!self.auth.userExtras!.boughtCourses.contains(course!._id)){
                        Rectangle()
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [.black, .white.opacity(0)]), startPoint: .center, endPoint: .top)
                            )
                            .frame(height: .infinity)
                            .ignoresSafeArea()
                        
                       
                        HStack ( ) {
                            Text("You don't own this course\nTo continue exploring enroll now!")
                                .font(.system(.subheadline).weight(.bold))
                                    .foregroundColor(.white)
                            
                            Spacer()
                                    
                            Button("Enroll", action: {
                            //This works bro
                            // auth.buyCourse(course: BuyCourseRequestBody(courses: [course!]))
                                self.cart.addToCart(course: course!)
                            })
                                .font(.system(.subheadline).weight(.bold))
                                .padding()
          
                        }
                        .padding([.leading, .trailing, .bottom])
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    }
                    
                        
                    
                            
                    
                        
                    
                }
             
                Spacer()
                
                
            }.ignoresSafeArea()
        }
    }
}
//
//struct CourseView_Previews: PreviewProvider {
   // static var previews: some View {
      //  CourseView()
    //}
//}
