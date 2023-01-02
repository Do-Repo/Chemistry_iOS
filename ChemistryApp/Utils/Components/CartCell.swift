//
//  CartCell.swift
//  ChemistryApp
//
//  Created by yasine romdhane on 2/1/2023.
//  Copyright © 2023 NexThings. All rights reserved.
//

import SwiftUI

struct CartCell: View {
    var item : Course


    var body: some View {

            HStack (spacing: 10) {
                AsyncImage(url: URL(string: self.item.thumbnail)){ image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                    .frame(width: 60, height: 60)
                    .cornerRadius(10)

                
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                    }
                    Text("\(self.item.title)")
                        .lineLimit(nil)
                        .font(.title)
                        .foregroundColor(.primary)
                    Text("\(self.item.owner)")
                        .foregroundColor(.primary)
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                }
                
                Text("$\(self.item.price)")
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .padding(.trailing, 15)
            }
            .padding(5)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.blue, lineWidth: 4))
            
            
            
        }
    }


