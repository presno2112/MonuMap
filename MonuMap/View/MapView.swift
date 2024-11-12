//
//  ContentView.swift
//  MonuMap
//
//  Created by Sebastian Presno on 07/11/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @StateObject var viewModel = ContentViewModel()
    @State private var isSheetPresented: Bool = true
    
    var body: some View {
        VStack {
            Map(coordinateRegion: viewModel.binding, showsUserLocation: true, userTrackingMode: .constant(.follow))
                .edgesIgnoringSafeArea(.top)
                .frame(maxHeight: .infinity)
                .onAppear {
                    viewModel.checkIfLocationIsEnabled()
                }
        }
        .sheet(isPresented: $isSheetPresented) {
            SearchView(isSheetPresented: $isSheetPresented)
                .presentationDetents([.height(40), .medium, .large])
                .presentationBackgroundInteraction(.enabled)
                .interactiveDismissDisabled() // makes sure the sheet cant be dismissed
            
        }
//        .environment(\.colorScheme, .dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
