//
//  PlayerView.swift
//  SwiftTanks
//
//  Created by Marcel Chołodecki on 18/01/2025.
//

import SwiftUI
import Foundation

public struct PlayerView: View {
    @EnvironmentObject var globalData: GlobalData
    var player: Player
    public var body: some View {
        ZStack {
            Circle()
                .fill(player.color)
                .scaledToFill()
            Image(systemName: "arrowshape.up.fill")
            //Text("^")
                .foregroundStyle(.white)
                .scaledToFill()
                .scaleEffect(1.5)
                .opacity(0.8)
                .rotationEffect(.degrees(player.angle.degrees*(-1)))
        }
    }
}
