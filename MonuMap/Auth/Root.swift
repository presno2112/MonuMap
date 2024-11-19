//
//  Root.swift
//  MonuMap
//
//  Created by Hector Daniel Valdes Salas on 14/11/24.
//

import SwiftUI

struct Root: View {
    
    @State private var showSignIn: Bool = false
    //@StateObject private var authViewModel = AuthViewModel()
    
    var body: some View {
        if(!showSignIn){
            MapView()
                .edgesIgnoringSafeArea(.top)
                .onAppear(){
                    let authUser = try? AuthenticationManager.shared.getAuthenticadedUser()
                    self.showSignIn = authUser == nil
                }
        }
        else{
            LogInView(showSignIn: $showSignIn)
//            LogInView()
        }
    }
}

#Preview {
    Root()
}
