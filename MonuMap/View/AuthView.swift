//
//  SignUpView.swift
//  MonuMap
//
//  Created by Sebastian Presno on 12/11/24.
//

import SwiftUI

struct AuthView: View {
    @State private var username = ""
    @State private var name = ""
    @State private var surname = ""
    @State private var errorMessage = ""
    @State private var isRegistered = false
    
    @State private var isSignUp = false

    @Environment(AppController.self) private var appController
    private let firestoreManager = FirestoreManager()
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Email", text: Bindable(appController).email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            
            SecureField("Email", text: Bindable(appController).password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("First Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Surname", text: $surname)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: signUp) {
                Text(isSignUp ? "Sign up" : "Sign in" )
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Button("\(isSignUp ? "I already have an account" : "Let's sign in")"){
                isSignUp.toggle()
            }
            
            if isRegistered {
                Text("Registration successful! 🎉")
                    .foregroundColor(.green)
            }
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
    }
    
    private func authenticate() {
        isSignUp ? signUp() : signIn()
    }
    
    private func signIn() {
        
    }
    private func signUp() {
        print("hello")
//        firestoreManager.registerUser(email: email, password: password, username: username, name: name, surname: surname) { result in
//            switch result {
//            case .success:
//                print("usuario creado")
//                self.isRegistered = true
//                self.errorMessage = ""
//            case .failure(let error):
//                print("usuario no creado")
//                self.errorMessage = error.localizedDescription
//                self.isRegistered = false
//            }
//        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
