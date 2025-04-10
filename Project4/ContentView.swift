//
//  ContentView.swift
//  Project4
//
//  Created by Jessica Sampaio-Herlitz on 4/7/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Personal Journal")
                    .font(.largeTitle)
                    .bold()

                NavigationLink("Register") {
                    RegistrationView()
                }
                .padding()
                .frame(maxWidth: 250)
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(8)

                NavigationLink("Login") {
                    LoginView()
                }
                .padding()
                .frame(maxWidth: 250)
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ContentView()
}
