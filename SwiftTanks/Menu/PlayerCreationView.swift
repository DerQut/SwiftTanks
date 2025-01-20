//
//  PlayerCreationView.swift
//  SwiftTanks
//
//  Created by Marcel Chołodecki on 19/01/2025.
//

import Foundation
import SwiftUI

struct PlayerCreationView: View {
    
    @EnvironmentObject var globalData: GlobalData
    
    @State var pickedColor: Color = .blue
    @State var pickedTankType: PlayerType = .normal
    @State var pickedBulletType: BulletType = .normal
    
    @State var isReady: Bool = false
    
    let playerDelegateID: Int
    var player: Player {
        return globalData.players[playerDelegateID]
    }
    
    let playerFactory = PlayerFactory()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                //.frame(height: 500)
                .foregroundStyle(self.pickedColor)
                .opacity(0.5)
                .onAppear {
                    self.pickedColor = player.color
                    self.pickedTankType = player.type
                    self.pickedBulletType = player.bulletType
                }
            
            VStack(alignment: .leading, spacing: 20) {
                Text("Player \(playerDelegateID + 1)")
                    .font(.largeTitle)
                    .bold()
                    .scaleEffect(1.5, anchor: .leading)
                Divider()
                    .background(Color.white)
                
                HStack {
                    HStack {
                        Text("Tank type:")
                        Spacer()
                    }.frame(width: 100)

                    Picker("", selection: $pickedTankType) {
                        ForEach(PlayerType.allCases, id: \.self) { type in
                            Text(type.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .disabled(isReady)
                }
                
                HStack {
                    HStack {
                        Text("Bullet type:")
                        Spacer()
                    }.frame(width: 100)

                    Picker("", selection: $pickedBulletType) {
                        ForEach(BulletType.allCases, id: \.self) { type in
                            Text(type.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .disabled(isReady)
                }
                
                Spacer()
                HStack {
                    Spacer()
                    Text("Ready:")
                        .font(.title)
                        .padding()
                    Toggle("", isOn: $isReady).labelsHidden()
                }
            }
            .padding()
            .padding()
            .scaledToFit()
            .animation(.default, value: isReady)
            .onChange(of: globalData.currentScreen) {
                self.isReady = false
            }
            .onChange(of: isReady) {
                if isReady {
                    
                    globalData.players[self.playerDelegateID] = playerFactory.createPlayer(type: pickedTankType, bulletType: pickedBulletType, color: pickedColor, position: globalData.playerSpawnPoints[self.playerDelegateID], angle: .zero)

                    
                    globalData.playersReady += 1
                } else {
                    if globalData.playersReady > 0 {
                        globalData.playersReady -= 1
                    } else {
                        globalData.playersReady = 0
                    }
                }
            }
        }.frame(width: 720, height: 560)
    }
}
