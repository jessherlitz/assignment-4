//
//  LoginView.swift
//  Project4
//
//  Created by Jessica Sampaio-Herlitz on 4/7/25.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var navigate = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                
                Button("Login") {
                    Auth.auth().signIn(withEmail: email, password: password) { result, error in
                        if let error = error {
                            errorMessage = error.localizedDescription
                        } else {
                            navigate = true
                        }
                        
                    }
                }
                .padding()
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(8)

                    
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                    
            }
            .padding()
            .navigationDestination(isPresented: $navigate) {
                JournalListView()
                
            }
        }
    }
}
