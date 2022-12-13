//
//  CartView.swift
//  ChemistryApp
//
//  Created by Apple Esprit on 10/12/2022.
//  Copyright © 2022 NexThings. All rights reserved.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cart: CartViewModel
    @ObservedObject var socket = SocketService()
    
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
                        
                    }){
                        Text("Edit")
                    }.foregroundColor(Color.blue)
                        .padding(.trailing, 12)
                        .padding(.top, 8)
                }.navigationBarTitle("Shopping Cart")
                
                ScrollView (.vertical, showsIndicators: false) {
                    VStack (alignment: .leading) {
                            ForEach(cart.cartItems, id: \._id) { item in
                                ShoppingCartCellView(item: item).frame(width: geometry.size.width - 24, height: 80)
                            }
                    }
                }
            }
        }
    }
}

struct ShoppingCartCellView: View {
    var item : Course
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                HStack (spacing: 10) {
                    AsyncImage(url: URL(string: self.item.thumbnail)){ image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                        .frame(width: 60, height: 60)
                        .padding(.trailing, 5)
                        .padding(.leading, 5)
                    
                    VStack(alignment: .leading, spacing: 3) {
                        HStack {
                            Spacer()
                        }
                        Text("\(self.item.title)")
                            .lineLimit(nil)
                            .foregroundColor(.primary)
                        Text("\(self.item.owner)")
                            .foregroundColor(.primary)
                            .font(.system(size: 12))
                            .foregroundColor(Color.gray)
                        Text("(self.shoppingCartItem.itemColor)")
                            .foregroundColor(.primary)
                            .font(.system(size: 12))
                            .foregroundColor(Color.gray)
                            .padding(.bottom, 10)
                    }.frame(width: geometry.size.width - 150)
                     .padding(.top, 8)
                    VStack(alignment: .trailing){
                        //Spacer()
                        HStack {
                            Spacer()
                        }
                        Text("$\(self.item.price)")
                            .font(.system(size: 16))
                            .foregroundColor(Color.black)
                            .padding(.trailing, 15)
                           
                          
                    }.padding(.bottom, 10)
                }
            }
            
        }.background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
        .cornerRadius(10)
       
       
    }
}

