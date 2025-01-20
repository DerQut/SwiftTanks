//
//  PerPlayerVictoryScreenView.swift
//  SwiftTanks
//
//  Created by Marcel Chołodecki on 20/01/2025.
//

import SwiftUI

struct PerPlayerVictoryScreenView: View {
    
    @EnvironmentObject var globalData: GlobalData
    
    let playerDelegateID: Int
    
    var player: Player {
        return globalData.players[playerDelegateID]
    }
    
    var victoryText: String {
        if globalData.playerHealthAtEndOfGame.filter({$0 <= 0}).count != 1 {
            return "It's a tie!"
        }
        return player.health > 0 ? "You won!" : "You lost."
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .foregroundStyle(player.color)
                .opacity(0.5)
            
            VStack(spacing: 80) {
                Text(self.victoryText)
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
                                .frame(width: 200)
                                .foregroundStyle(player.color)
                        })
                    .buttonStyle(.bordered)
                    .font(.largeTitle)
                    
                    Button(
                        action: {
                            globalData.currentScreen = .mainMenu
                        },
                        label: {
                            Text("Main menu")
                                .frame(width: 200)
                        })
                    .buttonStyle(.borderedProminent)
                    .tint(player.color)
                    .font(.largeTitle)
                }
            }
            .padding()
            .padding()
            .scaledToFit()
        }.frame(width: 720, height: 560)
    }
}

#Preview {
    PerPlayerVictoryScreenView(playerDelegateID: 0)
        .environmentObject(GlobalData())
}
