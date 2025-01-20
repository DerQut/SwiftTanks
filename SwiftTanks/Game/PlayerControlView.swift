//
//  PlayerControlView.swift
//  SwiftTanks
//
//  Created by Marcel Chołodecki on 11/01/2025.
//

import SwiftUI

struct PlayerControlView: View {
    
    @EnvironmentObject var globalData: GlobalData
    
    let forceAngleOffset: CGFloat
    let playerDelegateID: Int
    
    var player: Player {
        return globalData.players[playerDelegateID]
    }
    
    public var body: some View {
        ZStack {
            Color(.gray)

                JoyStickView(forceAngleOffset: forceAngleOffset, playerDelegateID: playerDelegateID)
                    .offset(x: 120, y: 100)
            HStack {
                Circle()
                    .frame(width: 150, height: 150)
                    .offset(x: -9)
                    .opacity(0.0)
                
                Spacer()
                
                ProgressView(value: player.health, total: player.maxHealth)
                    .frame(width: player.maxHealth)
                    .scaleEffect(x: 3, y: 15)
                    .tint(player.color)

                
                Spacer()
                
                Button(
                    action: {
                        do {
                            try globalData.fire(fromPlayerWithID: playerDelegateID)
                        } catch EngineError.invalidPlayerID {
                            print("Invalid player ID in PlayerControlView button action")
                        } catch {
                            print("Unknown error in PlayerControlView")
                        }
                    },
                   label: {
                    Image(systemName: "pencil.tip")
                        .font(.largeTitle)
                })
                .buttonBorderShape(.circle)
                .buttonStyle(.borderedProminent)
                .tint(globalData.getPlayers()[playerDelegateID].color)
                .padding()
                .scaleEffect(1.2)
                .offset(x: -50)
                
            }
            .frame(width: UIScreen.main.bounds.size.width/1.47)
            .padding()
        }
    }
}

#Preview {
    ZStack {
        Color(.white)
            .ignoresSafeArea()
        PlayerControlView(forceAngleOffset: 0.0, playerDelegateID: 0)
            .opacity(0.5)
            .frame(height: 200)
    }
}
