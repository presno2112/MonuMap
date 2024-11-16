//
//  SearchView.swift
//  MonuMap
//
//  Created by Sebastian Presno on 07/11/24.
//

import SwiftUI

struct SearchView: View {
    @Binding var isSheetPresented: Bool
    @State var searchText: String = ""
    @State var currentHeight: CGFloat = 0
    @State var showImagePicker = false
    @State var selectedImage: UIImage?
    @State var detectionResult: String?
    var classifier = Classifier()
    //    @Environment(AppController.self) private var appController
    
    // Example list of monuments
    var monuments: [(image: UIImage, title: String, description: String)] = [
        (UIImage(named: "coliseo")!, "Eiffel Tower", "Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum"),
        (UIImage(named: "coliseo")!, "Louvre Museum", "Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum"),
        (UIImage(named: "coliseo")!, "Notre Dame Cathedral", "Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum")
    ]
    
    var filteredMonuments: [(image: UIImage, title: String, description: String)] {
        // Filter monuments based on searchText
        if searchText.isEmpty {
            return monuments
        } else {
            return monuments.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                HStack {
                    SearchBar(searchText: $searchText)
                        .padding(.leading)
                    Button {
                        showImagePicker = true
                    } label: {
                        Image(systemName: "camera.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(Color("mainBlue"))
                    }
                    .padding()
                }
                .padding(.horizontal)
                .padding(.top, currentHeight <= 50 ? 0 : 10)
                if let result = detectionResult {
                    Text("Resultado: \(result)")
                        .padding()
                    if filteredMonuments.count == 0 && searchText != "" {
                        Text("No results")
                    }
                }
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
                    
                    Spacer()
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(selectedImage: $selectedImage)
            }
            .onAppear {
                currentHeight = geometry.size.height
            }
            .onChange(of: geometry.size.height) { newHeight in
                currentHeight = newHeight
            }
            .onChange(of: selectedImage) { newImage in
                if let uiImage = newImage, let ciImage = CIImage(image: uiImage) {
                    var classifierInstance = classifier // Creando una instancia mutable
                    classifierInstance.detect(ciImage: ciImage)
                    detectionResult = classifierInstance.results
                }
            }
        }
    }
}


#Preview {
    SearchView(isSheetPresented: .constant(true))
}
