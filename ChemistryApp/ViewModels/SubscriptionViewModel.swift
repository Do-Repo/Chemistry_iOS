//
//  PaymentViewModel.swift
//  ChemistryApp
//
//  Created by yasine romdhane on 2/1/2023.
//  Copyright © 2023 NexThings. All rights reserved.
//

import SwiftUI
import Foundation
import Stripe
import StripePaymentSheet

class SubscriptionViewModel: ObservableObject, SubscriptionResponseProtocol {
    
    @Published var paymentSheet: PaymentSheet?
    @Published var paymentResult: PaymentSheetResult?
    @Published var errorMessage: String? = nil
    @Published var isApiFailed: Bool = false
    @Published var isSuccessPayment: Bool = false
    
    init( ){
        StripeAPI.defaultPublishableKey = "pk_test_51MLuG3B0OwNlFJVhKbInWXk8wfL0qFgUIozbTj2p2rzYw7UmfeOc9FiJH5vRYgIyTzhbCvUbduEoLtDwwvGcqOmC00Hqtwq3Hs"
    }
    
    func tokenization(body: SubscriptionBody) {
        SubscriptionService.getSubscriptionToken(callback: self, body: body)
    }
    
    func onResult(subscriptionResult: SubscriptionResponse) {
        print("success now showing button")
        //success result from api
        var configuration = PaymentSheet.Configuration()
        configuration.merchantDisplayName = "iOS Sample, Inc."
        configuration.customer = .init(id: subscriptionResult.customer, ephemeralKeySecret: subscriptionResult.ephemeralKey)
        configuration.primaryButtonColor = UIColor.init(.blue)
        DispatchQueue.main.async {
            self.paymentSheet = PaymentSheet(paymentIntentClientSecret: subscriptionResult.paymentIntent, configuration: configuration)
        }
    }
    
    
    func onError(message: String) {
        //some error during calling the api for tokenization
        self.errorMessage = message
    }
    
    func onPaymentCompletion(result: PaymentSheetResult?) {
          if let paymentFinal = result {
              switch paymentFinal {
              case .completed:
                  isSuccessPayment = true
              case .failed(let error):
                self.errorMessage = error.localizedDescription
                  self.isApiFailed = true
              case .canceled:
                  self.isApiFailed = false
              }
          }
      }
    
}
