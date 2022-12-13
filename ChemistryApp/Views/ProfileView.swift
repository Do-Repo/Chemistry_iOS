//
//  ProfileView.swift
//  ChemistryApp
//
//  Created by Apple Esprit on 28/11/2022.
//  Copyright © 2022 NexThings. All rights reserved.
//

import SwiftUI


struct ProfileView: View {
    
    @EnvironmentObject var auth : AuthViewModel
    
    @State var nameField :String = ""
    @State var emailField:String = ""
    @State var phoneField:String = ""
    @State private var inputImage: UIImage?
    @State private var showingImagePicker : Bool = false
    @State private var imageURL: URL?
    
    
    
    var body: some View {
        GeometryReader { g in
            VStack {
            
                AsyncImage(url: URL(string:self.auth.currentUser!.avatarUrl)){ image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                        .frame(width: 100, height: 100)
                        .background(Color.gray)
                        .clipShape(Circle())
                        .padding(.bottom, 10)
                        .font(.system(size: 20))
                        .onTapGesture {
                            showingImagePicker = true
                        }
                
                
                Text(self.auth.currentUser!.name)
                
                Form {
                    
                    Section(header: Text("PERSONAL INFORMATION")) {
                     
                        VStack(alignment: .leading) {
                            Text("Name:").font(.subheadline)
                            TextField(self.auth.currentUser!.name, text: $nameField)
                                .onSubmit {
                                    self.auth.updateUser(user: UserUpdateRequestBody(name: nameField))
                                }
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Email Address:").font(.subheadline)
                            TextField(self.auth.currentUser!.email, text: $emailField)
                                .onSubmit {
                                    self.auth.updateUser(user: UserUpdateRequestBody(email: emailField))
                                }                        }
                        
                        VStack(alignment: .leading) {
                            Text("Phone Number:").font(.subheadline)
                            TextField(self.auth.currentUser!.phone, text: $phoneField)
                                .onSubmit {
                                    self.auth.updateUser(user: UserUpdateRequestBody(phone: phoneField))
                                }                        }
                        
                       
                    }
                    
                }.background(Color(red: 242 / 255, green: 242 / 255, blue:  242 / 255))
                    .navigationTitle("Profile")
                    .onChange(of: inputImage) {
                        _ in loadImage()
                    }
                    .sheet(isPresented: $showingImagePicker) {
                        ImagePicker(image: $inputImage)
                    }
            }
        }
    }
    
    
    func loadImage( ) {
        guard let iImage = inputImage else { return }
        auth.updateImage(image: iImage)
    }
}

