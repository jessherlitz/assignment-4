//
//  Project4App.swift
//  Project4
//
//  Created by Jessica Sampaio-Herlitz on 4/7/25.
//

import SwiftUI
import Firebase


@main
struct Project4App: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    class AppDelegate: NSObject, UIApplicationDelegate {
      func application(_ application: UIApplication,
                       didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()

        return true
      }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
