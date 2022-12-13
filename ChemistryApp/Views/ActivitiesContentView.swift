//
//  ShopContentView.swift
//  SwiftUIStarterKitApp
//
//  Created by Osama Naeem on 06/08/2019.
//  Copyright © 2019 NexThings. All rights reserved.
//

import SwiftUI
import Combine

struct ActivitiesContentView: View {
    @EnvironmentObject var auth : AuthViewModel
    @EnvironmentObject var courses : CoursesViewModel
    @EnvironmentObject var tags : TagsViewModel
    @State var isShowing: Bool = false
    @State var selectedCourse : Course? = nil
    
    
    
    var body: some View {
        GeometryReader { g in
            ScrollView{
                    VStack(alignment: .leading) {
                        if (self.tags.tags != nil) {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack (spacing: 10){
                                    ForEach(self.tags.tags!, id: \._id) { item in
                                        ShopPromotionBannerView(tag: item)
                                                .frame(width: 120, height: 60)
                                    }
                                }.padding(.leading, 30)
                                .padding(.trailing, 30)
                                .padding(.bottom, 10)
                            }
                            .padding(.top, 20)
                        }
                        
                        
                        Text("Popular Courses")
                            .font(.system(size: 20))
                            .padding(.leading, 30)
                            .padding(.top, 10)
                        if (self.courses.courses != nil) {
                            ScrollView(.horizontal, showsIndicators: false) {
                                        HStack (spacing: 10) {
                                            ForEach(self.courses.courses!, id: \._id)  { item in
                                                Button(action: {
                                                    self.isShowing = true
                                                    self.selectedCourse = item
                                                }) {
                                                    ShopBestSellerViews(course: item)
                                                                        .frame(width: 155, height: 225)
                                                }
                                            }
                                            
                                    }.padding(.leading, 30)
                                     .padding(.trailing, 30)
                                     .padding(.bottom, 10)
                                    
                            }
                        }
                        
                        if(self.courses.courses != nil) {
                            VStack (spacing: 20) {
                                ForEach(self.courses.courses!, id: \._id)  { item in
                                    ShopNewProductViews(course: item)
                                             .frame(width: g.size.width - 60, height: g.size.width - 60)
                                }
                            }.padding(.leading, 30)
                        }
                        
                        
                        
                    }
                    .navigationBarTitle("Explore")
                    .navigationBarItems(trailing:
                    Button(action: {
                        auth.logout()
                    }) {
                        Text("Log Out")
                    })
            }
            
            .sheet(isPresented: self.$isShowing) { CourseView(course: self.$selectedCourse) }
                
        }.onAppear() {
            self.courses.getCourses()
            self.tags.getTags()
        }
    }
}



struct ShopBestSellerViews: View {
    
    var course: Course
    
    var body: some View {
            ZStack{
                Image("\(course.thumbnail)").renderingMode(.original)
                        .resizable()
                        .frame(width: 155, height: 225)
                        .background(Color.black)
                        .cornerRadius(10)
                        .opacity(0.8)
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

struct ShopPromotionBannerView: View {
    var tag: Tags
    
    var body: some View {
        
        Button(action: {
            
        }) {
            GeometryReader { g in
                   ZStack{
                       Image("\(tag.colorCode)").renderingMode(.original)
                       .resizable()
                       .opacity(0.8)
                       .aspectRatio(contentMode: .fill)
                       .background(Color(tag.colorCode))
                    
                    
                    
                       Text(tag.name)
                                    .font(.system(size: 14, weight: .bold, design: Font.Design.default))
                                     .foregroundColor(Color.white)
                    
                               
                   }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                   .cornerRadius(15)
               }
        }
    }
}


struct ShopNewProductViews: View {
    var course: Course
    
    var body: some View {
        GeometryReader { g in
            ZStack {
                VStack (alignment: .leading){
                    Text(self.course.title)
                        .padding(.top, 18)
                        .padding(.leading, 18)
                        .font(.system(size: 20, weight: .bold, design: Font.Design.default))
                        .foregroundColor(Color.black)
                    Text(self.course.content)
                        .padding(.leading, 18)
                        .padding(.trailing, 18)
                        .font(.system(size: 14))
                        .foregroundColor(Color.black)
                    
                     Spacer()
                }
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
                .cornerRadius(10)
                
            }
        }
    }

