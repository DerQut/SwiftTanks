//
//  BackgroundGradient.swift
//  SwiftTanks
//
//  Created by Marcel Chołodecki on 19/01/2025.
//

import Foundation
import SwiftUI

struct BackgroundGradient: View {
    
    @EnvironmentObject var globalData: GlobalData
    
    var body: some View {
        HStack(spacing: 0) {
            
            Color(globalData.players[0]?.color ?? .blue)
                .frame(width: globalData.victoriousID == 0 ? 960 : 0)
            
            LinearGradient(gradient: Gradient(colors: [globalData.players[0]?.color ?? .blue, globalData.players[1]?.color ?? .red]), startPoint: .leading, endPoint: .trailing)
            
            Color(globalData.players[1]?.color ?? .red)
                .frame(width: globalData.victoriousID == 1 ? 960 : 0)
        }
        .animation(.default, value: globalData.victoriousID)
    }
}
