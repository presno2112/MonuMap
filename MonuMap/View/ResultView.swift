//
//  ResultView.swift
//  MonuMap
//
//  Created by Hector Daniel Valdes Salas on 16/11/24.
//

import SwiftUI

struct ResultView: View {
    var image: UIImage
    var result: String
    @Binding var isPresented: Bool // Controlará la presentación de la vista
    @Binding var isSheetPresented: Bool
    @Binding var showImagePicker: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 300, height: 450)
                .foregroundStyle(.gray)
            VStack(spacing: 20) {
                
                Text(result)
                    .font(.title2)
                    .foregroundStyle(.black)
                    .bold()
                    .padding()
                
                ZStack{
                    Rectangle()
                        .foregroundStyle(.white, .opacity(0.5))
                        .frame(width: 200, height: 240)
                    
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 180, height: 180)
                        .clipped()
                        .padding(.bottom, 60)
                        .padding(.top, 20)
                }
                .padding(.top, -20)
                
                Text("Is \(result) the place you want to MonuMap")
                    .font(.system(size: 12))
                    .multilineTextAlignment(.center)
                    .frame(width: 200, alignment: .center)
                
                HStack{
                    Button {
                        showImagePicker = true
                        isPresented = false
                        isSheetPresented = true
                    } label: {
                        Text("Retake")
                            .foregroundColor(.white)
                            .frame(width: 100, height: 30)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    
                    Button {
                        isPresented = false
                        isSheetPresented = true
                    } label: {
                        Text("Confirm")
                            .foregroundColor(.white)
                            .frame(width: 100, height: 30)
                            .background(.blue)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                }
            }
        }
        
    }
}

//#Preview {
//    ResultView(image: "coliseo", result: "coliseo", isPresented: .constant(true))
//}