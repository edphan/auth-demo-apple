//
//  LoginView.swift
//  auth_demo_apple
//
//  Created by Edward Phan on 2021-12-07.
//

import SwiftUI
import AuthenticationServices
import FirebaseAuth

struct LoginView: View {
    
    @EnvironmentObject var model: AuthManager
    
    var body: some View {
        
        if model.state == .signedIn {
            DashboardView()
        } else {
            AppleSignInButton()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthManager())
    }
}
