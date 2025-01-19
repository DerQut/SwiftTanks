//
//  VictoryScreenView.swift
//  SwiftTanks
//
//  Created by Marcel Chołodecki on 18/01/2025.
//

import SwiftUI

struct VictoryScreenView: View {
    
    @EnvironmentObject var globalData: GlobalData
    
    var victoryText: String {
        if globalData.playerHealthAtEndOfGame.filter({$0 > 0}).count == 1 {
            return "Player \(globalData.playerHealthAtEndOfGame.firstIndex(of: globalData.playerHealthAtEndOfGame.max()!)! + 1) wins!"
        }
        return "It's a draw!"
    }
    
    var body: some View {
        VStack {
            Text(victoryText)
                .font(.largeTitle)
                .bold()
                .scaleEffect(1.5)
            HStack {
                Button(
                    action: {
                        globalData.rematch()
                    },
                    label: {
                        Text("Rematch")
                            .font(.largeTitle)
                            .frame(width: 200)
                    }
                ).buttonStyle(.bordered)
                
                Button(
                    action: {
                        globalData.currentScreen = .mainMenu
                    },
                    label: {
                        Text("Main menu")
                            .font(.largeTitle)
                            .frame(width: 200)
                    }
                ).buttonStyle(.borderedProminent)
            }
            .offset(y: 100)
        }
    }
}

