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
            Color(.white)
            
            ForEach(globalData.walls) {
                Color(.gray)
                    .offset(x: $0.position.x, y: $0.position.y)
                    .frame(width: $0.size.width, height: $0.size.height)
            }
            
            ForEach(globalData.getPlayers()) {
                PlayerView(player: $0)
                    .frame(width: $0.size, height: $0.size)
                    .offset(x: $0.position.x, y:$0.position.y)
                    .environmentObject(globalData)
            }
            
            ForEach(globalData.bullets) {
                BulletView(bullet: $0)
                    .frame(width: $0.size, height: $0.size)
                    .offset(x: $0.position.x, y: $0.position.y)
                    .environmentObject(globalData)
            }
        }
    }
}
