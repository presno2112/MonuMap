//
//  ContentView.swift
//  MonuMap
//
//  Created by Sebastian Presno on 07/11/24.
//

import SwiftUI
import MapKit
import FirebaseFirestore

struct MapView: View {
    
    @StateObject private var monumentViewModel = MonumentViewModel() // Use the existing view model
    @StateObject var viewModel = ContentViewModel()
    @StateObject var userViewModel = UserViewModel()
    @State private var isSheetPresented: Bool = true
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    
    // Estado para manejar el resultado y visibilidad de ResultView
    @State private var isResultPresented: Bool = false
    @State private var detectionResult: String? = nil
    @State private var selectedImage: UIImage? = nil
    
    // Estado para el popup de monumentos (se mantiene)
    @State private var selectedMonument: Monument? = nil
    @State private var isPopupVisible: Bool = false
    
    @State var showImagePicker: Bool = false
    //State vars to manage navigating to profile or wishlist
    @State private var navigateToProfile = false
    @State private var navigateToWishlist = false
    @State private var showbadge: Bool = false
    
    var body: some View {
        NavigationStack {
            if (!showbadge){
                ZStack {
                    VStack {
                        Map(position: $cameraPosition) {
                            UserAnnotation()
                            ForEach(monumentViewModel.citiesWithMonuments, id: \.city.id) { city in
                                ForEach(city.monuments) { monument in
                                    let coordinate = monument.coordinates.toCLLocationCoordinate2D()
                                    Annotation(monument.name, coordinate: coordinate) {
                                        Button(action: {
                                            // Show pop-up and set selected monument
                                            selectedMonument = monument
                                            isSheetPresented = false
                                            isPopupVisible = true
                                            
                                            // Update camera position to focus on the tapped marker
                                            withAnimation(.easeInOut(duration: 1.0)) {
                                                cameraPosition = .region(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))
                                            }
                                        }) {
                                            Image("pin")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 40, height: 40)
                                            //                                        .foregroundColor(.blue)
                                        }
                                    }
                                }
                            }
                        }
                        .disabled(isPopupVisible) // Disable map interaction when popup is visible
                        .edgesIgnoringSafeArea(.top)
                        .frame(maxHeight: .infinity)
                        .onAppear {
                            Task {
                                await monumentViewModel.fetchCitiesAndMonuments()
                            }
                            viewModel.checkIfLocationIsEnabled()
                            isSheetPresented = true
                        }
                    }
                    
                    // Display PlacePopupView when a monument is selected
                    if isPopupVisible, let monument = selectedMonument {
                        MonumentDetail(
                            isSheetPresented: $isSheetPresented,
                            isPresented: $isPopupVisible,
                            placeName: monument.name,
                            onGetBadge: {
                                print("Get Badge tapped for \(monument.name)")
                                isPopupVisible = false // Hide popup if needed
                            },
                            onAddToWishlist: {
                                print("Add to Wishlist tapped for \(monument.name)")
                                isPopupVisible = false // Hide popup if needed
                            }
                        )
                        .transition(.move(edge: .bottom))
                        .animation(.spring())
                        .frame(width: 180) // Adjust the width as needed
                        .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 4)
                        .transition(.scale) // Smooth transition
                    }
                    else{
                        MapButtonsView(navigateToProfile: $navigateToProfile, navigateToWishlist: $navigateToWishlist, isSheetPresented: $isSheetPresented)
                    }
                    
                    // Mostrar ResultView sobre la vista principal
                    if isResultPresented, let image = selectedImage, let result = detectionResult {
                        ResultView(
                            image: image,
                            result: result,
                            userViewModel: userViewModel,  // Aquí pasamos el viewModel
                            isPresented: $isResultPresented,
                            isSheetPresented: $isSheetPresented,
                            showImagePicker: $showImagePicker,
                            showBadge: $showbadge
                        )
                        .frame(width: 300, height: 450)
                        .cornerRadius(12)
                        .shadow(radius: 10)
                        .zIndex(2)
                    }
                }
                .navigationBarHidden(true)
                .sheet(isPresented: $isSheetPresented) {
                    SearchView(isSheetPresented: $isSheetPresented, selectedImage: $selectedImage, detectionResult: $detectionResult, isResultPresented: $isResultPresented, showImagePicker: $showImagePicker)
                        .presentationDetents([.height(40), .medium, .large])
                        .presentationBackgroundInteraction(.enabled)
                        .interactiveDismissDisabled() // makes sure the sheet cant be dismissed
                }
                .navigationDestination(
                    isPresented: $navigateToWishlist) {
                        WishlistView()
                    }
                    .navigationDestination(
                        isPresented: $navigateToProfile) {
                            UserProfileView()
                        }
            }
            else{
                NewBadgeView(showBadge: $showbadge)
                    .opacity(showbadge ? 1 : 0)
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}


extension GeoPoint {
    func toCLLocationCoordinate2D() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
}
