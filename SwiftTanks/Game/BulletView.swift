//
//  BulletView.swift
//  SwiftTanks
//
//  Created by Marcel Chołodecki on 18/01/2025.
//

import Foundation
import SwiftUI

public struct BulletView: View {
    
    @EnvironmentObject var globalData: GlobalData
    
    var bullet: Bullet
    
    public var body: some View {
        Circle()
            .fill(bullet.owner.color)
            .scaledToFill()
    }
}
