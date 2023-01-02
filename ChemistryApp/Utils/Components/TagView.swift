//
//  TagView.swift
//  ChemistryApp
//
//  Created by yasine romdhane on 31/12/2022.
//  Copyright © 2022 NexThings. All rights reserved.
//

import SwiftUI


struct TagItem: View {
    var tag: Tags
    
    var body: some View {
            HStack{
                Rectangle().fill(Color(tag.colorCode))
                    .clipShape(Circle())
                    .frame(width: 10, height: 10)
                
                Text(tag.name)
                    .font(.system(size: 14, weight: .bold, design: Font.Design.default))
                    .foregroundColor(Color.black)
            }
            .padding([.top, .bottom], 15)
            .padding([.leading, .trailing], 20)
            .overlay(RoundedRectangle(cornerRadius: 16)
                    .fill(Color(tag.colorCode).opacity(0.1)))
    }
}

