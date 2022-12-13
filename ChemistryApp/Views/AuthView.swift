//
//  AuthView.swift
//  ChemistryApp
//
//  Created by Apple Esprit on 22/11/2022.
//  Copyright © 2022 NexThings. All rights reserved.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject var auth : AuthViewModel
    
    var body: some View {
        if auth.isAuthenticated {
          return  AnyView(TabbarView())
        } else {
          return  AnyView(ContentView())
        }
    }
}
