//
//  LoginView.swift
//  MonuMap
//
//  Created by Sebastian Presno on 12/11/24.
//

//import SwiftUI
//
//struct LoginView: View {
//    @Binding var isSignUp: Bool
//    @Environment(AppController.self) private var appController
//    @State private var email = ""
//    @State private var password = ""
//    @State private var errorMessage = ""
//    
//    var body: some View {
//        VStack(spacing: 0) {
//            Spacer()
//            LogoNName()
//            Spacer()
//            
//            LabeledContent {
//                TextField("", text: Bindable(appController).email)
//                    .padding(10)
//                    .frame(width: 300, height: 40)
//                    .font(.caption)
//                    .background(Color.blue) // Full blue background
//                    .foregroundColor(.white) // White text color
//                    .cornerRadius(20) // Rounded corners for style
//                    .keyboardType(.emailAddress)
//                    .autocapitalization(.none)
//                    .textFieldStyle(PlainTextFieldStyle())
//            } label: {
//                Text("Email")
//                    .foregroundStyle(.gray)
//            }
//            .padding()
//            .labeledContentStyle(TopLabeledStyleConfig())
//            
//            
//            LabeledContent{
//                SecureField("", text: Bindable(appController).password)
//                    .padding(10)
//                    .frame(width: 300, height: 40)
//                    .font(.caption)
//                    .background(Color.blue) // Full blue background
//                    .foregroundStyle(.white) // White text color
//                    .cornerRadius(20) // Rounded corners for style
//            } label: {
//                Text("Password")
//                    .foregroundStyle(.gray)
//            }
//            .labeledContentStyle(TopLabeledStyleConfig())
//            .padding()
//            
//            
//            Button("Forgot your password?") {
//                // Add forgot password action here
//            }
//            .font(.footnote)
//            .underline()
//            .foregroundColor(.gray)
//            
//            Spacer()
//            Button{
//                signIn()
//            }label: {
//                Text("Login")
//                    .font(.headline)
//                    .frame(width: 160)
//                    .padding(10)
//                    .foregroundColor(.white)
//            }
//            .buttonStyle(.borderedProminent)
//            .tint(.blue)
//            .buttonBorderShape(.roundedRectangle(radius: 20))
//            Spacer()
//            
//            HStack{
//                Text("You don't have an account?")
//                    .font(.footnote)
//                Button(action: {
//                    isSignUp.toggle()
//                }) {
//                    Text("Sign up")
//                        .font(.footnote)
//                        .foregroundColor(.blue)
//                }
//            }
//            
//            Spacer()
//            
//            if !errorMessage.isEmpty {
//                Text(errorMessage)
//                    .foregroundColor(.red)
//                    .multilineTextAlignment(.center)
//            }
//        }
//        .padding()
//    }
//
//    private func signIn() {
//        Task{
//            do{
//                try await appController.signIn()
//            } catch{
//                print(error.localizedDescription)
//            }
//        }
//    }
//}
//
//
//#Preview {
//    LoginView(isSignUp: .constant(false))
//}
//
//
//struct TopLabeledStyleConfig: LabeledContentStyle {
//    
//    func makeBody(configuration: Configuration) -> some View {
//        VStack(alignment: .leading) {
//            configuration.label
//                .font(.caption)
//            configuration.content
//        }
//    }
//}
