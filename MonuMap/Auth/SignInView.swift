//
//  SignInView.swift
//  MonuMap
//
//  Created by Hector Daniel Valdes Salas on 13/11/24.
//

import SwiftUI

@MainActor
final class SignInViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    func SignUp() async throws {
        guard !email.isEmpty, !password.isEmpty else{
            print("No email or password found")
            return
        }
        let authDataResult = try await AuthenticationManager.shared.createUser(email: email, password: password)
        let user = DBUser(auth: authDataResult)
        try await UserManager.shared.createNewUser(user: user)
    }
    
    func SignIn() async throws {
        guard !email.isEmpty, !password.isEmpty else{
            print("No email or password found")
            return
        }
        try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
}

struct SignInView: View {
    
    @StateObject var signInViewModel = SignInViewModel()
    @Binding var showSignIn: Bool
    
    var body: some View {
        VStack{
            TextField("Email", text: $signInViewModel.email)
                .padding()
                .background(.gray.opacity(0.2))
                .cornerRadius(10)
            SecureField("Password", text: $signInViewModel.password)
                .padding()
                .background(.gray.opacity(0.2))
                .cornerRadius(10)
            Button{
                //signInViewModel.SignIn()
                Task{
                    do{
                        try await signInViewModel.SignUp()
                        showSignIn = false
                        return
                    }catch {
                        print(error)
                    }
                    do{
                        try await signInViewModel.SignUp()
                        showSignIn = false
                        return
                    }catch {
                        print(error)
                    }
                }
            }label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(.blue)
                    .cornerRadius(10)
            }
            
        }
        .padding()
        .navigationTitle("Sign In with Email")
    }
}

#Preview {
    NavigationStack{
        SignInView(showSignIn: .constant(false))
    }
}
