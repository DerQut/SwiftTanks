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
        switch globalData.currentScreen {
        case .mainMenu:
            MainMenuView()
        case .game:
            GameView()
                .onReceive(globalData.timer) { _ in
                    if globalData.currentScreen == .game {
                        globalData.moveBullets()
                        globalData.movePlayers()
                        globalData.pushPlayersFromWalls()
                        globalData.updateView()
                    }
                }
        case .victoryScreen:
            VictoryScreenView()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(GlobalData())
}
