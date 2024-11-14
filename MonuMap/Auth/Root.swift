//
//  Root.swift
//  MonuMap
//
//  Created by Hector Daniel Valdes Salas on 14/11/24.
//

import SwiftUI

struct Root: View {
    
    @State private var showSignIn: Bool = false
    
    var body: some View {
        MapView()
            .edgesIgnoringSafeArea(.top)
            .onAppear(){
                let authUser = try? AuthenticationManager.shared.getAuthenticadedUser()
                self.showSignIn = authUser == nil
            }
            .fullScreenCover(isPresented: $showSignIn){
                    LogInView(showSignIn: $showSignIn)
        }
    }
}

#Preview {
    Root()
}
