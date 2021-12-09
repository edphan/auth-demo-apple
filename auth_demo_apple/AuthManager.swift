//
//  AuthManager.swift
//  auth_demo_apple
//
//  Created by Edward Phan on 2021-12-07.
//

import Foundation

class AuthManager: NSObject, ObservableObject {
    
    enum SignInState {
        case signedIn
        case signedOut
    }
    
    @Published var state: SignInState = .signedOut
    
    func successAppleSignIn() {
        self.state = .signedIn
    }
}
