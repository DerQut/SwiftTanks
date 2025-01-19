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
            
            switch globalData.currentScreen {
            case .mainMenu:
                MainMenuView()
                    .environmentObject(globalData)
            case .game:
                GameView()
            case .victoryScreen:
                VictoryScreenView()
                    .onAppear() {
                        globalData.clearMap()
                    }
            }
        }
        .animation(.default, value: globalData.currentScreen)
    }
}

#Preview {
    ContentView()
        .environmentObject(GlobalData())
}
