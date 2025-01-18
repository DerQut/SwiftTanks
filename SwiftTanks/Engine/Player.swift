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

class Player: Entity {
    let id = UUID()
    
    let color: Color
    let maxSpeed: Double
    let bulletType: BulletType
    let bulletFactory = BulletFactory()
    
    var position: CGPoint
    var angle: Angle
    let size: CGFloat
    
    var velocity: CGFloat
    var health: Double
    
    init(bulletType: BulletType, color: Color, size: CGFloat, maxSpeed: Double, position: CGPoint, angle: Angle, health: Double) {
        self.bulletType = bulletType
        self.color = color
        self.maxSpeed = maxSpeed
        self.position = position
        self.angle = angle
        self.health = health
        self.velocity = 0.0
        self.size = size
    }
}


class PlayerFactory {
    
    func createPlayer(type: PlayerType, bulletType: BulletType, color: Color, position: CGPoint, angle: Angle) -> Player {
        
        var player: Player
        
        switch type {
        case .fast:
            player = Player(bulletType: .normal, color: color, size: 50, maxSpeed: 2, position: position, angle: angle, health: 100)
        case .tanky:
            player = Player(bulletType: .normal, color: color, size: 60,  maxSpeed: 1, position: position, angle: angle, health: 150)
        default:
            player = Player(bulletType: .normal, color: color, size: 50, maxSpeed: 1.5, position: position, angle: angle, health: 100)
        }
        
        return player
    }
    
}
