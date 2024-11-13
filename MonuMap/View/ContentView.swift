//
//  ContentView.swift
//  MonuMap
//
//  Created by Sebastian Presno on 12/11/24.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(AppController.self) private var appController
    var body: some View {
        Group{
            switch appController.authState{
            case .undefined:
                ProgressView()
            case .notAuthenticated:
                AuthView()
                    .ignoresSafeArea()
            case .authenticated:
                MapView()
                    .edgesIgnoringSafeArea(.top)
            }
        }
    }
}

#Preview {
    ContentView()
}
