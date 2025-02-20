//
//  MainTabView.swift
//  TastyHub
//
//  Created by Роман  on 20.02.2025.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            RecipeListView() 
                .tabItem {
                    Label("Главная", systemImage: "house.fill")
                }

            FavoritesView()
                .tabItem {
                    Label("Избранное", systemImage: "heart.fill")
                }

            SettingsView()
                .tabItem {
                    Label("Настройки", systemImage: "gearshape.fill")
                }
        }
    }
}

#Preview {
    MainTabView()
}
