//
//  DashboardView.swift
//  auth_demo_apple
//
//  Created by Edward Phan on 2021-12-07.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct DashboardView: View {
    
    @EnvironmentObject var model: AuthManager
    
    var body: some View {
        VStack {
            Text("You are logged in")
            
            Button {
                saveName()
            } label: {
                Text("Save name")
            }

            
            Button {
                model.state = .signedOut
            } label: {
                Text("Sign Out")
            }

        }
    }
    
    func saveName() {
        let db = Firestore.firestore()
        let userUID = Auth.auth().currentUser?.uid
        let path = db.collection("users").document(userUID!)
        path.setData(["email": model.email ?? "no email"]) { error in
            if error == nil {
                //
            } else {
                print(error!.localizedDescription)
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
