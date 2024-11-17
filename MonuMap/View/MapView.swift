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

    let monuments = [
        Monument(
            name: "Roman Colosseum",
            creator: nil,
            //date: Date(),
            description: "Ancient amphitheater in Rome.",
            picture: "https://example.com/colosseum.jpg",
            location: "Rome",
            coordinates: GeoPoint(latitude: 41.8902, longitude: 12.4922)
        ),
        Monument(
            name: "Fontana di Trevi",
            creator: nil,
            //date: Date(),
            description: "Famous Baroque fountain in Rome.",
            picture: "https://example.com/trevi.jpg",
            location: "Rome",
            coordinates: GeoPoint(latitude: 41.9009, longitude: 12.4833)
        ),
        Monument(
            name: "Castel Sant'Angelo",
            creator: nil,
            //date: Date(),
            description: "Historic castle and museum.",
            picture: "https://example.com/santangelo.jpg",
            location: "Rome",
            coordinates: GeoPoint(latitude: 41.9031, longitude: 12.4663)
        ),
        Monument(
            name: "Basilica di San Pietro",
            creator: "Michelangelo",
            //date: Date(),
            description: "St. Peter's Basilica in Vatican City.",
            picture: "https://example.com/stpeter.jpg",
            location: "Rome",
            coordinates: GeoPoint(latitude: 41.9029, longitude: 12.4534)
        ),
        Monument(
            name: "Piazza di Spagna",
            creator: nil,
            //date: Date(),
            description: "Famous Spanish Steps in Rome.",
            picture: "https://example.com/spanishsteps.jpg",
            location: "Rome",
            coordinates: GeoPoint(latitude: 41.9059, longitude: 12.4823)
        ),
        Monument(
            name: "Bocca della Verità",
            creator: nil,
            //date: Date(),
            description: "Ancient stone mask.",
            picture: "https://example.com/bocca.jpg",
            location: "Rome",
            coordinates: GeoPoint(latitude: 41.8886, longitude: 12.4812)
        ),
        Monument(
            name: "Monumento a Vittorio Emanuele II",
            creator: nil,
            //date: Date(),
            description: "Monument in honor of Victor Emmanuel II.",
            picture: "https://example.com/vittorio.jpg",
            location: "Rome",
            coordinates: GeoPoint(latitude: 41.8955, longitude: 12.4823)
        ),
        Monument(
            name: "Maradona Mural",
            creator: nil,
            //date: Date(),
            description: "Mural dedicated to Diego Maradona.",
            picture: "https://example.com/maradona.jpg",
            location: "Naples",
            coordinates: GeoPoint(latitude: 40.8543, longitude: 14.2584)
        ),
        Monument(
            name: "Cathedral of San Gennaro",
            creator: nil,
            //date: Date(),
            description: "Naples Cathedral.",
            picture: "https://example.com/cathedral.jpg",
            location: "Naples",
            coordinates: GeoPoint(latitude: 40.8522, longitude: 14.2588)
        ),
        Monument(
            name: "Castel Nuovo",
            creator: nil,
            //date: Date(),
            description: "Medieval castle in Naples.",
            picture: "https://example.com/nuovo.jpg",
            location: "Naples",
            coordinates: GeoPoint(latitude: 40.8383, longitude: 14.2544)
        ),
        Monument(
            name: "Pulcinella Statue",
            creator: nil,
    //            date: Date(),
            description: "Statue of Pulcinella.",
            picture: "https://example.com/pulcinella.jpg",
            location: "Naples",
            coordinates: GeoPoint(latitude: 40.8492, longitude: 14.2530)
        ),
        Monument(
            name: "Pizzeria Da Michele",
            creator: nil,
    //            date: Date(),
            description: "Historic pizzeria in Naples.",
            picture: "https://example.com/damichele.jpg",
            location: "Naples",
            coordinates: GeoPoint(latitude: 40.8478, longitude: 14.2624)
        ),
        Monument(
            name: "Cupertino",
            creator: nil,
    //            date: Date(),
            description: "Test location",
            picture: "https://example.com/damichele.jpg",
            location: "San Francisco",
            coordinates: GeoPoint(latitude: 37.7952, longitude: -122.4029)
        )
    ]
    
    @StateObject var viewModel = ContentViewModel()
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
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Map(position: $cameraPosition) {
                        UserAnnotation()
                        ForEach(monuments, id: \.id) { monument in
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
                    .disabled(isPopupVisible) // Disable map interaction when popup is visible
                    .edgesIgnoringSafeArea(.top)
                    .frame(maxHeight: .infinity)
                    .onAppear {
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
                .disabled(isPopupVisible)
                .edgesIgnoringSafeArea(.top)
                .frame(maxHeight: .infinity)
                .onAppear {
                    viewModel.checkIfLocationIsEnabled()
                else{
                    MapButtonsView(navigateToProfile: $navigateToProfile, navigateToWishlist: $navigateToWishlist, isSheetPresented: $isSheetPresented)
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

            // Mostrar ResultView sobre la vista principal
            if isResultPresented, let image = selectedImage, let result = detectionResult {
                ResultView(image: image, result: result, isPresented: $isResultPresented, isSheetPresented: $isSheetPresented, showImagePicker: $showImagePicker)
                    .frame(width: 300, height: 450)
                    .cornerRadius(12)
                    .shadow(radius: 10)
                    .zIndex(2)
            }

            // Mostrar popup de monumentos
            if isPopupVisible, let monument = selectedMonument {
                MonumentDetail(
                    isPresented: $isPopupVisible,
                    placeName: monument.name,
                    onGetBadge: {
                        print("Get Badge tapped for \(monument.name)")
                        isPopupVisible = false
                    },
                    onAddToWishlist: {
                        print("Add to Wishlist tapped for \(monument.name)")
                        isPopupVisible = false
                    }
                )
                .transition(.move(edge: .bottom))
                .animation(.spring())
                .frame(width: 180)
                .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 3)
                .transition(.scale)
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
