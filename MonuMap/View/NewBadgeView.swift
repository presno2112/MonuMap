//
//  NewBadgeView.swift
//  MonuMap
//
//  Created by Sebastian Presno on 16/11/24.
//

import SwiftUI

struct NewBadgeView: View {
    @State private var isFlipped: Bool = false
    @State private var inputImage : UIImage?
    @State var isInfoPressed : Bool = false
    @State var isDownloaded : Bool = false
    @Binding var showBadge: Bool
    @Binding var unlockedBadge: Badge?
    
    var body: some View {
        ZStack{
            Color("backgroundCard")
                .opacity(0.5)
                .blur(radius: 50)
            VStack{
                Spacer()
                Text("You unlocked")
                    .multilineTextAlignment(.center)
                    .font(.title2)
                    .bold()
                    .padding(.horizontal)
                Text("\(unlockedBadge?.name ?? "unknown")!")
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .bold()
                    .padding(.horizontal)
                
                Spacer()
                ZStack {
                    Image(isFlipped ? "photoTaken" : unlockedBadge?.image ?? "")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipped()
                        .opacity(isInfoPressed ? 0.7 : 1)
                        .blur(radius: isInfoPressed ? 70 : 0)
                    VStack{
                        Spacer()
                        // Button positioned using an overlay
                        HStack{
                            Spacer()
                            Button {
                                isInfoPressed.toggle()
                            } label: {
                                Image(systemName: "info.circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.white)
                                    .opacity(0.8)
                            }
                            .padding(16)
                        }
                    }
                    Text(unlockedBadge?.description ?? "No description")
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
                            inputImage = UIImage(named: unlockedBadge?.image ?? "coliseo")
                            
                            guard let inputImage = inputImage else {
                                print("Error: Could not load the image.")
                                return
                            }
                            
                            let imageSaver = ImageSaver()
                            imageSaver.writeToPhotoAlbum(image: inputImage)
                            isDownloaded = true
                            print("isDownloaded set to: \(isDownloaded)") // Debugging print
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
                            inputImage = UIImage(named: unlockedBadge?.image ?? "coliseo")
                            
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
                
                .padding(.bottom, 90)
            }
            .padding(.top, 80)
            VStack() {
                HStack {
                    Spacer()
                    Button(action: {
                        showBadge = false
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .shadow(radius: 2)
                    }
                    .padding(.vertical, 70)
                    .padding(.horizontal, 50)
                }
                Spacer()
            }
            Image(systemName: "sparkles")
                .foregroundStyle(Color.blue)
                .frame(width: 20, height: 20)
                .modifier(ParticlesModifier())
                .offset(x: -100, y : -50)
            
            Image(systemName: "sparkles")
                .foregroundStyle(Color.red)
                .frame(width: 20, height: 20)
                .modifier(ParticlesModifier())
                .offset(x: 60, y : 70)
            Image(systemName: "sparkles")
                .foregroundStyle(Color.blue)
                .frame(width: 20, height: 20)
                .modifier(ParticlesModifier())
                .offset(x: -100, y : -50)
            
            Image(systemName: "sparkles")
                .foregroundStyle(Color.red)
                .frame(width: 20, height: 20)
                .modifier(ParticlesModifier())
                .offset(x: 60, y : 70)
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
//    NewBadgeView(showBadge: .constant(false))
//}
