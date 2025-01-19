//
//  ContentView.swift
//  SwiftTanks
//
//  Created by Marcel Chołodecki on 11/01/2025.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var globalData: GlobalData
                
    var body: some View {
        ZStack {
            BackgroundGradient()
                .environmentObject(globalData)
                .ignoresSafeArea()
            
            switch globalData.currentScreen {
            case .mainMenu:
                MainMenuView()
            case .game:
                GameView()
            case .victoryScreen:
                VictoryScreenView()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(GlobalData())
}
