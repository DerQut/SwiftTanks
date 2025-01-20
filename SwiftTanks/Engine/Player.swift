//
//  Player.swift
//  SwiftTanks
//
//  Created by Marcel Chołodecki on 16/01/2025.
//

import Foundation
import SwiftUI

enum PlayerType: String, CaseIterable, Identifiable {
    case normal
    case fast
    case tanky
    
    var id: String { self.rawValue.capitalized }
}

class Player: Entity {
    let id = UUID()
    let type: PlayerType
    
    let color: Color
    let maxSpeed: Double
    let bulletType: BulletType
    let bulletFactory: BulletFactory?
    
    var position: CGPoint
    var angle: Angle
    let size: CGFloat
    
    var velocity: CGFloat
    let maxHealth: Double
    var health: Double
    
    init(type: PlayerType, bulletType: BulletType, color: Color, size: CGFloat, maxSpeed: Double, position: CGPoint, angle: Angle, maxHealth: Double) {
        self.type = type
        self.bulletType = bulletType
        self.color = color
        self.maxSpeed = maxSpeed
        self.position = position
        self.angle = angle
        self.health = maxHealth
        self.maxHealth = maxHealth
        self.velocity = 0.0
        self.size = size
        
        self.bulletFactory = BulletFactory()
    }
    
    func createBullet() throws -> Bullet {
        if self.bulletFactory != nil {
            return self.bulletFactory!.createBullet(owner: self)
        }
        throw EngineError.missingBulletFactory
    }
    
}


class PlayerFactory {
    
    func createPlayer(type: PlayerType, bulletType: BulletType, color: Color, position: CGPoint, angle: Angle) -> Player {
        
        var player: Player
        
        switch type {
        case .fast:
            player = Player(type: type, bulletType: bulletType, color: color, size: 50, maxSpeed: 2, position: position, angle: angle, maxHealth: 80)
        case .tanky:
            player = Player(type: type, bulletType: bulletType, color: color, size: 60,  maxSpeed: 1, position: position, angle: angle, maxHealth: 150)
        default:
            player = Player(type: type, bulletType: bulletType, color: color, size: 50, maxSpeed: 1.5, position: position, angle: angle, maxHealth: 100)
        }
        
        return player
    }
    
}
