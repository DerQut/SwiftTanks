//
//  Player.swift
//  SwiftTanks
//
//  Created by Marcel Chołodecki on 16/01/2025.
//

import Foundation
import SwiftUI

enum PlayerType {
    case fast
    case tanky
    case bouncy
}

class Player: Identifiable {
    let id = UUID()
    
    let color: Color
    let maxSpeed: Double
    let bulletType: BulletType
    
    var position: CGPoint
    var angle: Angle
    
    var velocity: CGFloat
    var health: Double
    
    init(bulletType: BulletType, color: Color, maxSpeed: Double, position: CGPoint, angle: Angle, health: Double) {
        self.bulletType = bulletType
        self.color = color
        self.maxSpeed = maxSpeed
        self.position = position
        self.angle = angle
        self.health = health
        self.velocity = 0.0
    }
}


class PlayerFactory {
    
    func createPlayer(type: PlayerType, bulletType: BulletType, color: Color, position: CGPoint, angle: Angle) -> Player {
        
        var player: Player
        
        switch type {
        case .fast:
            player = Player(bulletType: .normal, color: color, maxSpeed: 15, position: position, angle: angle, health: 100)
        case .tanky:
            player = Player(bulletType: .normal, color: color, maxSpeed: 9, position: position, angle: angle, health: 150)
        default:
            player = Player(bulletType: .normal, color: color, maxSpeed: 10, position: position, angle: angle, health: 100)
        }
        
        return player
    }
    
}
