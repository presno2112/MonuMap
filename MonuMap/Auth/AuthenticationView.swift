//
//  AuthenticationView.swift
//  MonuMap
//
//  Created by Hector Daniel Valdes Salas on 13/11/24.
//

import SwiftUI

struct AuthenticationView: View {
    
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack{
            NavigationLink{
                LogInView()
            } label: {
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
        .navigationTitle("Sign In")
    }
}

#Preview {
    NavigationStack{
        AuthenticationView(showSignInView: .constant(false))
    }
}
