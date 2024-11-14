//
//  MonuMapApp.swift
//  MonuMap
//
//  Created by Sebastian Presno on 07/11/24.
//

import SwiftUI
import FirebaseCore

//@main
//struct MonuMapApp: App {
//  // register app delegate for Firebase setup
//  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//    
//    @State private var appController = AppController()
//
//
//  var body: some Scene {
//    WindowGroup {
//      NavigationView {
//          ContentView()
//              .environment(appController)
//              .onAppear{
//                  appController.listenToAuthChanges()
//              }
//      }
//    }
//  }
//}

@main
struct MonuMapApp: App{
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                Root()
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
