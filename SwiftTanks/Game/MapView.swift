//
//  MapView.swift
//  SwiftTanks
//
//  Created by Marcel Chołodecki on 17/01/2025.
//

import SwiftUI

struct MapView: View {
    @EnvironmentObject var globalData: GlobalData
    var body: some View {
        ZStack(alignment: .center) {
            Color(.white).ignoresSafeArea()
            
            ForEach(globalData.getPlayers()) {
                Circle()
                    .foregroundStyle($0.color)
                    .frame(width: 50, height: 50)
                    .position($0.position)
            }
            
            ForEach(globalData.bullets) { bullet in
                Circle()
                    .frame(width: bullet.size, height: bullet.size)
                    .position(bullet.position)
                    .foregroundStyle(bullet.owner.color)
            }
        }
    }
}
