//
//  TastyHubApp.swift
//  TastyHub
//
//  Created by Роман  on 11.12.2024.
//
import SwiftUI
import Firebase

@main
struct TastyHubApp: App {
    init() {
        
        FirebaseApp.configure()

    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

