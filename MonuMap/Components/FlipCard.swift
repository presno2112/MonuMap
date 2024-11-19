//
//  FlipCard.swift
//  MapKitTest
//
//  Created by Sebastian Presno on 06/11/24.
//

import SwiftUI

struct FlipCard: View {
    @Binding var showCard: Bool
    @Binding var selectedBadge: Badge?
    @State private var isFlipped: Bool = false
    @State private var inputImage : UIImage?
    @State var isInfoPressed : Bool = false
    @State var isDownloaded : Bool = false
    
    var body: some View {
        ZStack{
            Color("backgroundCard")
                .opacity(0.5)
                .blur(radius: 50)
            VStack{
                Spacer()
                ZStack {
                    Image(isFlipped ? "photoTaken" : selectedBadge?.image ?? "")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipped()
//                        .shadow(color: .gray, radius: 10)
                        .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
                        .animation(.easeInOut(duration: 0.6), value: isFlipped)
                        .onTapGesture {
                            isFlipped.toggle()
                        }
                        .blur(radius: isInfoPressed ? 70 : 0)
                        .opacity(isInfoPressed ? 0.7 : 1)
                        .disabled(isInfoPressed)
                    VStack{
                        Spacer()
                        // Button positioned using an overlay
                        HStack{
                            Spacer()
                            Button {
                                isInfoPressed.toggle()
                            } label: {
                                Image(systemName: "questionmark.circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.white)
                                    .opacity(0.8)
                            }
                            .padding(30)
                        }
                    }
                    Text(selectedBadge?.description ?? "No info loaded")
                        .multilineTextAlignment(.center)
                        .opacity(isInfoPressed ? 1 : 0)
                        .bold()
                        .foregroundStyle(.black)
                        .padding()
                        .padding(.horizontal, 16)
                }
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(width: 300, height: 400)
                Spacer()
                HStack {
                    Spacer()
                    VStack{
                        Button{
                            inputImage = UIImage(named: selectedBadge?.image ?? "coliseo")
                            
                            guard let inputImage = inputImage else {
                                print("Error: Could not load the image.")
                                return
                            }
                            
                            let imageSaver = ImageSaver()
                            imageSaver.writeToPhotoAlbum(image: inputImage)
                            isDownloaded = true
                        }label: {
                            ZStack {
                                Circle()
                                    .frame(width: 70, height: 70)
                                    .foregroundStyle(.white)
                                    .shadow(radius: 0.5)
                                Image(systemName: !isDownloaded ?  "arrow.down.circle" : "checkmark.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color("MainBlue"))
                                    .contentTransition(.symbolEffect(.replace))
                            }
                        }
                        .disabled(isDownloaded)
                        Text("Download")
                    }
                    Spacer()
                    VStack{
                        Button{
                            inputImage = UIImage(named: selectedBadge?.image ?? "coliseo")
                            
                            guard let inputImage = inputImage else {
                                print("Error: Could not load the image.")
                                return
                            }
                            shareImageToInstagramStories(image: inputImage)
                        }label: {
                            ZStack {
                                Circle()
                                    .foregroundStyle(.white)
                                    .frame(width: 70, height: 70)
                                    .shadow(radius: 0.5)
                                Image(systemName: "plus.circle.dashed")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color("MainBlue"))
                                
                            }
                        }
                        Text("Share")
                    }
                    Spacer()
                }
                .padding(.bottom, 120)
            }
            .padding(.top, 80)
        }
        .ignoresSafeArea()
        .onAppear{
            isDownloaded = false
        }
    }
    
    func shareImageToInstagramStories(image: UIImage) {
            guard let imageData = image.pngData() else {
                print("Unable to convert image to PNG data.")
                return
            }

            let appID = "8414728331909057"

            guard let urlScheme = URL(string: "instagram-stories://share?source_application=\(appID)") else {
                print("Invalid URL scheme.")
                return
            }

            if UIApplication.shared.canOpenURL(urlScheme) {
                let pasteboardItems = [
                    ["com.instagram.sharedSticker.backgroundImage": imageData]
                ]

                let pasteboardOptions: [UIPasteboard.OptionsKey: Any] = [
                    .expirationDate: Date().addingTimeInterval(60 * 5)
                ]

                UIPasteboard.general.setItems(pasteboardItems, options: pasteboardOptions)
                UIApplication.shared.open(urlScheme, options: [:], completionHandler: nil)
            } else {
                print("Instagram is not installed or cannot handle the URL.")
            }
        }
}

//#Preview {
//    FlipCard(showCard: .constant(true), selectedBadge: <#Binding<Badge?>#>, )
//}
