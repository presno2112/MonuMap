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
    
    // Sample monuments data
    let monuments = [
        Monument(
            name: "Roman Colosseum",
            creator: nil,
            date: Date(),
            description: "Ancient amphitheater in Rome.",
            picture: "https://example.com/colosseum.jpg",
            location: "Rome",
            coordinates: GeoPoint(latitude: 41.8902, longitude: 12.4922)
        ),
        Monument(
            name: "Fontana di Trevi",
            creator: nil,
            date: Date(),
            description: "Famous Baroque fountain in Rome.",
            picture: "https://example.com/trevi.jpg",
            location: "Rome",
            coordinates: GeoPoint(latitude: 41.9009, longitude: 12.4833)
        ),
        Monument(
            name: "Castel Sant'Angelo",
            creator: nil,
            date: Date(),
            description: "Historic castle and museum.",
            picture: "https://example.com/santangelo.jpg",
            location: "Rome",
            coordinates: GeoPoint(latitude: 41.9031, longitude: 12.4663)
        ),
        Monument(
            name: "Basilica di San Pietro",
            creator: "Michelangelo",
            date: Date(),
            description: "St. Peter's Basilica in Vatican City.",
            picture: "https://example.com/stpeter.jpg",
            location: "Rome",
            coordinates: GeoPoint(latitude: 41.9029, longitude: 12.4534)
        ),
        Monument(
            name: "Piazza di Spagna",
            creator: nil,
            date: Date(),
            description: "Famous Spanish Steps in Rome.",
            picture: "https://example.com/spanishsteps.jpg",
            location: "Rome",
            coordinates: GeoPoint(latitude: 41.9059, longitude: 12.4823)
        ),
        Monument(
            name: "Bocca della Verità",
            creator: nil,
            date: Date(),
            description: "Ancient stone mask.",
            picture: "https://example.com/bocca.jpg",
            location: "Rome",
            coordinates: GeoPoint(latitude: 41.8886, longitude: 12.4812)
        ),
        Monument(
            name: "Monumento a Vittorio Emanuele II",
            creator: nil,
            date: Date(),
            description: "Monument in honor of Victor Emmanuel II.",
            picture: "https://example.com/vittorio.jpg",
            location: "Rome",
            coordinates: GeoPoint(latitude: 41.8955, longitude: 12.4823)
        ),
        Monument(
            name: "Maradona Mural",
            creator: nil,
            date: Date(),
            description: "Mural dedicated to Diego Maradona.",
            picture: "https://example.com/maradona.jpg",
            location: "Naples",
            coordinates: GeoPoint(latitude: 40.8543, longitude: 14.2584)
        ),
        Monument(
            name: "Cathedral of San Gennaro",
            creator: nil,
            date: Date(),
            description: "Naples Cathedral.",
            picture: "https://example.com/cathedral.jpg",
            location: "Naples",
            coordinates: GeoPoint(latitude: 40.8522, longitude: 14.2588)
        ),
        Monument(
            name: "Castel Nuovo",
            creator: nil,
            date: Date(),
            description: "Medieval castle in Naples.",
            picture: "https://example.com/nuovo.jpg",
            location: "Naples",
            coordinates: GeoPoint(latitude: 40.8383, longitude: 14.2544)
        ),
        Monument(
            name: "Pulcinella Statue",
            creator: nil,
            date: Date(),
            description: "Statue of Pulcinella.",
            picture: "https://example.com/pulcinella.jpg",
            location: "Naples",
            coordinates: GeoPoint(latitude: 40.8492, longitude: 14.2530)
        ),
        Monument(
            name: "Pizzeria Da Michele",
            creator: nil,
            date: Date(),
            description: "Historic pizzeria in Naples.",
            picture: "https://example.com/damichele.jpg",
            location: "Naples",
            coordinates: GeoPoint(latitude: 40.8478, longitude: 14.2624)
        )
    ]
    
    @StateObject var viewModel = ContentViewModel()
    @State private var isSheetPresented: Bool = true
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    
    var body: some View {
        VStack {
            Map(position: $cameraPosition) {
                UserAnnotation()
                ForEach(monuments, id: \.id) { monument in // Use id explicitly
                    let coordinate = monument.coordinates.toCLLocationCoordinate2D()
                    Annotation(monument.name ,coordinate: coordinate) {
                        Button(action: {
                            // Update camera position to the tapped marker's coordinates
                            cameraPosition = .region(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))
                        }) {
                            Circle()
                                .frame(width: 20, height: 20)
                        }
                    }
                    //{
//                        Text(monument.name)
//                            .font(.headline)
//                            .padding()
//                            .background(.blue)
//                            .foregroundStyle(.white)
//                            .clipShape(Capsule())
//                    }
                }
            }
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
                .interactiveDismissDisabled() // prevents dismissing the sheet
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
