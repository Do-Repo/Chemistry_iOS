//
//  ContentView.swift
//  SwiftUIStarterKitApp
//
//  Created by Osama Naeem on 01/08/2019.
//  Copyright © 2019 NexThings. All rights reserved.
//

import SwiftUI
import Combine


struct OnboardingModel {
    var id: Int
    var image: String
    var titleText: String
    var descriptionText: String
    var showButton: Bool?
}

struct ContentView: View {
    @EnvironmentObject var auth : AuthViewModel
    
    var onboardingDataArray: [OnboardingModel] = [
        OnboardingModel(id: 1, image: "onboarding1", titleText: "Travel the World", descriptionText: "Explore the world and get to know different cultures and people from all around the world"),
        OnboardingModel(id: 2, image: "onboarding2", titleText: "Activities", descriptionText: "Get to know about the most famous spots for adventures and activities."),
        OnboardingModel(id: 3, image: "onboarding3", titleText: "Training and Tutorial", descriptionText: "Best training and tutorial collections for activities."),
        OnboardingModel(id: 4, image: "onboarding4", titleText: "Dream Equipments", descriptionText: "Go through some of our best collections of hiking/surfing gear and more", showButton: true)
    ]
    
    var body: some View {
    GeometryReader { geometry in
        NavigationView {
                ZStack {
                    NavigationLink(destination: LogInView(auth: auth), isActive: self.$auth.navigateNowToLogin) {EmptyView()}
                    NavigationLink(destination: SignupView(auth: auth), isActive: self.$auth.navigateNowToSignup){EmptyView()}
                    
                    SwiftyUIScrollView(axis: .horizontal, numberOfPages: self.onboardingDataArray.count, pagingEnabled: true, pageControlEnabled: false, hideScrollIndicators: true, currentPageIndicator: .black, pageIndicatorTintColor: .gray) {
                                HStack(spacing: 0) {
                                    ForEach(self.onboardingDataArray, id: \.id) { item in
                                          OnboardingView(onboardingData: item)
                                                .frame(width: geometry.size.width, height: geometry.size.height)
                                       }
                                }
                            }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
        }
    }
}

struct OnboardingView: View {
    var onboardingData: OnboardingModel
    @EnvironmentObject var auth : AuthViewModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack() {
                Image("\(self.onboardingData.image)")
                    .resizable()
                    .frame(height: 400)
                    .padding(.bottom, 20)
                
                Text("\(self.onboardingData.titleText)")
                    .frame(width: geometry.size.width, height: 20, alignment: .center)
                    .font(.title)
                
                Text("\(self.onboardingData.descriptionText)")
                    .lineLimit(nil)
                    .padding(.leading, 15)
                    .padding(.trailing, 15)
                    .font(.system(size: 16))
                    .frame(width: geometry.size.width, height: 50, alignment: .center)
                    .multilineTextAlignment(.center)
                
                Spacer()
                if self.onboardingData.showButton ?? false {
                    VStack {
                        Button(action: {
                            self.auth.navigateNowToLogin = true
                        }) {
                            HStack {
                                Text("Log In")
                            }.frame(width: geometry.size.width - 200, height: 40)
                                .foregroundColor(Color(.white))
                                .background(Color(UIColor.gray))
                                .cornerRadius(10)
                                .padding(.bottom, 5)
                        }
                        
                        Button(action: {
                            self.auth.navigateNowToSignup = true
                        }) {
                            HStack {
                                Text("Sign Up")
                            }.frame(width: geometry.size.width - 200, height: 40)
                                .foregroundColor(Color(.white))
                                .background(Color(UIColor.gray))
                                .cornerRadius(10)
                        }
                        
                    }.padding(.bottom, 30)
                }
                
                Spacer()
            }
        }
    }
}


