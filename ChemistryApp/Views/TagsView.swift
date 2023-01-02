//
//  TagsView.swift
//  ChemistryApp
//
//  Created by yasine romdhane on 31/12/2022.
//  Copyright © 2022 NexThings. All rights reserved.
//

import SwiftUI
import WrappingHStack

struct TagsView: View {
    @EnvironmentObject var tags : TagsViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var chosenTags : [String]?
    var comingFrom : String
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                
                ScrollView(.vertical) {
                    WrappingHStack (self.tags.tags!, id: \.self) { item in
                        Button(action: {
                            if(comingFrom == "select"){
                                if(chosenTags != nil && chosenTags!.contains(item._id)){
                                    chosenTags!.remove(at: chosenTags!.firstIndex(of: item._id)!)
                                }else{
                                    chosenTags?.append(item._id)
                                }
                            }
                        }) {
                            if(chosenTags != nil && chosenTags!.contains(item._id)){
                                TagItem(tag: item)
                                    .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(.blue, lineWidth: 4)
                                        )
                            }else{
                                TagItem(tag: item)
                            }
                        }.padding(5)
                    }
                }
                
                if(comingFrom == "select" && chosenTags != nil && !chosenTags!.isEmpty){
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                           HStack {
                               Text("Add Tags")
                           }
                               .padding()
                               .frame(width: geometry.size.width - 40, height: 40)
                               .foregroundColor(Color.white)
                               .background(Color.blue)
                               .cornerRadius(5)
                       }
                        .padding(.bottom, 40)
                }
                
                    
            }.navigationBarTitle("All Tags")
            .navigationBarBackButtonHidden(comingFrom == "select")
        }
    }
}


