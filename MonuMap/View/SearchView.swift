//
//  SearchView.swift
//  MonuMap
//
//  Created by Sebastian Presno on 07/11/24.
//



import SwiftUI
import CoreML
import Vision

struct SearchView: View {
    @Binding var isSheetPresented: Bool
    @Binding var selectedImage: UIImage?
    @Binding var detectionResult: String?
    @Binding var isResultPresented: Bool

    @State private var searchText: String = ""
    @State private var currentHeight: CGFloat = 0
    @Binding var showImagePicker: Bool
    @State private var settingsViewModel = SettingsViewModel()
    @State private var classifier = Classifier() // Asume que tienes un ImageClassifier implementado

    // Example list of monuments
    var monuments: [(image: UIImage, title: String, description: String)] = [
        (UIImage(named: "coliseo")!, "Eiffel Tower", "Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum"),
        (UIImage(named: "coliseo")!, "Louvre Museum", "Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum"),
        (UIImage(named: "coliseo")!, "Notre Dame Cathedral", "Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum")
    ]

    var filteredMonuments: [(image: UIImage, title: String, description: String)] {
        if searchText.isEmpty {
            return monuments
        } else {
            return monuments.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(spacing: 0) {
                    // Barra de búsqueda y botón de cámara
                    HStack {
                        SearchBar(searchText: $searchText)
                            .padding(.leading)
                        Button {
                            showImagePicker = true
                        } label: {
                            Image(systemName: "camera.circle.fill")
                                .font(.largeTitle)
                        }
                        .padding()
                    }
                    .padding(.horizontal)
                    .padding(.top, currentHeight <= 50 ? 0 : 10)

                    // Contenido principal
                    CityMonumentsView()

                    // Botón de logout
                    Button {
                        Task {
                            do {
                                try settingsViewModel.signOut()
                            } catch {
                                print(error)
                            }
                        }
                    } label: {
                        Image(systemName: "camera.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(Color("MainBlue"))
                    }

                    Spacer()
                }
                .onAppear {
                    currentHeight = geometry.size.height
                }
                .onChange(of: geometry.size.height) { newHeight in
                    currentHeight = newHeight
                }
                .fullScreenCover(isPresented: $showImagePicker) {
                    ImagePicker(selectedImage: $selectedImage)
                }
                .onChange(of: selectedImage) { newImage in
                    if let uiImage = newImage, let ciImage = CIImage(image: uiImage) {
                        var classifierInstance = classifier
                        classifierInstance.detect(ciImage: ciImage)
                        detectionResult = classifierInstance.results
                        isResultPresented = true // Activa la presentación de ResultView en MapView
                        isSheetPresented = false // Cierra el sheet de búsqueda
                    else {
                        CityMonumentsView()
//                        CityMonumentsView(cityName: "Napoli")
//                        CityMonumentsView(cityName: "Roma", monuments: filteredMonuments)
//                        CityMonumentsView(cityName: "Napoli", monuments: filteredMonuments)
                    }
                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                    }
                }
            }
        }
    }
}


//#Preview {
//    SearchView(isSheetPresented: .constant(true))
//}
