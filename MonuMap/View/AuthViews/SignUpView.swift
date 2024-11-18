//
//  LoginView.swift
//  MonuMap
//
//  Created by Sebastian Presno on 12/11/24.
//

//import SwiftUI
//
//struct SignUpView: View {
//    @Binding var isSignUp: Bool
//    @State private var email = ""
//    @State private var password = ""
//    @State private var confirmPassword = ""
//    @State private var errorMessage = ""
//    @State private var name = ""
//    @Environment(AppController.self) private var appController
//    
//    var body: some View {
//        NavigationStack{
//            VStack {
//                Spacer()
//                LogoNName()
//                Spacer()
//                
//                // Name Field
//                LabeledContent {
//                    TextField("", text: $name)
//                        .padding(10)
//                        .frame(width: 300, height: 35)
//                        .font(.caption)
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(20)
//                        .keyboardType(.emailAddress)
//                        .autocapitalization(.none)
//                        .textFieldStyle(PlainTextFieldStyle())
//                } label: {
//                    Text("Name")
//                        .foregroundStyle(.gray)
//                }
//                .labeledContentStyle(TopLabeledStyleConfig())
//                .padding(15)
//                
//                // Email Field
//                LabeledContent {
//                    TextField("", text:Bindable(appController).email)
//                        .padding(10)
//                        .frame(width: 300, height: 35)
//                        .font(.caption)
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(20)
//                        .keyboardType(.emailAddress)
//                        .autocapitalization(.none)
//                        .textFieldStyle(PlainTextFieldStyle())
//                } label: {
//                    Text("Email")
//                        .foregroundStyle(.gray)
//                }
//                .labeledContentStyle(TopLabeledStyleConfig())
//                .padding(15)
//                
//                // Password Field
//                LabeledContent {
//                    SecureField("", text: Bindable(appController).password)
//                        .padding(10)
//                        .frame(width: 300, height: 35)
//                        .font(.caption)
//                        .background(Color.blue)
//                        .foregroundStyle(.white)
//                        .cornerRadius(20)
//                } label: {
//                    Text("Password")
//                        .foregroundStyle(.gray)
//                }
//                .labeledContentStyle(TopLabeledStyleConfig())
//                .padding(15)
//                
//                // Confirm Password Field
//                LabeledContent {
//                    SecureField("", text: $confirmPassword)
//                        .padding(10)
//                        .frame(width: 300, height: 35)
//                        .font(.caption)
//                        .background(Color.blue)
//                        .foregroundStyle(.white)
//                        .cornerRadius(20)
//                } label: {
//                    Text("Confirm password")
//                        .foregroundStyle(.gray)
//                }
//                .labeledContentStyle(TopLabeledStyleConfig())
//                .padding(15)
//                
//                // Add extra spacing above the button
//                Spacer(minLength: 50)
//                
//                Button {
//                    signUp()
//                } label: {
//                    Text("Sign Up")
//                        .font(.headline)
//                        .frame(width: 160)
//                        .padding(10)
//                        .foregroundColor(.white)
//                }
//                .buttonStyle(.borderedProminent)
//                .tint(.blue)
//                .buttonBorderShape(.roundedRectangle(radius: 20))
//                
//                Spacer()
//                
//                // Switch to Login option
//                //            HStack {
//                //                Text("Already have an account?")
//                //                    .font(.footnote)
//                //                Button(action: {
//                //                    isSignUp.toggle()
//                //                }) {
//                //                    Text("Login")
//                //                        .font(.footnote)
//                //                        .foregroundColor(.blue)
//                //                }
//                //            }
//                //            .padding(.top)
//                
//                if !errorMessage.isEmpty {
//                    Text(errorMessage)
//                        .foregroundColor(.red)
//                        .multilineTextAlignment(.center)
//                }
//            }
//            .padding()
//            .toolbar{
//                ToolbarItem{
//                    Button{
//                        isSignUp.toggle()
//                    }label:{
//                        Text("Login")
//                    }
//                }
//            }
//        }
//    }
//    private func signUp() {
//        Task{
//            do{
//                try await appController.signUp()
//            } catch{
//                print(error.localizedDescription)
//            }
//        }
//    }
//}

//#Preview {
//    SignUpView(isSignUp: .constant(true))
//}
