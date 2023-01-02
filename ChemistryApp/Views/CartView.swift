//
//  CartView.swift
//  ChemistryApp
//
//  Created by Apple Esprit on 10/12/2022.
//  Copyright © 2022 NexThings. All rights reserved.
//

import SwiftUI
import StripePaymentSheet

struct CartView: View {
    @EnvironmentObject var cart: CartViewModel
    @EnvironmentObject var auth: AuthViewModel
    @ObservedObject var socket = SocketService()
    @EnvironmentObject var viewModel : SubscriptionViewModel
    
    @State var editing : Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Divider( )
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                
                HStack {
                    Text("\(cart.cartItems.count) Items")
                        .font(.system(size: 24, weight: .bold, design: .default))
                        .padding(.leading, 12)
                        .padding(.top, 8)
                    Spacer( )
                    Button(action: {
                        withAnimation{
                            editing.toggle()
                        }
                    }){
                        Text(editing ? "Done" : "Edit")
                    }.foregroundColor(Color.blue)
                        .padding(.trailing, 12)
                        .padding(.top, 8)
                }.navigationBarTitle("Shopping Cart")
                
                ScrollView (.vertical, showsIndicators: false) {
                    VStack (alignment: .leading) {
                        ForEach(cart.cartItems, id: \._id) { item in
                            ZStack (alignment: .topTrailing) {
                                
                                CartCell(item: item ).frame(width: geometry.size.width - 24, height: 80)
                                    .padding([.leading, .trailing])
                                    .padding([.top, .bottom], editing ? 20 : 0 )
                                
                                if(editing){
                                    Button(action: {
                                        cart.cartItems.remove(at: (cart.cartItems.firstIndex(where: { course in
                                            course._id == item._id
                                        })!))

                                    }){
                                        Image("trash-bin")
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                            .padding(5)
                                    }
                                }
                            }
                        }
                    }
                }
                if(viewModel.paymentSheet != nil){
                    if(!cart.cartItems.isEmpty){
                        Button(action: {
                     
                        }) {
                               HStack {
                                   Text("Proceed checkout")
                               }
                                   .padding()
                                   .frame(width: geometry.size.width - 40, height: 40)
                                   .foregroundColor(Color.white)
                                   .background(Color.blue)
                                   .cornerRadius(5)
                           }
                            .padding(.bottom, 40)
                    }
                }
                        
                    }
        }.onAppear{
                viewModel.tokenization(body: SubscriptionBody(price: 100))
            
        }
    }
}


