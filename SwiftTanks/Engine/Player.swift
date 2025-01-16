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
    case bouncy
    case tanky
}

class Player: Identifiable {
    let id = UUID()
    
    let color: Color
    let maxSpeed: Double
    
    var position: CGPoint
    var angle: Angle
    var health: Double
    
    init(color: Color, maxSpeed: Double, position: CGPoint, angle: Angle, health: Double) {
        self.color = color
        self.maxSpeed = maxSpeed
        self.position = position
        self.angle = angle
        self.health = health
    }
}


class PlayerFactory {
    
    func createPlayer(type: PlayerType, color: Color, position: CGPoint, angle: Angle) -> Player {
        
        var player: Player
        
        switch type {
        case .fast:
            player = Player(color: color, maxSpeed: 150, position: position, angle: angle, health: 100)
        case .tanky:
            player = Player(color: color, maxSpeed: 90, position: position, angle: angle, health: 150)
        default:
            player = Player(color: color, maxSpeed: 100, position: position, angle: angle, health: 100)
        }
        
        return player
    }
    
}
