//
//  PostCourseView.swift
//  ChemistryApp
//
//  Created by yasine romdhane on 29/12/2022.
//  Copyright © 2022 NexThings. All rights reserved.
//

import SwiftUI
import Combine

struct PostCourseView: View {
    @State var titleInput : String = ""
    @State var contentInput : String = ""
    @State var priceInput : String = "0"
    @State var hasAR : Bool = false
    @State private var inputImage : UIImage?
    @State private var showingImagePicker : Bool = false
    @State private var showAllTags : Bool = false
    @State private var chosenTags : [String]? = [ ]
    
    @EnvironmentObject var course : CoursesViewModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                
                
                Button(action: {
                    showingImagePicker = true
                }) {
                    if(inputImage == nil) {
                        HStack {
                            Spacer( )
                            VStack (alignment: .center) {
                                Spacer( )
                                Image("add-photo")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                Text("Add thumbnail")
                                    .font(.headline)
                                    .padding(.bottom)
                            }
                            .foregroundColor(Color.white)
                            .frame(height: 250)
                            Spacer( )
                        }.background(Rectangle().fill(.gray.opacity(0.7)))
                    }else{
                        Image(uiImage: inputImage!)
                            .resizable()
                            .frame(height: 250)
                    }
                    
                }
                
                Form {
                    Section(header: Text("Course information")) {
                        TextField("Course title", text: $titleInput)
                        NavigationLink(destination: TagsView(chosenTags: $chosenTags, comingFrom: "select")) {
                            VStack (alignment: .leading) {
                                Text("Tags")
                                    .font(.headline)
                                Text("Chosen tags: \(chosenTags?.count ?? 0)")
                                    .font(.subheadline)
                            }
                            
                        }
                        TextField("Course price", text: $priceInput)
                            .onReceive(Just(priceInput)) { newValue in
                                let filtered = newValue.filter { "0123456789".contains($0) }
                                if filtered != newValue {
                                    self.priceInput = filtered
                                }
                            }
             
                        Toggle(isOn: self.$hasAR.animation() ) {
                                  Text("With Augmented Reality")
                                .font(.headline)
                            }
                        
                    }
                    
                    if(hasAR){
                        Section(header: Text("Augmented Reality")) {
                            NavigationLink(destination: ProfileView()) {
                                Text("Upload 3D model")
                                    .font(.headline)
                            }
                        }
                    }
                    
                    
                    Section(header: Text("Course content")) {
                        TextEditor(text: $contentInput)
                                .foregroundColor(.black)
                    }
                }
                
                
                HStack {
                    Spacer()
                }
                
                Spacer()
                
                Button(action: {
                    course.title = titleInput
                    course.content = contentInput
                    course.tags = chosenTags!
                    course.price = Int(priceInput)!
                    course.postCourse(image: inputImage!)
                }) {
                       HStack {
                           Text("Publish Course")
                       }
                           .padding()
                           .frame(width: geometry.size.width - 40, height: 40)
                           .foregroundColor(Color.white)
                           .background(Color.blue)
                           .cornerRadius(5)
                   }
                    .padding( )
                
            }.background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
                .ignoresSafeArea(edges: .top)
                .sheet(isPresented: $showingImagePicker) {
                    ImagePicker(image: $inputImage)
                }
        }
    }
}

//struct PostCourseView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostCourseView()
//    }
//}
