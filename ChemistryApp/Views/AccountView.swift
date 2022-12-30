//
//  AccountView.swift
//  SwiftUIStarterKitApp
//
//  Created by Osama Naeem on 08/08/2019.
//  Copyright © 2019 NexThings. All rights reserved.
//

import SwiftUI

struct AccountView: View {
    @State var notificationToggle: Bool = false
    @State var locationUsage: Bool = false
    @State var username: String = "James"
    @State var selectedCurrency: Int = 0
    @State var currencyArray: [String] = ["$ US Dollar", "£ GBP", "€ Euro"]
    
    @State var selectedPaymentMethod: Int = 1
    @State var paymentMethodArray: [String] = ["Paypal", "Credit/Debit Card", "Bitcoin"]
    @EnvironmentObject var auth : AuthViewModel

    
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
                
                Text(self.auth.currentUser!.name)
                    
                Form {
                    
                    Section(header: Text("Payment Settings")) {
                        Picker(selection: self.$selectedCurrency, label: Text("Currency")) {
                                         ForEach(0 ..< self.currencyArray.count) {
                                                  Text(self.currencyArray[$0]).tag($0)
                                            }
                        }
                        
                        Picker(selection: self.$selectedPaymentMethod, label: Text("Payment Method")) {
                                  ForEach(0 ..< self.paymentMethodArray.count) {
                                       Text(self.paymentMethodArray[$0]).tag($0)
                                     }
                        }
                        Button(action: {
                            print("Button tapped")
                            
                        }) {
                            
                            if (self.paymentMethodArray[self.selectedPaymentMethod]) == "Credit/Debit Card" {
                                Text("Add a Credit/Debit Card to your account")
                                
                            } else {
                                Text("Connect \(self.paymentMethodArray[self.selectedPaymentMethod]) to your account")
                            }
                        }

                    }
                    if(auth.currentUser?.role == "Teacher") {
                        Section(header: Text("Teachers hub")) {
                            NavigationLink(destination: PostCourseView()) {
                                Text("Post a Course")
                            }
                        }
                    }
                    
                    
                    Section(header: Text("Personal Information")) {
                       NavigationLink(destination: ProfileView()) {
                            Text("Profile Information")
                        }
                       
                        NavigationLink(destination: Text("Billing Info")) {
                            Text("Billing Information")
                        }
                    }
                    
                    Section(footer: Text("Allow push notifications to get latest travel and equipment deals")) {
                        Toggle(isOn: self.$locationUsage) {
                              Text("Location Usage")
                        }
                        Toggle(isOn: self.$notificationToggle) {
                            Text("Notifications")
                        }
                    }
                        
            }.background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
            .navigationBarTitle("Settings")
         }
        }
    }
 }

