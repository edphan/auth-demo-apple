//
//  auth_demo_appleApp.swift
//  auth_demo_apple
//
//  Created by Edward Phan on 2021-12-07.
//

import SwiftUI
import Firebase

@main
struct auth_demo_appleApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(AuthManager())
        }
    }
}
