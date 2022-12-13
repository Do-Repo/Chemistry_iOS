//
//  CartViewModel.swift
//  ChemistryApp
//
//  Created by Apple Esprit on 10/12/2022.
//  Copyright © 2022 NexThings. All rights reserved.
//

import Foundation


class CartViewModel : ObservableObject {
    
    @Published var cartItems : [Course] = []
    
    func addToCart(course: Course ) {
        DispatchQueue.main.async {
            print("added to cart")
            self.cartItems.append(course)
        }
    }
    
    func removeFromCart(course: Course) {
        DispatchQueue.main.async {
            self.cartItems.remove(at: self.cartItems.firstIndex(where: { $0._id == course._id})!)
        }
    }
}
