//
//  ChatManager.swift
//  ChemistryApp
//
//  Created by Apple Esprit on 11/12/2022.
//  Copyright © 2022 NexThings. All rights reserved.
//

import Foundation
import SocketIO

class SocketService :  ObservableObject {
    
    private var webSocketTask : URLSessionWebSocketTask?
    
    init( ){
        let url = URL(string: Constants.SOCKET_URL + UserDefaults.standard.string(forKey: "token")!)!
        webSocketTask = URLSession.shared.webSocketTask(with: url)
        webSocketTask?.receive(completionHandler: onReceive)
        webSocketTask?.resume()
    }
    
    func disconnect( ){
        webSocketTask?.cancel(with: .normalClosure, reason: nil)
    }
    
    private func onReceive(incoming: Result<URLSessionWebSocketTask.Message, Error>){
        webSocketTask?.receive(completionHandler: onReceive)
        if case .success(let success) = incoming {
            print(success)
        }
        else if case .failure(let failure) = incoming {
            print(failure)
        }
    }
    
    deinit {
        disconnect()
    }
    
    
}
