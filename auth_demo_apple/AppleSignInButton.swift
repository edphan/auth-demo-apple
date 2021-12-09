//
//  AppleSignInButton.swift
//  auth_demo_apple
//
//  Created by Edward Phan on 2021-12-08.
//

import SwiftUI
import AuthenticationServices
import FirebaseAuth
import CryptoKit

struct AppleSignInButton: View {
    
    @EnvironmentObject var model: AuthManager
    @State var currentNonce: String?
    
    
    var body: some View {
        
        SignInWithAppleButton(.continue) { request in
            let nonce = HelperAuthFunctions().randomNonceString()
            currentNonce = nonce
            request.requestedScopes = [.email, .fullName]
            request.nonce = HelperAuthFunctions().sha256(nonce)
        }
    onCompletion: { result in
        switch result {
        case .success(let authResults):
            switch authResults.credential {
            case let appleIDCredential as ASAuthorizationAppleIDCredential:
                
                guard let nonce = currentNonce else {
                    fatalError("Invalid state: A login callback was received, but no login request was sent.")
                }
                guard let appleIDToken = appleIDCredential.identityToken else {
                    fatalError("Invalid state: A login callback was received, but no login request was sent.")
                }
                guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                    print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                    return
                }
                
                let credential = OAuthProvider.credential(withProviderID: "apple.com",idToken: idTokenString, rawNonce: nonce)
                Auth.auth().signIn(with: credential) { (authResult, error) in
                    if (error != nil) {
                        // Error. If error.code == .MissingOrInvalidNonce, make sure
                        // you're sending the SHA256-hashed nonce as a hex string with
                        // your request to Apple.
                        print(error?.localizedDescription as Any)
                        return
                    }
                    model.email = appleIDCredential.email
                    model.state = .signedIn
                }
            default:
                break
                
            }
        default:
            break
        }
    }
    .signInWithAppleButtonStyle(.whiteOutline)
    .frame(height: 50)
    .padding()
    .cornerRadius(5)
    }
}

struct AppleSignInButton_Previews: PreviewProvider {
    static var previews: some View {
        AppleSignInButton()
            .environmentObject(AuthManager())
    }
}
