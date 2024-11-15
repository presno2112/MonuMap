//
//  LogInView.swift
//  MonuMap
//
//  Created by Hector Daniel Valdes Salas on 14/11/24.
//

import SwiftUI

struct LogInView: View {
    
    @StateObject var signInViewModel = SignInViewModel()
    @Binding var showSignIn: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            LogoNName()
            Spacer()
            
            LabeledContent {
                TextField("Email", text: $signInViewModel.email)
                    .padding(10)
                    .frame(width: 300, height: 40)
                    .font(.caption)
                    .background(Color.blue) // Full blue background
                    .foregroundColor(.white) // White text color
                    .cornerRadius(20) // Rounded corners for style
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .textFieldStyle(PlainTextFieldStyle())
            } label: {
                Text("Email")
                    .foregroundStyle(.gray)
            }
            .padding()
            .labeledContentStyle(TopLabeledStyleConfig())
            
            
            LabeledContent{
                SecureField("Password", text: $signInViewModel.password)
                    .padding(10)
                    .frame(width: 300, height: 40)
                    .font(.caption)
                    .background(Color.blue) // Full blue background
                    .foregroundStyle(.white) // White text color
                    .cornerRadius(20) // Rounded corners for style
            } label: {
                Text("Password")
                    .foregroundStyle(.gray)
            }
            .labeledContentStyle(TopLabeledStyleConfig())
            .padding()
            
            
            Button("Forgot your password?") {
                // Add forgot password action here
            }
            .font(.footnote)
            .underline()
            .foregroundColor(.gray)
            
            Spacer()
            Button{
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
                Text("Login")
                    .font(.headline)
                    .frame(width: 160)
                    .padding(10)
                    .foregroundColor(.white)
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)
            .buttonBorderShape(.roundedRectangle(radius: 20))
            Spacer()
            
            HStack{
                Text("You don't have an account?")
                    .font(.footnote)
                Button(action: {
                }) {
                    Text("Sign up")
                        .font(.footnote)
                        .foregroundColor(.blue)
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

struct TopLabeledStyleConfig: LabeledContentStyle {

    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.label
                .font(.caption)
            configuration.content
        }
    }
}

#Preview {
    LogInView(showSignIn: .constant(true))
}
