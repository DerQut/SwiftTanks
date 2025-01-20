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
            
            GameView()
                .environmentObject(globalData)
            
            Color(.black)
                .opacity(globalData.currentScreen == .game ? 0 : 1)
                .ignoresSafeArea()
            
            MainMenuView()
                .environmentObject(globalData)
                .opacity(globalData.currentScreen == .mainMenu ? 1 : 0)
            
            VictoryScreenView()
                .environmentObject(globalData)
                .opacity(globalData.currentScreen == .victoryScreen ? 1 : 0)
            
        }
        .animation(.default, value: globalData.currentScreen)
    }
}

#Preview {
    ContentView()
        .environmentObject(GlobalData())
}
