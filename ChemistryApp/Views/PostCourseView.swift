//
//  PostCourseView.swift
//  ChemistryApp
//
//  Created by yasine romdhane on 29/12/2022.
//  Copyright © 2022 NexThings. All rights reserved.
//

import SwiftUI

struct PostCourseView: View {
    @State var titleInput : String = ""
    @State var contentInput : String = ""
    @State var selectedCurrency: Int = 0
    @State var currencyArray: [String] = ["$ US Dollar", "£ GBP", "€ Euro"]
    @State var hasAR : Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                
                
                Button(action: {}) {
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
                }
                
                Form {
                    Section(header: Text("Course information")) {
                        TextField("Course title", text: $titleInput)
                        Picker(selection: self.$selectedCurrency, label: Text("Currency")) {
                            ForEach(0 ..< self.currencyArray.count) {
                                Text(self.currencyArray[$0]).tag($0)
                            }
                        }
             
                        Toggle(isOn: self.$hasAR.animation() ) {
                                  Text("With Augmented Reality")
                            }
                        
                    }
                    
                    if(hasAR){
                        Section(header: Text("Augmented Reality")) {
                            NavigationLink(destination: ProfileView()) {
                                Text("Upload 3D model")
                            }
                        }
                    }
                    
                    
                    Section(header: Text("Course content")) {
                        TextEditor(text: $titleInput)
                                .foregroundColor(.black)
                    }
                    
                    
                    
                }
                
                
                HStack {
                    Spacer()
                }
                
                Spacer()
                
                Button(action: {
                   
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
        }
    }
}

struct PostCourseView_Previews: PreviewProvider {
    static var previews: some View {
        PostCourseView()
    }
}
