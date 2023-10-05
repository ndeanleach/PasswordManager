//
//  ContentView.swift
//  PasswordManager
//
//  Created by Nathan Leach on 10/4/23.
//

import SwiftUI
import Auth0

struct ContentView: View {
    
    @State var isAuthenticated: Bool = false
    @State var userProfile = User.empty
    
    var body: some View {
        if isAuthenticated {
            VStack {
                Text("Login Success")
                ForEach(0..<20) { index in
                    Image(systemName: "flame.fill")
                }
                Button("Logout") {
                    logout()
                }
            }
        } else {
            VStack {
                Button("Login") {
                    login()
                }
            }
        }
    }
}

extension ContentView {
    
    private func login() {
        Auth0
            .webAuth()
            .start { result in
                switch result {
                case.failure(let error):
                    //User pressed cancel
                    //something unusual happened
                    print("Error: \(error.localizedDescription)")
                    
                case.success(let credentials):
                    self.isAuthenticated = true
                    self.userProfile = User.from(credentials.idToken)
                    print("Credentials: \(credentials)")
                    print("ID Token: \(credentials.idToken)")
                }
            }
    }
    
    private func logout() {
        Auth0
            .webAuth()
            .clearSession{ result in
                switch result {
                case.failure(let error):
                    //User pressed cancel
                    //something unusual happened
                    print("Error: \(error.localizedDescription)")
                    
                case.success:
                    self.isAuthenticated = false
                    self.userProfile = User.empty
                }
            }
    }
}

#Preview {
    ContentView()
}
